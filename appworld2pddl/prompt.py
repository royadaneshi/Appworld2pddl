"""System and user prompts for turning an AppWorld task into a PDDL model."""
from __future__ import annotations

import json

from .loader import Task

SYSTEM_PROMPT_TEMPLATE = """You convert AppWorld benchmark tasks into classical planning models written in PDDL.

AppWorld is a benchmark of everyday digital tasks (Venmo, Gmail, Spotify, Todoist, Splitwise, Amazon,
phone, file_system, simple_note). An agent completes a task by calling app APIs on behalf of a
"supervisor" (the user). Every app needs a login first; passwords come from
supervisor.show_account_passwords. The task is finished by calling supervisor.complete_task
(with an `answer` when the instruction asks a question, otherwise with no answer).

For each task you produce ONE PDDL domain file and ONE PDDL problem file that model the task as a
planning problem whose solution plan is the sequence of API calls needed to complete the task.

Modeling conventions (follow them exactly so the outputs are uniform across tasks):
- Requirements: use only `:strips :typing :negative-preconditions :equality`. Do not use numeric
  fluents, conditional effects, durative actions, derived predicates, or quantified goals. Encode
  quantities (amounts, counts, ratings) as discrete objects when they matter for the goal.
- Apps are constants, never parameters: declare the apps the task uses in the domain's
  `(:constants venmo phone ... - app)` and refer to them directly in preconditions and effects
  (`(has-token venmo ?t)`). An action's name already fixes its app, so `venmo-login` must NOT take
  an `?a - app` parameter; `(venmo-login venmo ...)` is wrong, `(venmo-login ?u ?pw ?t)` is right.
- Types: root type `object`; standard subtypes `app`, `person`, `account`, plus task-specific
  entity types (e.g. `payment-request`, `email`, `song`, `playlist`, `task-item`, `note`, `order`).
  Declare only the types the task needs.
- Actions: each action corresponds to exactly one AppWorld API and is named `<app>-<api_name>` with
  underscores replaced by hyphens (e.g. `venmo-login`, `venmo-create-payment-request`,
  `supervisor-complete-task`). Only use APIs that exist in the API index below. Model the API
  parameters that matter as action parameters. Give every action a one-line `;` comment stating
  the exact API name (e.g. `; API: venmo.create_payment_request`).
- Standard predicates (reuse these names whenever applicable):
  `(passwords-known)` (effect of the nullary `supervisor-show-account-passwords`),
  `(password-for ?a - app ?pw - password)` (static fact in `:init` naming each app's password
  object), `(has-token ?a - app ?t - token)` (effect of `<app>-login`), `(known-id ?x)` /
  `(known-email ?p ?e)` (an identifier has been discovered by a lookup API), `(task-completed)`,
  plus task-specific state predicates that
  mirror the database changes the task must cause (created/sent/deleted/updated/added/...), and
  `(found ...)` style knowledge predicates for information the agent must retrieve.
- Task completion ordering (mandatory): `supervisor-complete-task` must be the LAST action of any
  plan. Enforce this structurally: (1) its precondition is the conjunction of every task-specific
  goal condition (everything in the problem's `:goal` except `(task-completed)`) plus
  `(not (task-completed))`; (2) every other action has `(not (task-completed))` in its
  precondition; (3) `(task-completed)` appears in the effect of `supervisor-complete-task` only.
  Pass the answer entities as parameters of `supervisor-complete-task` when the task asks a question.
- Executable steps (mandatory): every plan step must carry enough information to make the API call.
  Each action's `:parameters` must include one parameter for EVERY required parameter of its API
  (in the API's order), plus any optional API parameter the task actually uses (e.g. `query` for a
  search, `description`/`private` for a payment request). Extra parameters that are not API
  arguments (e.g. the record being created) are allowed and come after the API parameters.
  Examples: `supervisor-show-account-passwords` takes no parameters (effect `(passwords-known)`);
  `venmo-login` takes `(?u - username ?pw - password ?t - token)` with precondition
  `(and (passwords-known) (password-for venmo ?pw) (not (has-token venmo ?t)) ...)`; actions that
  need an access token take `?t - token` with precondition `(has-token venmo ?t)`;
  `supervisor-complete-task` takes the answer object when the task asks a question, otherwise no
  API parameters. Never add parameters that are neither API arguments nor task records.
- Runtime values: credentials, tokens and looked-up identifiers are objects too. Use types
  `username`, `password`, `token`, `email`, `query`, `amount`, `note`, `privacy` (or similar) and
  model how they are obtained: `supervisor-show-account-passwords` makes `(passwords-known)`
  true, `<app>-login` with the app's password makes `(has-token <app> ?t)` true, a search makes
  `(known-email ?p ?e)` true, etc. Name objects by their value where possible
  (`joyce-weav-at-gmail-com`, `amount-13`, `note-for-yesterdays-meal`, `query-stacy`).
- Parameter types: never type a parameter as `object`; use a declared concrete type.
- Also return `action_params`: for every action, the API parameter name of each PDDL parameter in
  order (`null` for a PDDL parameter that is not an API argument), and `bindings`: for every
  problem object that an API call consumes, either its literal `value` or the API call and
  response `field` it is read from at runtime (e.g. the venmo password comes from
  `supervisor.show_account_passwords`, field `password` where `account_name == "venmo"`; the
  token from `venmo.login`, field `access_token`; a friend's email from `venmo.search_friends`,
  field `email`).
- Information gathering: when a task needs facts the agent does not initially know (a friend's
  Venmo id, a song title, an order total), add a lookup/search action whose effect asserts the
  corresponding knowledge predicate, and make downstream actions require it.
- Problem file: objects for the supervisor, the apps involved, and every entity named or implied
  by the instruction. `:init` holds only what is known before any API call (nothing is logged in,
  no passwords known, entities exist but ids are not known). `:goal` is a conjunction that is true
  exactly when the task is correctly completed, including `(task-completed)`. Use the ground-truth
  evaluation (when given) to decide precisely which state changes the goal must demand, but never
  reference evaluation internals in the PDDL.
- Keep the model minimal but sufficient: it should be solvable by an off-the-shelf classical
  planner (e.g. Fast Downward) and the plan should correspond to a valid API call sequence.
- Both files must be syntactically valid PDDL with balanced parentheses, lowercase hyphenated
  names, and the problem's `(:domain ...)` must match the domain name. PDDL names must start
  with a letter, so with the task id's underscore replaced by a hyphen use domain name
  `appworld-<task-id>` and problem name `task-<task-id>` (e.g. task 024c982_1 gives domain
  `appworld-024c982-1` and problem `task-024c982-1`).

API index (app.api_name(parameters; `?` marks optional) [HTTP method] description):
{api_index}
"""

USER_PROMPT_TEMPLATE = """Convert the following AppWorld task into a PDDL domain and problem.

task_id: {task_id}
instruction: {instruction}
supervisor: {supervisor}
current datetime: {datetime}
difficulty: {difficulty}   num_apps: {num_apps}   num_apis (reference solution): {num_apis}
{ground_truth_section}{solution_section}
Return the domain file, the problem file, the list of apps used, the expected API call sequence
(one `app.api_name` per element, in order, as a reference plan), and brief modeling notes."""

GROUND_TRUTH_TEMPLATE = """
Ground-truth hints (use them to make the goal precise; do not copy them verbatim into the PDDL):
public_data: {public_data}
{private_section}evaluation code (describes the database changes that must hold when the task is done):
```python
{evaluation_code}
```
"""


SOLUTION_TEMPLATE = """
Reference solution (the API call sequence a correct agent makes; model exactly these APIs as actions,
one action per distinct API, and derive the lookup/knowledge structure from how values flow between calls):
required apps: {required_apps}
required APIs: {required_apis}
```python
{compiled_solution}
```
"""


def build_system_prompt(api_index: str) -> str:
    return SYSTEM_PROMPT_TEMPLATE.format(api_index=api_index)


def build_user_prompt(task: Task, include_ground_truth: bool = True,
                      include_private: bool = False, include_solution: bool = False) -> str:
    md = task.metadata or {}
    solution_section = ""
    if include_solution and task.has_solution:
        solution_section = SOLUTION_TEMPLATE.format(
            required_apps=json.dumps(task.required_apps or []),
            required_apis=json.dumps(task.required_apis or []),
            compiled_solution=task.compiled_solution.strip(),
        )
    if include_ground_truth:
        private_section = ""
        if include_private and task.private_data:
            private_section = f"private_data (identifiers the agent must discover via lookup APIs): " \
                              f"{json.dumps(task.private_data, sort_keys=True)}\n"
        gt = GROUND_TRUTH_TEMPLATE.format(
            public_data=json.dumps(task.public_data, sort_keys=True),
            private_section=private_section,
            evaluation_code=task.evaluation_code.strip(),
        )
    else:
        gt = ""
    return USER_PROMPT_TEMPLATE.format(
        task_id=task.task_id,
        instruction=task.instruction,
        supervisor=json.dumps(task.supervisor, sort_keys=True),
        datetime=task.datetime,
        difficulty=md.get("difficulty", "?"),
        num_apps=md.get("num_apps", "?"),
        num_apis=md.get("num_apis", "?"),
        ground_truth_section=gt,
        solution_section=solution_section,
    )


OUTPUT_SCHEMA = {
    "type": "object",
    "properties": {
        "domain_pddl": {"type": "string", "description": "Full contents of domain.pddl"},
        "problem_pddl": {"type": "string", "description": "Full contents of problem.pddl"},
        "apps_used": {"type": "array", "items": {"type": "string"}},
        "api_sequence": {
            "type": "array",
            "items": {"type": "string"},
            "description": "Reference plan as ordered app.api_name strings",
        },
        "action_params": {
            "type": "array",
            "description": "For each domain action, the API parameter name of each PDDL parameter in order",
            "items": {
                "type": "object",
                "properties": {
                    "action": {"type": "string", "description": "PDDL action name"},
                    "api": {"type": "string", "description": "app.api_name"},
                    "params": {
                        "type": "array",
                        "items": {"type": ["string", "null"]},
                        "description": "API parameter name per PDDL parameter, null if not an API argument",
                    },
                },
                "required": ["action", "api", "params"],
                "additionalProperties": False,
            },
        },
        "bindings": {
            "type": "array",
            "description": "How each problem object used as an API argument gets its concrete value",
            "items": {
                "type": "object",
                "properties": {
                    "object": {"type": "string", "description": "PDDL object name"},
                    "value": {"type": ["string", "null"], "description": "Literal value, or null if runtime"},
                    "from_api": {"type": ["string", "null"], "description": "app.api_name whose response provides it"},
                    "field": {"type": ["string", "null"], "description": "Response field / selection rule"},
                },
                "required": ["object", "value", "from_api", "field"],
                "additionalProperties": False,
            },
        },
        "notes": {"type": "string", "description": "Brief modeling notes and assumptions"},
    },
    "required": ["domain_pddl", "problem_pddl", "apps_used", "api_sequence",
                 "action_params", "bindings", "notes"],
    "additionalProperties": False,
}


REPAIR_PROMPT_TEMPLATE = """The PDDL you produced was checked with a parser and the Fast Downward planner and it failed:

{findings}

Fix the model so that it parses, is solvable, every plan ends with supervisor-complete-task as the
only final action (see the ordering rules), and every action carries the parameters its API needs
(see the executable-steps rules) with matching `action_params` and `bindings`. Return the complete corrected domain and problem files in
the same JSON format; do not return partial files or diffs."""


def build_repair_prompt(report: dict, planning: dict | None) -> str:
    findings: list[str] = []
    for e in report.get("errors", []):
        findings.append(f"- validation error: {e}")
    for e in report.get("api_issues", []):
        findings.append(f"- executability error: {e}")
    ref = report.get("reference_check") or {}
    if ref.get("missing"):
        findings.append(f"- reference mismatch: required APIs with no action in the domain: {ref['missing']}")
    for w in report.get("warnings", []):
        if "pddl-lib" in w:
            continue  # stricter-than-standard library; not actionable
        findings.append(f"- structure warning: {w}")
    if planning:
        findings.append(f"- planner result: {planning.get('status')}")
        if planning.get("message"):
            findings.append(f"- planner message: {planning['message']}")
        if planning.get("plan"):
            findings.append("- plan found by the planner (wrong if it does not end with "
                            "supervisor-complete-task):\n    " + "\n    ".join(planning["plan"]))
    return REPAIR_PROMPT_TEMPLATE.format(findings="\n".join(findings) or "- unknown failure")
