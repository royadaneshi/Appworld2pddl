"""fixtok.py TASK... : tie each token (and password) object to its app so a plan cannot log in to app A with app B's credentials."""
import json, re, sys
import awcheck

def wrong(task):
    out = []
    for c in json.loads(awcheck.read(awcheck.task_dir(task) / "plan_calls.json", "{}")).get("calls", []):
        if not c.get("api"):
            continue
        app = c["api"].split(".")[0]
        a = (c.get("args") or {}).get("access_token")
        if isinstance(a, dict) and a.get("$from") and a["$from"].split(".")[0] != app:
            out.append(f"{c['api']} gets token of {a['$from']}")
        p = (c.get("args") or {}).get("password")
        if c["api"].endswith(".login") and isinstance(p, dict):
            m = re.search(r'account_name\s*==\s*\\?["\']?([a-z_]+)', str(p.get("field")))
            if m and m.group(1) != app:
                out.append(f"{c['api']} gets password of {m.group(1)}")
    return sorted(set(out))

def fix(task):
    d = awcheck.task_dir(task)
    dom, prob = (d / "domain.pddl").read_text(), (d / "problem.pddl").read_text()
    ap = {a["action"]: a["params"] for a in json.loads((d / "action_params.json").read_text())}
    binds = json.loads((d / "bindings.json").read_text())
    facts, PRED = [], "credential-of-app"
    for m in list(re.finditer(r"\(:action ([a-z-]+)-login\b", dom)):
        app, act = m.group(1), m.group(1) + "-login"
        i = dom.index(f"(:action {act}"); j = dom.index(":effect", i)
        head = dom[i:j]
        pm = re.search(r":parameters\s*\(([^)]*)\)", head)
        vars_ = re.findall(r"(\?[\w-]+)", pm.group(1))
        params = ap.get(act, [])
        tv = [v for v, p in zip(vars_, params) if p is None]
        pv = [v for v, p in zip(vars_, params) if p == "password"]
        add = ""
        for v in tv[:1] + pv[:1]:
            if f"({PRED} {app} {v})" not in head:
                add += f" ({PRED} {app} {v})"
        if add:
            new_head = re.sub(r":precondition\s*\(and", lambda mm: mm.group(0) + add, head, count=1)
            assert new_head != head, f"{task}: cannot patch {act}"
            dom = dom[:i] + new_head + dom[j:]
        api_app = app.replace("-", "_")
        for b in binds:
            if b.get("from_api") == f"{api_app}.login":
                facts.append(f"({PRED} {app} {b['object']})")
            if b.get("from_api") == "supervisor.show_account_passwords" and re.search(rf'account_name\s*==\s*\\?["\']?{api_app}\b', str(b.get("field"))):
                facts.append(f"({PRED} {app} {b['object']})")
    if f"({PRED} " not in dom.split("(:action")[0]:
        dom = dom.replace("(:predicates", f"(:predicates\n    ({PRED} ?a - app ?c - object)", 1)
    new = [f for f in dict.fromkeys(facts) if f not in prob]
    prob = prob.replace("(:init", "(:init\n    " + "\n    ".join(new), 1) if new else prob
    (d / "domain.pddl").write_text(dom); (d / "problem.pddl").write_text(prob)
    return len(new)

if __name__ == "__main__":
    import contextlib, io
    for t in sys.argv[1:]:
        before = wrong(t)
        if not before:
            print(t, "ok"); continue
        n = fix(t)
        buf = io.StringIO()
        with contextlib.redirect_stdout(buf):
            awcheck.replan(t)
        st = buf.getvalue().split("STATUS:")[1].split()[0]
        print(t, f"was {before} | added {n} facts | replan {st} | now {wrong(t) or 'clean'}")
