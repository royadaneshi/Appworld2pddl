"""Lightweight PDDL sanity checks, with full parsing when the `pddl` package is installed."""
from __future__ import annotations

import re


def _strip_comments(text: str) -> str:
    return "\n".join(line.split(";", 1)[0] for line in text.splitlines())


def _balanced(text: str) -> bool:
    depth = 0
    for ch in _strip_comments(text):
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
            if depth < 0:
                return False
    return depth == 0


def _domain_name(text: str) -> str | None:
    m = re.search(r"\(define\s*\(domain\s+([^\s)]+)\)", _strip_comments(text))
    return m.group(1) if m else None


def _problem_domain_ref(text: str) -> str | None:
    m = re.search(r"\(:domain\s+([^\s)]+)\)", _strip_comments(text))
    return m.group(1) if m else None


def _action_names(domain: str) -> list[str]:
    return re.findall(r"\(:action\s+([^\s)]+)", _strip_comments(domain))


def validate(domain: str, problem: str, known_apis: set[str] | None = None) -> dict:
    """Return {'ok': bool, 'errors': [...], 'warnings': [...], 'parser': str}."""
    errors: list[str] = []
    warnings: list[str] = []

    if not _balanced(domain):
        errors.append("domain: unbalanced parentheses")
    if not _balanced(problem):
        errors.append("problem: unbalanced parentheses")

    dname = _domain_name(domain)
    pref = _problem_domain_ref(problem)
    if dname is None:
        errors.append("domain: missing (define (domain ...))")
    if pref is None:
        errors.append("problem: missing (:domain ...)")
    if dname and pref and dname != pref:
        errors.append(f"problem references domain '{pref}' but domain is named '{dname}'")

    for section in (":predicates", ":action"):
        if section not in domain:
            errors.append(f"domain: missing {section}")
    for section in (":objects", ":init", ":goal"):
        if section not in problem:
            errors.append(f"problem: missing {section}")
    if "(task-completed)" not in _strip_comments(problem):
        warnings.append("problem goal does not mention (task-completed)")

    warnings.extend(completion_structure_issues(domain))

    if known_apis:
        for action in _action_names(domain):
            if action not in known_apis:
                warnings.append(f"action '{action}' does not match any AppWorld API name")

    parser = "regex"
    try:
        from pddl.parser.domain import DomainParser  # type: ignore
        from pddl.parser.problem import ProblemParser  # type: ignore

        parser = "pddl"
        # The `pddl` library is stricter than the PDDL standard (e.g. rejects `?x - object`),
        # so its complaints are warnings; Fast Downward's parser is the authoritative check.
        try:
            DomainParser()(domain)
        except Exception as e:  # noqa: BLE001 - report any parser failure
            warnings.append(f"domain: pddl-lib parser: {str(e).splitlines()[0][:300]}")
        try:
            ProblemParser()(problem)
        except Exception as e:  # noqa: BLE001
            warnings.append(f"problem: pddl-lib parser: {str(e).splitlines()[0][:300]}")
    except ImportError:
        warnings.append("`pddl` package not installed; only regex checks were run (pip install pddl)")

    return {"ok": not errors, "errors": errors, "warnings": warnings, "parser": parser}


COMPLETE_ACTION = "supervisor-complete-task"


def _action_bodies(domain: str) -> dict[str, str]:
    """Map action name -> text of its definition (up to the next :action or end)."""
    text = _strip_comments(domain)
    bodies: dict[str, str] = {}
    matches = list(re.finditer(r"\(:action\s+([^\s)]+)", text))
    for i, m in enumerate(matches):
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        bodies[m.group(1)] = text[m.start():end]
    return bodies


def completion_structure_issues(domain: str) -> list[str]:
    """Static checks that make supervisor-complete-task the only possible final action."""
    issues: list[str] = []
    bodies = _action_bodies(domain)
    if COMPLETE_ACTION not in bodies:
        return [f"domain has no {COMPLETE_ACTION} action"]
    for name, body in bodies.items():
        pre = body.split(":effect", 1)[0]
        eff = body.split(":effect", 1)[1] if ":effect" in body else ""
        if name != COMPLETE_ACTION:
            if not re.search(r"\(not\s*\(task-completed\)\)", pre):
                issues.append(f"action '{name}' lacks (not (task-completed)) in its precondition")
            if re.search(r"(?<!\(not\s)\(task-completed\)", eff.replace("\n", " ")):
                issues.append(f"action '{name}' sets (task-completed); only {COMPLETE_ACTION} may")
    complete_pre = bodies[COMPLETE_ACTION].split(":effect", 1)[0]
    if re.sub(r"\s", "", complete_pre).count("(") <= 4:  # roughly: only (not (task-completed)) or less
        issues.append(f"{COMPLETE_ACTION} precondition does not require the task's goal conditions")
    return issues


def _step_name(step: str) -> str:
    """Action name from a plan step in either '(name a b)' or 'name(a, b)' form."""
    return step.strip().strip("()").split("(")[0].split()[0] if step.strip("() ") else ""


def plan_order_issue(plan: list[str]) -> str | None:
    """Return a message if the plan does not end with exactly one supervisor-complete-task."""
    names = [_step_name(step) for step in plan]
    count = names.count(COMPLETE_ACTION)
    if count == 0:
        return f"plan never calls {COMPLETE_ACTION}"
    if count > 1:
        return f"plan calls {COMPLETE_ACTION} {count} times"
    if names[-1] != COMPLETE_ACTION:
        pos = names.index(COMPLETE_ACTION) + 1
        return f"{COMPLETE_ACTION} is step {pos} of {len(names)}, not last"
    return None


def api_action_names(api_index_lines: str) -> set[str]:
    """Derive the set of valid action names (<app>-<api_name> with hyphens) from the API index."""
    names = set()
    for m in re.finditer(r"^- ([a-z_]+)\.([a-z_0-9]+)\(", api_index_lines, flags=re.M):
        names.add(f"{m.group(1)}-{m.group(2)}".replace("_", "-"))
    return names


def _action_param_types(domain: str) -> dict[str, dict[str, str]]:
    """Action name -> {variable: type} from its :parameters list."""
    out: dict[str, dict[str, str]] = {}
    for name, body in _action_bodies(domain).items():
        m = re.search(r":parameters\s*\((.*?)\)\s*:precondition", body, flags=re.S)
        text = m.group(1) if m else ""
        types: dict[str, str] = {}
        pending: list[str] = []
        tokens = text.replace("\n", " ").split()
        i = 0
        while i < len(tokens):
            tok = tokens[i]
            if tok == "-" and i + 1 < len(tokens):
                for v in pending:
                    types[v] = tokens[i + 1]
                pending = []
                i += 2
                continue
            pending.append(tok)
            i += 1
        for v in pending:
            types[v] = "object"
        out[name] = types
    return out


def _action_param_vars(domain: str) -> dict[str, list[str]]:
    """Action name -> list of its PDDL parameter variable names, in order."""
    out: dict[str, list[str]] = {}
    for name, body in _action_bodies(domain).items():
        m = re.search(r":parameters\s*\((.*?)\)\s*:precondition", body, flags=re.S)
        params_text = m.group(1) if m else ""
        out[name] = re.findall(r"\?[\w-]+", params_text)
    return out


def api_param_issues(domain: str, action_params: list[dict], api_table: dict[str, dict]) -> list[str]:
    """Check that every action maps each PDDL parameter to an API argument and covers all required ones."""
    issues: list[str] = []
    by_action = {ap["action"]: ap for ap in action_params or []}
    action_to_api = {info["action"]: api for api, info in api_table.items()}
    param_types = _action_param_types(domain)
    for action, variables in _action_param_vars(domain).items():
        api = action_to_api.get(action)
        if api is None:
            continue  # already reported as an unknown-API warning
        app_vars = [v for v, t in param_types.get(action, {}).items() if t == "app"]
        if app_vars:
            issues.append(f"action '{action}' takes app-typed parameter(s) {app_vars}; the app is fixed "
                          f"by the action name, so declare it in (:constants ... - app) and use it directly")
        spec = api_table[api]
        mapping = by_action.get(action)
        if mapping is None:
            issues.append(f"action '{action}' has no action_params entry")
            continue
        if mapping.get("api") and mapping["api"] != api:
            issues.append(f"action '{action}' is mapped to {mapping['api']} but its name means {api}")
        names = mapping.get("params") or []
        if len(names) != len(variables):
            issues.append(f"action '{action}' has {len(variables)} PDDL parameters {variables} but "
                          f"action_params lists {len(names)} entries {names}")
        known = set(spec["required"]) | set(spec["optional"])
        for n in names:
            if n is not None and n not in known:
                issues.append(f"action '{action}': '{n}' is not a parameter of {api} "
                              f"(valid: {sorted(known)})")
        missing = [r for r in spec["required"] if r not in names]
        if missing:
            issues.append(f"action '{action}' lacks PDDL parameters for required API arguments "
                          f"{missing} of {api}")
    return issues


def parse_plan_step(step: str) -> tuple[str, list[str]]:
    inner = step.strip().strip("()").split()
    return (inner[0], inner[1:]) if inner else ("", [])


def _coerce(value: str, api_type: str):
    t = (api_type or "").lower()
    try:
        if "integer" in t and "string" not in t:
            return int(value)
        if "number" in t and "string" not in t:
            f = float(value)
            return int(f) if f.is_integer() else f
        if "boolean" in t:
            return str(value).strip().lower() in ("true", "1", "yes")
    except (TypeError, ValueError):
        pass
    return value


def ground_plan(plan: list[str], action_params: list[dict], bindings: list[dict],
                api_table: dict[str, dict]) -> dict:
    """Turn PDDL plan steps into concrete API calls using the parameter mapping and bindings."""
    by_action = {ap["action"]: ap for ap in action_params or []}
    by_object = {b["object"]: b for b in bindings or []}
    action_to_api = {info["action"]: api for api, info in api_table.items()}
    calls: list[dict] = []
    problems: list[str] = []
    for i, step in enumerate(plan, 1):
        action, args = parse_plan_step(step)
        api = action_to_api.get(action)
        mapping = by_action.get(action, {}).get("params") or []
        call = {"step": i, "pddl": step, "api": api, "args": {}}
        if api is None:
            problems.append(f"step {i}: action '{action}' is not an AppWorld API")
        for j, obj in enumerate(args):
            pname = mapping[j] if j < len(mapping) else None
            if pname is None:
                continue
            b = by_object.get(obj)
            if b is None:
                problems.append(f"step {i}: object '{obj}' (API argument '{pname}') has no binding")
                call["args"][pname] = {"$unbound": obj}
            elif b.get("value") is not None:
                api_type = api_table.get(api, {}).get("types", {}).get(pname, "string") if api else "string"
                call["args"][pname] = _coerce(b["value"], api_type)
            else:
                call["args"][pname] = {"$from": b.get("from_api"), "field": b.get("field"), "object": obj}
        calls.append(call)
    return {"calls": calls, "problems": problems}


def reference_api_check(domain: str, required_apis: list[str] | None,
                        api_table: dict[str, dict]) -> dict | None:
    """Compare the domain's actions with the task's reference API set (train/dev only)."""
    if not required_apis:
        return None
    action_to_api = {info["action"]: api for api, info in api_table.items()}
    present = {action_to_api[a] for a in _action_names(domain) if a in action_to_api}
    required = set(required_apis)
    return {"missing": sorted(required - present), "extra": sorted(present - required),
            "matched": sorted(required & present)}
