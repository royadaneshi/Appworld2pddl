"""Solvability check: run Fast Downward (via unified-planning) on a domain/problem pair.

The planner runs in a child process so a hang or crash cannot take down the conversion run.
Usage as a script (prints JSON):  python -m appworld2pddl.plan domain.pddl problem.pddl [timeout]
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
import tempfile
import time
from pathlib import Path

DEFAULT_PLAN_TIMEOUT = 60  # seconds given to Fast Downward's search

SOLVED = {"SOLVED_SATISFICING", "SOLVED_OPTIMALLY"}
UNSOLVABLE = {"UNSOLVABLE_PROVEN", "UNSOLVABLE_INCOMPLETELY"}


def _format_step(action_instance) -> str:
    """Standard PDDL plan syntax: (action-name arg1 arg2), as accepted by VAL / IPC tools."""
    name = action_instance.action.name
    args = [str(p) for p in action_instance.actual_parameters]
    return "(" + " ".join([name, *args]) + ")"


def _solve_in_process(domain_path: str, problem_path: str, timeout: float) -> dict:
    """Parse and plan. Runs inside the child process."""
    started = time.time()
    try:
        import unified_planning as up
        from unified_planning.io import PDDLReader
        from unified_planning.shortcuts import OneshotPlanner

        up.shortcuts.get_environment().credits_stream = None
        try:
            problem = PDDLReader().parse_problem(domain_path, problem_path)
        except Exception as e:  # noqa: BLE001 - any parse/type error is a model error
            msg = f"{type(e).__name__}: {str(e)[:400]}"
            if isinstance(e, KeyError):
                msg += " (a type, object, or predicate is used but never declared)"
            return {"status": "parse_error", "message": msg,
                    "plan": None, "seconds": round(time.time() - started, 2)}

        with OneshotPlanner(name="fast-downward") as planner:
            result = planner.solve(problem, timeout=timeout)
        status_name = result.status.name
        if status_name in SOLVED:
            status = "solved"
        elif status_name in UNSOLVABLE:
            status = "unsolvable"
        elif status_name == "TIMEOUT":
            status = "timeout"
        else:
            status = "error"
        plan = [_format_step(a) for a in result.plan.actions] if result.plan is not None else None
        log = ""
        if status in ("error", "timeout") and result.log_messages:
            log = "\n".join(m.message for m in result.log_messages)[-400:]
        return {"status": status, "planner_status": status_name, "plan": plan,
                "message": log, "seconds": round(time.time() - started, 2)}
    except Exception as e:  # noqa: BLE001
        import traceback
        tb = traceback.format_exc().strip().splitlines()
        where = next((l.strip() for l in reversed(tb) if l.strip().startswith("File ")), "")
        return {"status": "error", "message": f"{type(e).__name__}: {str(e)[:300]} @ {where}",
                "plan": None, "seconds": round(time.time() - started, 2)}


def solve_files(domain_path: Path, problem_path: Path,
                timeout: float = DEFAULT_PLAN_TIMEOUT) -> dict:
    """Run the planner in a subprocess with a hard wall-clock limit."""
    project_root = Path(__file__).resolve().parent.parent
    cmd = [sys.executable, "-m", "appworld2pddl.plan",
           str(Path(domain_path).resolve()), str(Path(problem_path).resolve()), str(timeout)]
    env = dict(os.environ, PYTHONPATH=str(project_root) + os.pathsep + os.environ.get("PYTHONPATH", ""))
    # Fast Downward's driver writes output.sas into the working directory, so every run gets
    # its own scratch directory; otherwise concurrent runs read each other's translator output.
    with tempfile.TemporaryDirectory(prefix="fd_run_") as workdir:
        try:
            proc = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout + 30,
                                  cwd=workdir, env=env)
        except subprocess.TimeoutExpired:
            return {"status": "timeout", "plan": None,
                    "message": "planner process exceeded wall-clock limit", "seconds": timeout + 30}
    out = proc.stdout.strip().splitlines()
    for line in reversed(out):  # last JSON line is ours; planner may print noise first
        if line.startswith("{"):
            try:
                return json.loads(line)
            except json.JSONDecodeError:
                break
    return {"status": "error", "plan": None,
            "message": (proc.stderr or proc.stdout)[-400:] or f"planner exited {proc.returncode}",
            "seconds": None}


def solve(domain: str, problem: str, timeout: float = DEFAULT_PLAN_TIMEOUT) -> dict:
    """Plan from PDDL text."""
    with tempfile.TemporaryDirectory(prefix="appworld2pddl_") as tmp:
        d = Path(tmp) / "domain.pddl"
        p = Path(tmp) / "problem.pddl"
        d.write_text(domain)
        p.write_text(problem)
        return solve_files(d, p, timeout)


if __name__ == "__main__":
    if len(sys.argv) < 3:
        sys.exit("usage: python -m appworld2pddl.plan domain.pddl problem.pddl [timeout_seconds]")
    t = float(sys.argv[3]) if len(sys.argv) > 3 else DEFAULT_PLAN_TIMEOUT
    print(json.dumps(_solve_in_process(sys.argv[1], sys.argv[2], t)))
