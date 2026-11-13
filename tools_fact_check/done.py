"""done.py TASK... : re-plan, compare with the reference solution, mark as audited, copy changed model files to the project."""
import contextlib, io, json, os, shutil, sys
from pathlib import Path
import awcheck, fixtok
PROJECT = Path("/Users/royadaneshi/Desktop/Home/Ph.D./Research/JP_morgan/Appworld2pddl")
FILES = ["domain.pddl", "problem.pddl", "bindings.json", "action_params.json", "plan.txt", "plan_calls.json", "meta.json"]
log = awcheck.HERE / "reports" / "done.jsonl"
for t in sys.argv[1:]:
    d = awcheck.task_dir(t); buf = io.StringIO()
    tokfix = False
    if fixtok.wrong(t):
        fixtok.fix(t); tokfix = True
    with contextlib.redirect_stdout(buf):
        awcheck.replan(t)
    if not tokfix and fixtok.wrong(t):   # the new plan may expose it
        fixtok.fix(t); tokfix = True; buf = io.StringIO()
        with contextlib.redirect_stdout(buf):
            awcheck.replan(t)
    out = buf.getvalue(); status = out.split("STATUS:")[1].split()[0]
    issues = [l.strip() for l in out.splitlines() if "no binding" in l or "lacks" in l] + fixtok.wrong(t)
    with contextlib.redirect_stdout(io.StringIO()):
        r = awcheck.ref(t, quiet=True)
    orig = awcheck.HERE / "out_orig" / d.parent.name / t
    ch = [f for f in FILES if (d / f).exists() and (not (orig / f).exists() or (d / f).read_text() != (orig / f).read_text())]
    model_changed = [f for f in ch if f in ("domain.pddl", "problem.pddl", "bindings.json", "action_params.json")]
    for f in (ch if model_changed else []):
        # write next to the target and rename over it: opening an iCloud-evicted target for writing can hang
        dest = PROJECT / d.parent.name / t / f
        tmp = dest.with_name(dest.name + ".tmp_fix")
        shutil.copyfile(d / f, tmp)
        os.replace(tmp, dest)
    steps = len((d / "plan.txt").read_text().strip().splitlines()) if (d / "plan.txt").exists() else 0
    rec = {"task": t, "planner": status, "steps": steps, "match": r["match"], "ref_eval": r["ref_eval"], "issues": issues,
           "token_fix": tokfix, "changed": [f for f in ch if f in ("domain.pddl", "problem.pddl", "bindings.json", "action_params.json")]}
    with log.open("a") as f:
        f.write(json.dumps(rec) + "\n")
    print(f"{t}: planner {status} ({steps} steps) | match {r['match']} | changed {rec['changed']}{' | token-fix' if tokfix else ''}"
          + ("" if r["match"] else f"\n   ref  {r['ref_writes']}\n   plan {r['plan_writes']}") + ("".join("\n   " + i for i in issues)))
