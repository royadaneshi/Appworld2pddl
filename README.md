# Appworld2pddl

Converts every [AppWorld](https://github.com/stonybrooknlp/appworld) task into a PDDL
planning model (one `domain.pddl` + one `problem.pddl` per task) using the Claude API.

## Setup

```bash
pip install -r requirements.txt
export CLAUD_KEY=sk-ant-...        # or put CLAUD_KEY=... in a .env file next to main.py
```

`ANTHROPIC_API_KEY` is accepted as a fallback name.

## Usage

```bash
python main.py --dry-run --limit 1       # write prompts only, no API calls
python main.py --limit 2                 # smoke test on two tasks
python main.py --split dev               # one split: train | dev | test_normal | test_challenge
python main.py                           # all 732 tasks (resumable; finished tasks are skipped)
python main.py --tasks 024c982_1 --force # redo specific tasks
python main.py --plan-only               # re-run validation + planner on existing outputs
```

Options: `--model` (default `claude-fable-5-1`), `--effort low|medium|high|xhigh|max`
(default `xhigh`), `--workers N` (default 4 concurrent requests), `--no-ground-truth`
(hide the evaluation code from the model), `--include-private` (also show resolved ids),
`--include-solution` (also show the reference `compiled_solution.py` and required API list;
only the 147 train/dev tasks have one, and `meta.json` records `solution_used`),
`--no-fallbacks`, `--max-tokens`, `--no-plan` (skip the planner), `--plan-timeout` (seconds
per task for the planner search, default 60).

## Output

```
pddl/
  _summary.jsonl          one line per task: status, validation errors, token usage
  <task_id>/
    domain.pddl           actions = AppWorld APIs, named <app>-<api-name>
    problem.pddl          objects, init, goal for this task
    meta.json             model, usage, apps used, reference API sequence, validation + planning report
    plan.txt              the plan Fast Downward found, one (action arg ...) per line
    plan_calls.json       the plan grounded into concrete API calls (name + arguments)
    action_params.json    per action: which API argument each PDDL parameter stands for
    bindings.json         per object: its literal value, or the API response it is read from
    prompt.txt            the exact user prompt sent
```

## Validation

Every output goes through two checks, and the result is written to `meta.json` and
`_summary.jsonl`:

1. **Syntax and consistency** with the `pddl` parser: balanced parens, domain/problem names
   match, required sections present, action names map to real AppWorld APIs.
2. **Solvability** with Fast Downward (via `unified-planning` + `up-fast-downward`), run in a
   child process with a timeout. The found plan is saved to `plan.txt`.

3. **Plan order**: the plan must end with exactly one `supervisor-complete-task`. The prompt
   enforces this structurally (every other action requires `(not (task-completed))`, and
   `supervisor-complete-task` requires the task's goal conditions); the validator warns when an
   action breaks that pattern.

4. **Executability**: every action must carry a PDDL parameter for each required argument of
   its API (plus the optional ones the task uses), so a plan step such as
   `(venmo-login joyce-weav-at-gmail-com venmo-password venmo-token)` has everything the call
   needs. Apps are domain constants, never action parameters: the action name already fixes
   the app, so `(venmo-login venmo ...)` is rejected. Claude returns the parameter mapping and the object bindings; the checker verifies
   the mapping against the API docs, and the plan is grounded into `plan_calls.json`, where
   literal values are filled in and runtime values (passwords, tokens, looked-up emails) are
   marked with the API call and response field they come from.

5. **Reference APIs** (train/dev only): the domain's action set is compared with the task's
   `required_apis.json` and the result is stored as `reference_check` (missing / extra /
   matched). With `--include-solution`, a missing required API counts as a failure and
   triggers repair; without it, it is informational, since the model never saw the list.

If any check fails, the failure (validator findings, planner status, the wrong plan) is sent
back to Claude in the same conversation and a corrected model is requested. `--repairs N`
sets how many such rounds are allowed (default 1, `0` disables). `meta.json` keeps an
`attempts` log.

Per-task status values: `solved` (valid and a correctly ordered plan exists),
`bad_plan_order` (solvable, but `supervisor-complete-task` is not the single last step),
`incomplete_actions` (solvable, but some action lacks a required API argument or a binding),
`unsolvable` (parses but the goal is unreachable), `parse_error` (the planner's parser or type
checker rejected it), `timeout`, `invalid_pddl` (failed the structural check), `error` (API or
runtime failure). Anything other than `solved` can be regenerated with `--force`, or
re-checked without API calls using `--plan-only`.

## How it works

- `appworld2pddl/loader.py` reads `appworld_data/data/tasks/<id>/` (instruction, supervisor,
  ground-truth evaluation, metadata) and builds a compact index of all 473 app APIs. The
  expected answer (`answer.json`) and the resolved ids (`private_data.json`) are never sent
  by default, so the model cannot name the answer it is supposed to discover.
- `appworld2pddl/prompt.py` holds the modeling conventions (STRIPS + typing + negative
  preconditions, standard predicates like `logged-in`, `known-id`, `task-completed`).
  The API index lives in a cached system prompt, so each task only pays for its own text.
- `appworld2pddl/convert.py` streams a structured-JSON response from Claude, validates it,
  and writes the files. Runs are resumable and failures are isolated per task.
