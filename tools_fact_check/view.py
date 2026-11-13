"""struct.py TASK... : compact structural view of a model (objects, one init fact per predicate, goal, domain actions, reference calls)."""
import re, sys, json, io, contextlib
import awcheck
for t in sys.argv[1:]:
    d = awcheck.task_dir(t); gt = awcheck.DATA / t / "ground_truth"
    specs = json.loads(awcheck.read(awcheck.DATA / t / "specs.json"))
    print(f"===== {t}: {specs['instruction']}\n ANSWER {awcheck.read(gt/'answer.json').strip()[:150]} | PRIVATE {' '.join(awcheck.read(gt/'private_data.json').split())[:260]}")
    p = re.sub(r";[^\n]*", "", (d / "problem.pddl").read_text())
    print(" OBJECTS", re.sub(r"\s+", " ", p[p.index("(:objects") + 9:p.index("(:init")])[:600])
    facts = re.findall(r"\((?:[^()]|\([^()]*\))*\)", p[p.index("(:init") + 6:p.index("(:goal")])
    seen = {}
    for f in facts:
        seen.setdefault(f.split()[0], []).append(f)
    print(" INIT", " ".join(f"{v[0]}x{len(v)}" if len(v) > 1 else v[0] for k, v in seen.items() if not re.search(r"password|username|token|credential", k)))
    print(" GOAL", re.sub(r"\s+", " ", p[p.index("(:goal"):])[:420])
    for b in json.loads(awcheck.read(d / "bindings.json", "[]")):
        if b.get("value") is not None and not re.search(r"@|^\d{10}$", str(b["value"])):
            print(f"   lit {b['object']} = {b['value']!r}")
    dom = re.sub(r";[^\n]*", "", (d / "domain.pddl").read_text()); dom = re.sub(r"\(not \(task-completed\)\)", "", dom); dom = re.sub(r"\s+", " ", dom)
    for part in re.split(r"(?=\(:action|\(:constants)", dom)[1:]:
        if re.match(r"\(:action (supervisor-show|[a-z-]+-login)", part):
            continue
        print(" " + part.strip()[:520])
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        awcheck.ref(t)
    lines = [l for l in buf.getvalue().splitlines() if not re.search(r"READ CALLS|login|SOLUTION", l)]
    wr = {}
    out = []
    for l in lines:
        api = l.strip().split(" ")[0]
        if l.startswith("  ") and '#calls' not in l and not api.startswith("supervisor"):
            wr[api] = wr.get(api, 0) + 1
            if wr[api] > 3:
                continue
        out.append(l[:230])
    print("\n".join(out))
