"""Tiny edit helpers for the manual audit."""
import json, re
from pathlib import Path
import awcheck

def sub(task, name, old, new, count=1, regex=False):
    p = awcheck.task_dir(task) / name
    s = p.read_text()
    if regex:
        s2, n = re.subn(old, new, s, flags=re.S)
    else:
        n = s.count(old); s2 = s.replace(old, new)
    assert n >= 1 and (count is None or n == count), f"{task}/{name}: {n} matches for {old[:60]!r}"
    p.write_text(s2)

def binds(task, drop=(), add=(), set_=None):
    """drop: object names; add: [(object, value, from_api, field)]; set_: {object: {key: val}}"""
    p = awcheck.task_dir(task) / "bindings.json"
    b = [x for x in json.loads(p.read_text()) if x["object"] not in set(drop)]
    for o, kv in (set_ or {}).items():
        hit = [x for x in b if x["object"] == o]; assert hit, o
        hit[0].update(kv)
    b += [dict(zip(["object", "value", "from_api", "field"], a)) for a in add]
    p.write_text(json.dumps(b, indent=2))

def write(task, name, text):
    (awcheck.task_dir(task) / name).write_text(text)

def slug(s):
    return re.sub(r"[^a-z0-9]+", "-", s.lower()).strip("-")

def envjson(task, code):
    """Run code in the task env; code must end by print('JSON'+json.dumps(obj))."""
    out = awcheck.run(task, "import json\n" + code)
    line = [l for l in out.splitlines() if l.startswith("JSON")]
    assert line, out[-600:]
    return json.loads(line[-1][4:])

LOGIN = """sp=apis.supervisor.show_profile(); pw={p['account_name']:p['password'] for p in apis.supervisor.show_account_passwords()}
def tok(app): return getattr(apis,app).login(username=sp['phone_number'] if app=='phone' else sp['email'],password=pw[app])['access_token']
def pages(f,**k):
    out=[]
    for i in range(50):
        r=f(page_index=i,**k)
        if not r: break
        out+=r
    return out
"""

def names(items, prefix, key="title"):
    """unique kebab names for items (dicts)"""
    seen = {}
    for it in items:
        n = f"{prefix}-{slug(str(it[key]))}"[:60].rstrip("-")
        if n in seen:
            n = f"{n}-{it.get('id', len(seen))}"
        seen[n] = 1; it["obj"] = n
    return items

def set_objects(task, typ, objs, replace_names=None):
    """Replace the object-declaration line(s) for a type in problem.pddl, or insert a new one."""
    p = awcheck.task_dir(task) / "problem.pddl"; s = p.read_text()
    m = re.search(r"\(:objects(.*?)\n\s*\)\s*\n\s*\(:init|\(:objects(.*?)\)\s*\(:init", s, re.S)
    body = m.group(1) if m.group(1) is not None else m.group(2)
    lines = [l for l in body.split("\n") if not re.search(r"\s-\s+" + re.escape(typ) + r"\s*$", l.split(";")[0].rstrip())]
    new_body = "\n".join(lines).rstrip() + ("\n    " + " ".join(objs) + " - " + typ if objs else "")
    new_body = re.sub(r"\n\s*(?=\S)", "\n    ", new_body)
    p.write_text(s.replace(body, new_body + ("\n  " if m.group(1) is None else ""), 1))

def set_section(task, name, section, facts, wrap_and=False):
    """Replace whole (:init ...) or (:goal (and ...)) of problem.pddl / a balanced section."""
    p = awcheck.task_dir(task) / name; s = p.read_text()
    i = s.index("(" + section); depth = 0
    for j in range(i, len(s)):
        depth += s[j] == "("; depth -= s[j] == ")"
        if depth == 0: break
    inner = "\n    ".join(facts)
    new = f"({section} (and\n    {inner}))" if wrap_and else f"({section}\n    {inner})"
    p.write_text(s[:i] + new + s[j + 1:])

def keep_init(task, pattern):
    """existing init facts matching regex (to carry over credentials etc.)"""
    s = (awcheck.task_dir(task) / "problem.pddl").read_text()
    init = s[s.index("(:init"):s.index("(:goal")]
    return [f for f in re.findall(r"\((?:[^()]|\([^()]*\))*\)", init[6:]) if re.search(pattern, f)]

def ctask(t, cond, params=None):
    """Rewrite supervisor-complete-task precondition (and optionally parameters) in domain.pddl."""
    dp = awcheck.task_dir(t) / "domain.pddl"; s = dp.read_text()
    i = s.index("(:action supervisor-complete-task"); j = s.index(":precondition", i); k = s.index(":effect", j)
    head = s[:j]
    if params is not None:
        pi = s.index(":parameters", i)
        head = s[:pi] + f":parameters ({params})\n    "
    dp.write_text(head + ":precondition (and\n      " + "\n      ".join(cond) + "\n      (not (task-completed)))\n    " + s[k:])

def private(t):
    return json.loads((awcheck.DATA / t / "ground_truth" / "private_data.json").read_text())
