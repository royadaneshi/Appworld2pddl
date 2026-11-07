"""CLI: convert AppWorld tasks into PDDL domain/problem files with Claude.

Examples:
    export CLAUD_KEY=sk-ant-...
    python main.py --limit 2                 # smoke test on two tasks
    python main.py --split dev               # one dataset split
    python main.py                           # every task (resumable; skips finished ones)
    python main.py --tasks 024c982_1 50e1ac9_1
    python main.py --dry-run --limit 1       # write prompts only, no API calls
    python main.py --plan-only               # re-run validation + planner on existing outputs
"""
from __future__ import annotations

import argparse
from pathlib import Path

from appworld2pddl.convert import (DEFAULT_EFFORT, DEFAULT_MAX_TOKENS, DEFAULT_MODEL,
                                   ConvertConfig, Converter, load_dotenv, summarize)
from appworld2pddl.loader import list_task_ids

PROJECT_ROOT = Path(__file__).resolve().parent


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Convert AppWorld tasks to PDDL with Claude.")
    p.add_argument("--split", default="all",
                   help="train | dev | test_normal | test_challenge | all, or a comma list "
                        "such as train,dev (default: all)")
    p.add_argument("--tasks", nargs="*", help="Explicit task ids (overrides --split)")
    p.add_argument("--limit", type=int, help="Only process the first N tasks")
    p.add_argument("--out", default=str(PROJECT_ROOT / "pddl"), help="Output directory")
    p.add_argument("--model", default=DEFAULT_MODEL)
    p.add_argument("--effort", default=DEFAULT_EFFORT,
                   choices=["low", "medium", "high", "xhigh", "max"])
    p.add_argument("--max-tokens", type=int, default=DEFAULT_MAX_TOKENS)
    p.add_argument("--workers", type=int, default=4, help="Concurrent API requests")
    p.add_argument("--no-ground-truth", action="store_true",
                   help="Do not show the evaluation code / public data to the model")
    p.add_argument("--include-private", action="store_true",
                   help="Also show private_data.json (resolved ids) to the model")
    p.add_argument("--include-solution", action="store_true",
                   help="Also show the reference compiled_solution.py and required APIs (train/dev tasks only)")
    p.add_argument("--no-fallbacks", action="store_true",
                   help="Disable server-side refusal fallbacks")
    p.add_argument("--force", action="store_true", help="Re-convert tasks that already have output")
    p.add_argument("--dry-run", action="store_true", help="Write prompts only; make no API calls")
    p.add_argument("--no-plan", action="store_true",
                   help="Skip the Fast Downward solvability check after validation")
    p.add_argument("--plan-timeout", type=float, default=60.0,
                   help="Seconds allowed for the planner search per task (default 60)")
    p.add_argument("--repairs", type=int, default=1,
                   help="Extra rounds where planner/validator feedback is sent back to Claude (default 1)")
    p.add_argument("--plan-only", action="store_true",
                   help="Re-validate and re-plan existing outputs in --out; no API calls")
    return p.parse_args()


def main() -> None:
    load_dotenv(PROJECT_ROOT / ".env")
    args = parse_args()

    task_ids = args.tasks or list_task_ids(args.split)
    if args.limit:
        task_ids = task_ids[: args.limit]

    config = ConvertConfig(
        out_dir=Path(args.out),
        model=args.model,
        effort=args.effort,
        max_tokens=args.max_tokens,
        include_ground_truth=not args.no_ground_truth,
        include_private=args.include_private,
        include_solution=args.include_solution,
        force=args.force,
        workers=args.workers,
        dry_run=args.dry_run,
        use_fallbacks=not args.no_fallbacks,
        run_planner=not args.no_plan,
        plan_timeout=args.plan_timeout,
        plan_only=args.plan_only,
        repairs=args.repairs,
    )
    converter = Converter(config)
    if config.plan_only:
        existing = [t for t in task_ids if (converter.task_out_dir(t) / "problem.pddl").exists()]
        print(f"{len(existing)} existing outputs to re-check in {config.out_dir}")
        results = converter.run(existing, recheck=True)
    else:
        pending = [t for t in task_ids if config.force or config.dry_run or not converter.is_done(t)]
        print(f"{len(task_ids)} tasks selected, {len(pending)} to process "
              f"(model={config.model}, effort={config.effort}, out={config.out_dir}, "
              f"planner={'fast-downward' if config.run_planner else 'off'})")
        results = converter.run(pending)
    print(summarize(results))


if __name__ == "__main__":
    main()
