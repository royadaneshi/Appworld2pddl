"""Call Claude to convert AppWorld tasks into PDDL and write the results to disk."""
from __future__ import annotations

import json
import os
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass
from pathlib import Path

import anthropic

from .loader import Task, load_api_index, load_api_params, load_task
from .plan import DEFAULT_PLAN_TIMEOUT, solve_files
from .prompt import OUTPUT_SCHEMA, build_repair_prompt, build_system_prompt, build_user_prompt
from .validate import (api_action_names, api_param_issues, ground_plan, plan_order_issue,
                       reference_api_check, validate)

DEFAULT_MODEL = "claude-fable-5-1"
DEFAULT_EFFORT = "xhigh"
DEFAULT_MAX_TOKENS = 32000
KEY_ENV_VARS = ("CLAUD_KEY", "ANTHROPIC_API_KEY")


def load_dotenv(path: Path) -> None:
    """Minimal .env loader (KEY=VALUE lines); does not override existing env vars."""
    if not path.exists():
        return
    for line in path.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        key, value = key.strip(), value.strip().strip('"').strip("'")
        os.environ.setdefault(key, value)


def resolve_api_key() -> str | None:
    for name in KEY_ENV_VARS:
        value = os.environ.get(name)
        if value:
            return value
    return None


@dataclass
class ConvertConfig:
    out_dir: Path
    model: str = DEFAULT_MODEL
    effort: str = DEFAULT_EFFORT
    max_tokens: int = DEFAULT_MAX_TOKENS
    include_ground_truth: bool = True
    include_private: bool = False
    include_solution: bool = False
    force: bool = False
    workers: int = 4
    dry_run: bool = False
    use_fallbacks: bool = True
    run_planner: bool = True
    plan_only: bool = False
    repairs: int = 1
    plan_timeout: float = DEFAULT_PLAN_TIMEOUT


class Converter:
    def __init__(self, config: ConvertConfig, client: anthropic.Anthropic | None = None):
        self.config = config
        self.api_index = load_api_index()
        self.system_prompt = build_system_prompt(self.api_index)
        self.valid_actions = api_action_names(self.api_index)
        self.api_table = load_api_params()
        self.client = client
        if client is None and not config.dry_run and not getattr(config, 'plan_only', False):
            api_key = resolve_api_key()
            if not api_key:
                raise SystemExit(
                    "No API key found. Set CLAUD_KEY (or ANTHROPIC_API_KEY) in the environment "
                    "or in a .env file next to main.py."
                )
            self.client = anthropic.Anthropic(api_key=api_key, max_retries=5)
        self._log_lock = threading.Lock()
        self.config.out_dir.mkdir(parents=True, exist_ok=True)
        self.summary_path = self.config.out_dir / "_summary.jsonl"
        if not config.dry_run and not config.plan_only:
            run_config = {
                "model": config.model, "effort": config.effort, "max_tokens": config.max_tokens,
                "include_ground_truth": config.include_ground_truth,
                "include_private": config.include_private,
                "include_solution": config.include_solution,
                "repairs": config.repairs, "plan_timeout": config.plan_timeout,
                "started_at": time.strftime("%Y-%m-%dT%H:%M:%S"),
            }
            (self.config.out_dir / "_run_config.json").write_text(json.dumps(run_config, indent=2))

    # ------------------------------------------------------------------ API call
    def _request_kwargs(self, messages: list[dict]) -> dict:
        kwargs = dict(
            model=self.config.model,
            max_tokens=self.config.max_tokens,
            system=[{
                "type": "text",
                "text": self.system_prompt,
                "cache_control": {"type": "ephemeral"},
            }],
            messages=messages,
            output_config={
                "effort": self.config.effort,
                "format": {"type": "json_schema", "schema": OUTPUT_SCHEMA},
            },
        )
        if self.config.use_fallbacks:
            kwargs["betas"] = ["server-side-fallback-2026-07-01"]
            kwargs["fallbacks"] = "default"
        return kwargs

    def call_claude(self, messages: list[dict]) -> tuple[dict, dict, object]:
        """Return (parsed_json, meta, response). Raises on API errors or refusals."""
        kwargs = self._request_kwargs(messages)
        with self.client.beta.messages.stream(**kwargs) as stream:
            response = stream.get_final_message()

        if response.stop_reason == "refusal":
            details = getattr(response, "stop_details", None)
            category = getattr(details, "category", None) if details else None
            raise RuntimeError(f"Claude refused the request (category={category})")
        if response.stop_reason == "max_tokens":
            raise RuntimeError("Response hit max_tokens; raise --max-tokens and retry")

        text = next((b.text for b in response.content if b.type == "text"), "")
        data = json.loads(text)
        usage = response.usage
        meta = {
            "model": response.model,
            "stop_reason": response.stop_reason,
            "request_id": getattr(response, "_request_id", None),
            "usage": {
                "input_tokens": usage.input_tokens,
                "output_tokens": usage.output_tokens,
                "cache_creation_input_tokens": getattr(usage, "cache_creation_input_tokens", 0) or 0,
                "cache_read_input_tokens": getattr(usage, "cache_read_input_tokens", 0) or 0,
            },
        }
        return data, meta, response

    # ------------------------------------------------------------------ per task
    def task_out_dir(self, task_id: str) -> Path:
        return self.config.out_dir / task_id

    def is_done(self, task_id: str) -> bool:
        d = self.task_out_dir(task_id)
        return (d / "domain.pddl").exists() and (d / "problem.pddl").exists() and (d / "meta.json").exists()

    def convert_task(self, task_id: str) -> dict:
        task: Task = load_task(task_id)
        user_prompt = build_user_prompt(
            task,
            include_ground_truth=self.config.include_ground_truth,
            include_private=self.config.include_private,
            include_solution=self.config.include_solution,
        )
        solution_used = self.config.include_solution and task.has_solution
        out = self.task_out_dir(task_id)

        if self.config.dry_run:
            out.mkdir(parents=True, exist_ok=True)
            (out / "prompt.txt").write_text(user_prompt)
            return {"task_id": task_id, "status": "dry_run", "prompt_chars": len(user_prompt)}

        if self.is_done(task_id) and not self.config.force:
            return {"task_id": task_id, "status": "skipped"}

        started = time.time()
        out.mkdir(parents=True, exist_ok=True)
        (out / "prompt.txt").write_text(user_prompt)
        messages: list[dict] = [{"role": "user", "content": user_prompt}]
        attempts: list[dict] = []
        total_usage = {"input_tokens": 0, "output_tokens": 0,
                       "cache_creation_input_tokens": 0, "cache_read_input_tokens": 0}

        for attempt in range(1 + max(0, self.config.repairs)):
            data, meta, response = self.call_claude(messages)
            for k in total_usage:
                total_usage[k] += meta["usage"][k]
            domain = data["domain_pddl"].strip() + "\n"
            problem = data["problem_pddl"].strip() + "\n"
            report = validate(domain, problem, self.valid_actions)
            report["api_issues"] = api_param_issues(domain, data.get("action_params", []), self.api_table)
            report["reference_check"] = reference_api_check(domain, task.required_apis, self.api_table)
            if solution_used and report["reference_check"] and report["reference_check"]["missing"]:
                report["api_issues"].append(
                    f"required reference APIs have no action: {report['reference_check']['missing']}")
            (out / "domain.pddl").write_text(domain)
            (out / "problem.pddl").write_text(problem)
            (out / "action_params.json").write_text(json.dumps(data.get("action_params", []), indent=2))
            (out / "bindings.json").write_text(json.dumps(data.get("bindings", []), indent=2))
            planning = self.plan_task(out) if (self.config.run_planner and report["ok"]) else None
            status = self._status(report, planning)
            if planning and planning.get("plan"):
                grounded = ground_plan(planning["plan"], data.get("action_params", []),
                                       data.get("bindings", []), self.api_table)
                (out / "plan_calls.json").write_text(json.dumps(grounded, indent=2))
                if grounded["problems"]:
                    report["api_issues"].extend(grounded["problems"])
                    if status == "solved":
                        status = "incomplete_actions"
            attempts.append({"attempt": attempt + 1, "status": status,
                             "errors": report["errors"], "warnings": report["warnings"],
                             "api_issues": report.get("api_issues", []),
                             "planning_status": planning["status"] if planning else None,
                             "planning_message": (planning or {}).get("message", "")})
            if status in ("solved", "ok") or attempt >= self.config.repairs:
                break
            # Repair round: continue the conversation with the concrete failure.
            messages.append({"role": "assistant", "content": response.content})
            messages.append({"role": "user", "content": build_repair_prompt(report, planning)})

        meta["usage"] = total_usage
        meta.update({
            "task_id": task_id,
            "instruction": task.instruction,
            "difficulty": task.metadata.get("difficulty"),
            "apps_used": data.get("apps_used", []),
            "api_sequence": data.get("api_sequence", []),
            "notes": data.get("notes", ""),
            "validation": report,
            "planning": planning,
            "solution_used": solution_used,
            "has_reference_solution": task.has_solution,
            "attempts": attempts,
            "seconds": round(time.time() - started, 1),
            "effort": self.config.effort,
        })
        (out / "meta.json").write_text(json.dumps(meta, indent=2))
        return {
            "task_id": task_id,
            "status": status,
            "attempts": len(attempts),
            "errors": report["errors"],
            "warnings": report["warnings"],
            "api_issues": report.get("api_issues", []),
            "reference_check": report.get("reference_check"),
            "solution_used": solution_used,
            "planning": planning,
            "usage": meta["usage"],
            "seconds": meta["seconds"],
        }

    @staticmethod
    def _status(report: dict, planning: dict | None) -> str:
        if not report["ok"]:
            return "invalid_pddl"
        if planning is None:
            status = "ok"
        else:
            status = planning["status"]
        if status in ("ok", "solved") and report.get("api_issues"):
            return "incomplete_actions"
        return status

    def plan_task(self, out: Path) -> dict:
        result = solve_files(out / "domain.pddl", out / "problem.pddl", self.config.plan_timeout)
        plan_file = out / "plan.txt"
        if result.get("plan") is not None:
            plan_file.write_text("\n".join(result["plan"]) + "\n")
            if result["status"] == "solved":
                issue = plan_order_issue(result["plan"])
                if issue:
                    result["status"] = "bad_plan_order"
                    result["message"] = issue
        elif plan_file.exists():
            plan_file.unlink()
        return result

    def recheck_task(self, task_id: str) -> dict:
        """Re-validate and re-plan an existing output directory without calling the API."""
        out = self.task_out_dir(task_id)
        domain = (out / "domain.pddl").read_text()
        problem = (out / "problem.pddl").read_text()
        report = validate(domain, problem, self.valid_actions)
        ap_path, b_path = out / "action_params.json", out / "bindings.json"
        action_params = json.loads(ap_path.read_text()) if ap_path.exists() else []
        bindings = json.loads(b_path.read_text()) if b_path.exists() else []
        report["api_issues"] = api_param_issues(domain, action_params, self.api_table)
        try:
            report["reference_check"] = reference_api_check(domain, load_task(task_id).required_apis, self.api_table)
        except FileNotFoundError:
            report["reference_check"] = None
        planning = self.plan_task(out) if (self.config.run_planner and report["ok"]) else None
        if planning and planning.get("plan"):
            grounded = ground_plan(planning["plan"], action_params, bindings, self.api_table)
            (out / "plan_calls.json").write_text(json.dumps(grounded, indent=2))
            report["api_issues"].extend(grounded["problems"])
        meta_path = out / "meta.json"
        meta = json.loads(meta_path.read_text()) if meta_path.exists() else {"task_id": task_id}
        meta["validation"] = report
        meta["planning"] = planning
        meta_path.write_text(json.dumps(meta, indent=2))
        return {"task_id": task_id, "status": self._status(report, planning),
                "errors": report["errors"], "warnings": report["warnings"],
                "api_issues": report.get("api_issues", []),
                "reference_check": report.get("reference_check"), "planning": planning}

    def _safe_convert(self, task_id: str) -> dict:
        return self._guarded(self.convert_task, task_id)

    def _safe_recheck(self, task_id: str) -> dict:
        return self._guarded(self.recheck_task, task_id)

    def _guarded(self, fn, task_id: str) -> dict:
        try:
            result = fn(task_id)
        except Exception as e:  # noqa: BLE001 - one task failing must not stop the run
            result = {"task_id": task_id, "status": "error", "error": f"{type(e).__name__}: {e}"}
        with self._log_lock:
            with self.summary_path.open("a") as f:
                f.write(json.dumps(result) + "\n")
        return result

    # ------------------------------------------------------------------ batch run
    def run(self, task_ids: list[str], progress=print, recheck: bool = False) -> list[dict]:
        results: list[dict] = []
        total = len(task_ids)
        workers = 1 if self.config.dry_run else max(1, self.config.workers)
        fn = self._safe_recheck if recheck else self._safe_convert
        with ThreadPoolExecutor(max_workers=workers) as pool:
            futures = {pool.submit(fn, tid): tid for tid in task_ids}
            for i, fut in enumerate(as_completed(futures), 1):
                r = fut.result()
                results.append(r)
                extra = ""
                if r["status"] == "error":
                    extra = f" {(r.get('error') or (r.get('planning') or {}).get('message', ''))[:160]}"
                elif r["status"] == "invalid_pddl":
                    extra = f" {'; '.join(r['errors'])[:160]}"
                elif r["status"] == "incomplete_actions":
                    extra = f" {'; '.join(r.get('api_issues', []))[:160]}"
                elif r.get("planning") and r["planning"].get("plan"):
                    extra = f" plan={len(r['planning']['plan'])} steps"
                elif r.get("planning"):
                    extra = f" {r['planning'].get('message', '')[:160]}"
                if r.get("solution_used"):
                    extra += " [solution]"
                ref = r.get("reference_check")
                if ref and (ref["missing"] or ref["extra"]):
                    extra += f" ref:missing={ref['missing']} extra={ref['extra']}"
                if r.get("attempts", 1) > 1:
                    extra += f" attempts={r['attempts']}"
                if "usage" in r:
                    u = r["usage"]
                    extra += (f" in={u['input_tokens']} cached={u['cache_read_input_tokens']} "
                              f"out={u['output_tokens']} {r['seconds']}s")
                progress(f"[{i}/{total}] {r['task_id']} {r['status']}{extra}")
        return results


def summarize(results: list[dict]) -> str:
    counts: dict[str, int] = {}
    tokens = {"input_tokens": 0, "output_tokens": 0, "cache_read_input_tokens": 0,
              "cache_creation_input_tokens": 0}
    for r in results:
        counts[r["status"]] = counts.get(r["status"], 0) + 1
        for k in tokens:
            tokens[k] += r.get("usage", {}).get(k, 0)
    lines = ["status counts: " + ", ".join(f"{k}={v}" for k, v in sorted(counts.items()))]
    if any(tokens.values()):
        lines.append("tokens: " + ", ".join(f"{k}={v}" for k, v in tokens.items()))
    return "\n".join(lines)
