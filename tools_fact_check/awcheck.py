"""Helpers for checking PDDL problem facts against the live AppWorld environment.

  awcheck.py show TASK            print the PDDL problem, bindings, plan and AppWorld ground truth
  awcheck.py run TASK < code.py   execute code inside the task's AppWorld environment (apis.<app>.<api>(...))
  awcheck.py exec TASK < code.py  same as run, then run AppWorld's official evaluation of the task and print it
  awcheck.py replan TASK          validate + plan out/<split>/TASK with the project's pipeline (Fast Downward);
                                  rewrites plan.txt, plan_calls.json and meta.json there
  awcheck.py logins [TASK ...]    mechanical check of every login in plan_calls.json (default: all tasks)
"""
import json
import os
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
os.environ.setdefault("APPWORLD_ROOT", str(HERE / "aw_root"))
OUT = HERE / "out"            # copy of <project>/test and <project>/train_dev
DATA = HERE / "aw_root" / "data" / "tasks"


def task_dir(task_id: str) -> Path:
    for split in ("test", "train_dev"):
        d = OUT / split / task_id
        if d.exists():
            return d
    raise SystemExit(f"no PDDL output for {task_id}")


def read(p: Path, default=""):
    return p.read_text() if p.exists() else default


def show(task_id: str) -> None:
    d, gt = task_dir(task_id), DATA / task_id / "ground_truth"
    specs = json.loads(read(DATA / task_id / "specs.json"))
    print(f"##### TASK {task_id}  ({d.parent.name})")
    print("INSTRUCTION:", specs["instruction"])
    print("SUPERVISOR:", specs["supervisor"], "| NOW:", specs["datetime"])
    print("\n##### problem.pddl\n" + read(d / "problem.pddl", "<<missing>>"))
    print("\n##### bindings.json (object -> literal value | runtime source)")
    for b in json.loads(read(d / "bindings.json", "[]")):
        src = repr(b["value"]) if b.get("value") is not None else f"<{b.get('from_api')}: {b.get('field')}>"
        print(f"  {b['object']} = {src}" + (f"   # {b['field']}" if b.get("value") is not None and b.get("field") else ""))
    print("\n##### plan.txt\n" + read(d / "plan.txt", "<<missing>>"))
    print("\n##### GROUND TRUTH")
    for name in ("answer.json", "public_data.json", "private_data.json", "required_apis.json",
                 "compiled_solution.py", "evaluation.py"):
        if (gt / name).exists():
            print(f"--- {name}\n{read(gt / name).strip()}")


def run(task_id: str, code: str) -> str:
    from appworld import AppWorld
    with AppWorld(task_id=task_id, experiment_name="fact_check") as world:
        return world.execute(code)


def exec_eval(task_id: str, code: str) -> None:
    from appworld import AppWorld
    with AppWorld(task_id=task_id, experiment_name="fact_check_exec") as world:
        print(world.execute(code))
        tracker = world.evaluate()
        d = tracker.to_dict()
        print("##### EVALUATION: " + ("SUCCESS" if d.get("success") else "FAILED"),
              f"({len(d.get('passes', []))} passed, {len(d.get('failures', []))} failed)")
        for f in d.get("failures", []):
            print("  FAILED TEST:", " ".join(f.get("requirement", "").split()))
            print("     ", str(f.get("trace", ""))[:600])


def replan(task_id: str) -> None:
    sys.path.insert(0, str(HERE / "proj"))
    from appworld2pddl.convert import ConvertConfig, Converter
    d = task_dir(task_id)
    conv = Converter(ConvertConfig(out_dir=d.parent, plan_only=True))
    r = conv.recheck_task(task_id)
    print("STATUS:", r["status"])
    for k in ("errors", "warnings", "api_issues"):
        if r.get(k):
            print(k.upper() + ":", *r[k], sep="\n  ")
    pl = r.get("planning") or {}
    if pl.get("message"):
        print("PLANNER MESSAGE:", pl["message"])
    print("PLAN:", *(pl.get("plan") or ["<<none>>"]), sep="\n  ")


def brief(task_id: str) -> None:
    """Compact view for manual auditing: instruction, problem, bindings, domain (squeezed), ground truth."""
    import re
    d, gt = task_dir(task_id), DATA / task_id / "ground_truth"
    specs = json.loads(read(DATA / task_id / "specs.json"))
    print(f"##### {task_id}: {specs['instruction']}")
    print("SUPERVISOR:", specs["supervisor"], "| NOW:", specs["datetime"])
    print("ANSWER:", read(gt / "answer.json").strip(), "| PUBLIC:", " ".join(read(gt / "public_data.json").split()),
          "| PRIVATE:", " ".join(read(gt / "private_data.json").split())[:700])
    print("--- problem.pddl\n" + read(d / "problem.pddl").strip())
    print("--- bindings")
    for b in json.loads(read(d / "bindings.json", "[]")):
        src = repr(b["value"]) if b.get("value") is not None else f"<{b.get('from_api')}: {b.get('field')}>"
        print(f"  {b['object']} = {src}")
    dom = re.sub(r";[^\n]*", "", read(d / "domain.pddl"))
    dom = re.sub(r"\(not \(task-completed\)\)", "", dom)
    print("--- domain (comments and '(not (task-completed))' stripped)\n" + re.sub(r"\s+", " ", dom).replace("(:action", "\n(:action").replace("(:predicates", "\n(:predicates").replace("(:types", "\n(:types").replace("(:constants", "\n(:constants"))
    print("--- action_params:", "; ".join(f"{a['action']}{a['params']}" for a in json.loads(read(d / "action_params.json", "[]"))))


def mini(task_id: str) -> None:
    """Even smaller view: instruction, private data, problem, squeezed domain (no login/show-profile boilerplate)."""
    import re
    d, gt = task_dir(task_id), DATA / task_id / "ground_truth"
    specs = json.loads(read(DATA / task_id / "specs.json"))
    print(f"##### {task_id}: {specs['instruction']}")
    print("ANSWER:", read(gt / "answer.json").strip(), "| PUBLIC:", " ".join(read(gt / "public_data.json").split()),
          "| PRIVATE:", " ".join(read(gt / "private_data.json").split())[:200])
    print(re.sub(r"\n\s+", "\n ", read(d / "problem.pddl").strip()))
    print("--- bindings")
    for b in json.loads(read(d / "bindings.json", "[]")):
        if b.get("from_api") in ("supervisor.show_account_passwords",) or str(b.get("from_api", "")).endswith(".login"):
            continue
        src = repr(b["value"]) if b.get("value") is not None else f"<{b.get('from_api')}: {b.get('field')}>"
        print(f"  {b['object']} = {src[:110]}")
    dom = re.sub(r";[^\n]*", "", read(d / "domain.pddl"))
    dom = re.sub(r"\(not \(task-completed\)\)", "", dom)
    dom = re.sub(r"\s+", " ", dom)
    for part in re.split(r"(?=\(:action|\(:predicates|\(:constants|\(:types)", dom)[1:]:
        if re.match(r"\(:action (supervisor-show|[a-z-]+-login)", part) or part.startswith("(:types"):
            continue
        print(part.strip())
    print("--- action_params:", "; ".join(f"{a['action']}{a['params']}" for a in json.loads(read(d / "action_params.json", "[]")) if "login" not in a["action"] and "supervisor-show" not in a["action"]))


def skim(task_id: str) -> None:
    """Smallest view: instruction, answer, non-credential objects/init/goal, non-credential bindings, reference calls."""
    import re
    d, gt = task_dir(task_id), DATA / task_id / "ground_truth"
    specs = json.loads(read(DATA / task_id / "specs.json"))
    print(f"##### {task_id}: {specs['instruction']}  [ANSWER {read(gt / 'answer.json').strip()}] PRIVATE {' '.join(read(gt / 'private_data.json').split())[:300]}")
    prob = re.sub(r";[^\n]*", "", read(d / "problem.pddl"))
    facts = re.findall(r"\((?:[^()]|\([^()]*\))*\)", prob[prob.index("(:init") + 6:prob.index("(:goal")])
    print(" INIT:", " ".join(f for f in facts if not re.search(r"username|password|token|supervisor-email", f)))
    print(" GOAL:", " ".join(prob[prob.index("(:goal"):].split()))
    for b in json.loads(read(d / "bindings.json", "[]")):
        if b.get("from_api") in ("supervisor.show_account_passwords",) or str(b.get("from_api", "")).endswith(".login"):
            continue
        src = repr(b["value"]) if b.get("value") is not None else f"<{b.get('from_api')}: {b.get('field')}>"
        print(f"   {b['object']} = {src[:150]}")
    print(" PLAN:", " ".join(l.strip() for l in read(d / "plan.txt").splitlines() if "login" not in l and "supervisor-show" not in l))


def _api_table():
    """[(app.api, METHOD, compiled path regex)] from the API docs."""
    import re
    table = []
    for f in sorted((HERE / "aw_root" / "data" / "api_docs" / "standard").glob("*.json")):
        for name, api in json.loads(f.read_text()).items():
            rx = re.compile("^" + re.sub(r"\{[^}]+\}", "([^/]+)", api["path"]) + "$")
            table.append((f"{f.stem}.{name}", api["method"].upper(), rx, api["path"].count("{")))
    table.sort(key=lambda t: t[3])  # literal paths win over templated ones
    return table


def _plan_apis(task_id: str) -> list[str]:
    d = task_dir(task_id)
    amap = {a["action"]: a["api"] for a in json.loads(read(d / "action_params.json", "[]"))}
    return [amap.get(l.strip("() \n").split()[0], "?" + l) for l in read(d / "plan.txt").splitlines() if l.strip()]


def ref(task_id: str, quiet: bool = False) -> dict:
    """Run the reference solution in the environment; list its API calls; compare with the plan."""
    from collections import Counter
    from appworld import AppWorld
    src = read(DATA / task_id / "ground_truth" / "compiled_solution.py")
    if not src:
        raise SystemExit("no compiled_solution.py (test task)")
    with AppWorld(task_id=task_id, experiment_name="fact_check_ref", raise_on_failure=False) as world:
        out = world.execute(src + "\nsolution(apis, requester)\n")
        ok = world.evaluate().to_dict().get("success")
        log = Path(world.output_logs_directory) / "api_calls.jsonl"
        calls = [json.loads(l) for l in log.read_text().splitlines() if l.strip()]
    table = _api_table()
    named = []
    for c in calls:
        url, m = c["url"].split("?")[0], c["method"].upper()
        hit = next((t for t in table if t[1] == m and t[2].match(url)), None)
        args = {k: v for k, v in (c.get("data") or {}).items() if k not in ("access_token", "password")}
        if hit:
            args.update({f"<path{i}>": g for i, g in enumerate(hit[2].match(url).groups())})
        named.append((hit[0] if hit else f"{m} {url}", m, args))
    writes = lambda seq: Counter(a for a in seq if not a.endswith(".login"))  # noqa: E731
    ref_w = Counter(n for n, m, _ in named if m != "GET" and not n.endswith(".login"))
    plan = _plan_apis(task_id)
    get_apis = {t[0] for t in table if t[1] == "GET"}
    plan_w = Counter(a for a in plan if a not in get_apis and not a.endswith(".login"))
    res = {"task": task_id, "ref_eval": bool(ok), "ref_writes": dict(ref_w), "plan_writes": dict(plan_w),
           "match": ref_w == plan_w,
           "ref_reads": dict(Counter(n for n, m, _ in named if m == "GET")),
           "plan_reads": dict(Counter(a for a in plan if a in get_apis))}
    # literal arguments of the grounded plan vs. the arguments the reference solution really used
    def norm(v):
        try:
            f = float(v); return str(int(f)) if f == int(f) else str(f)
        except (TypeError, ValueError):
            return str(v).strip().lower()
    ref_vals = {}
    for n, m, a in named:
        ref_vals.setdefault(n, set()).update(norm(v) for v in a.values())
    lit = []
    for c in json.loads(read(task_dir(task_id) / "plan_calls.json", "{}")).get("calls", []):
        for k, v in (c.get("args") or {}).items():
            if isinstance(v, dict) or c["api"] is None or c["api"].startswith("supervisor."):
                continue
            if c["api"] not in ref_vals:
                lit.append(f"{c['api']} is not called by the reference")
            elif norm(v) not in ref_vals[c["api"]]:
                lit.append(f"{c['api']}({k}={v!r}) - reference never passes this value")
    res["literal_issues"] = sorted(set(lit))
    res["ref_only_reads"] = sorted(set(res["ref_reads"]) - set(res["plan_reads"]) - {"supervisor.show_profile"})
    if quiet:
        print(json.dumps(res), flush=True)
        return res
    if out.strip():
        print("SOLUTION OUTPUT:", out.strip()[:500])
    print("REFERENCE EVALUATION:", "SUCCESS" if ok else "FAILED")
    shown = set()
    for n, m, a in named:
        if m == "GET" or n.endswith(".login"):
            a = {k: v for k, v in a.items() if k != "page_index"}
            key = n + json.dumps({k: v for k, v in a.items() if not k.startswith("<path")}, default=str)
            if key in shown or n.startswith("supervisor."):
                continue
            shown.add(key)
            cnt = sum(1 for n2, _, _ in named if n2 == n)
            a = dict(a, **{"#calls": cnt}) if cnt > 1 else a
        print(f"  {n} {json.dumps(a, default=str)[:200]}")
    print("STATE-CHANGING CALLS  reference:", dict(ref_w))
    print("STATE-CHANGING CALLS  plan     :", dict(plan_w), "=> MATCH" if res["match"] else "=> MISMATCH")
    for l in res["literal_issues"]:
        print("LITERAL:", l)
    print("READ CALLS reference:", res["ref_reads"], "\nREAD CALLS plan     :", res["plan_reads"])
    return res


LOGIN_CODE = """
import json as _j
_pw = {p['account_name']: p['password'] for p in apis.supervisor.show_account_passwords()}
_res = []
for _app, _user in %r:
    try:
        _r = getattr(apis, _app).login(username=_user, password=_pw.get(_app, ''))
        _res.append([_app, _user, 'ok' if 'access_token' in _r else str(_r)])
    except Exception as _e:
        _res.append([_app, _user, 'FAIL: ' + str(_e)[:150]])
print('RESULT' + _j.dumps(_res))
"""


def logins(task_ids: list[str]) -> None:
    if not task_ids:
        task_ids = sorted(p.parent.name for p in OUT.glob("*/*/plan_calls.json"))
    for tid in task_ids:
        calls = json.loads(read(task_dir(tid) / "plan_calls.json", "{}")).get("calls", [])
        pairs = []
        for c in calls:
            if c["api"].endswith(".login"):
                pairs.append([c["api"].split(".")[0], c["args"].get("username")])
        literal = [p for p in pairs if isinstance(p[1], str)]
        rec = {"task": tid, "non_literal": [p for p in pairs if not isinstance(p[1], str)]}
        if literal:
            out = run(tid, LOGIN_CODE % (literal,))
            line = [l for l in out.splitlines() if l.startswith("RESULT")]
            rec["logins"] = json.loads(line[0][6:]) if line else [["?", "?", "EXEC ERROR: " + out[-300:]]]
        print(json.dumps(rec), flush=True)


if __name__ == "__main__":
    cmd, args = sys.argv[1], sys.argv[2:]
    if cmd == "show":
        show(args[0])
    elif cmd == "run":
        print(run(args[0], sys.stdin.read()))
    elif cmd == "exec":
        exec_eval(args[0], sys.stdin.read())
    elif cmd == "replan":
        replan(args[0])
    elif cmd == "brief":
        brief(args[0])
    elif cmd == "mini":
        mini(args[0])
    elif cmd == "skim":
        for t in args:
            skim(t)
    elif cmd == "ref":
        ref(args[0])
    elif cmd == "refall":
        for t in args:
            try:
                ref(t, quiet=True)
            except BaseException as e:  # noqa: BLE001
                print(json.dumps({"task": t, "error": str(e)[:300]}), flush=True)
    elif cmd == "logins":
        logins(args)
