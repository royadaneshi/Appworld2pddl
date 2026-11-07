"""Load AppWorld tasks and API documentation from the appworld_data folder."""
from __future__ import annotations

import json
from dataclasses import dataclass, field
from pathlib import Path

DATA_ROOT = Path(__file__).resolve().parent.parent / "appworld_data" / "data"
TASKS_DIR = DATA_ROOT / "tasks"
API_DOCS_DIR = DATA_ROOT / "api_docs" / "standard"
DATASETS_DIR = DATA_ROOT / "datasets"


@dataclass
class Task:
    task_id: str
    instruction: str
    supervisor: dict
    datetime: str
    metadata: dict
    public_data: dict
    private_data: dict
    evaluation_code: str
    answer: object
    path: Path = field(repr=False)
    compiled_solution: str | None = None   # train/dev only
    required_apis: list[str] | None = None  # train/dev only
    required_apps: list[str] | None = None  # train/dev only

    @property
    def has_solution(self) -> bool:
        return self.compiled_solution is not None


def _read_json(path: Path, default=None):
    if not path.exists():
        return default
    with path.open() as f:
        return json.load(f)


def list_task_ids(split: str | None = None) -> list[str]:
    """Return task ids for a dataset split (train/dev/test_normal/test_challenge) or all tasks."""
    if split and split != "all":
        ids: list[str] = []
        for name in split.split(","):  # e.g. "train,dev"
            split_file = DATASETS_DIR / f"{name.strip()}.txt"
            if not split_file.exists():
                raise FileNotFoundError(f"Unknown split '{name}'. Available: "
                                        + ", ".join(p.stem for p in sorted(DATASETS_DIR.glob('*.txt'))))
            ids += [line.strip() for line in split_file.read_text().splitlines() if line.strip()]
        return list(dict.fromkeys(ids))  # de-duplicate, keep order
    return sorted(p.name for p in TASKS_DIR.iterdir()
                  if p.is_dir() and p.name != "_base_" and (p / "specs.json").exists())


def load_task(task_id: str) -> Task:
    path = TASKS_DIR / task_id
    specs = _read_json(path / "specs.json")
    if specs is None:
        raise FileNotFoundError(f"No specs.json for task {task_id} at {path}")
    gt = path / "ground_truth"
    eval_path = gt / "evaluation.py"
    return Task(
        task_id=task_id,
        instruction=specs["instruction"],
        supervisor=specs.get("supervisor", {}),
        datetime=specs.get("datetime", ""),
        metadata=_read_json(gt / "metadata.json", {}),
        public_data=_read_json(gt / "public_data.json", {}),
        private_data=_read_json(gt / "private_data.json", {}),
        evaluation_code=eval_path.read_text() if eval_path.exists() else "",
        answer=_read_json(gt / "answer.json"),
        path=path,
        compiled_solution=(gt / "compiled_solution.py").read_text()
        if (gt / "compiled_solution.py").exists() else None,
        required_apis=_read_json(gt / "required_apis.json"),
        required_apps=_read_json(gt / "required_apps.json"),
    )


def load_api_index() -> str:
    """Build a compact, deterministic text index of every app API.

    One line per API: app.api_name(params) -> description. Deterministic ordering
    keeps the text byte-identical across runs so it can be prompt-cached.
    """
    lines: list[str] = []
    for doc_path in sorted(API_DOCS_DIR.glob("*.json")):
        app = doc_path.stem
        apis = _read_json(doc_path)
        lines.append(f"\n## app: {app}")
        for api_name in sorted(apis):
            api = apis[api_name]
            params = []
            for p in api.get("parameters", []):
                marker = "" if p.get("required") else "?"
                params.append(f"{p['name']}{marker}: {p.get('type', 'any')}")
            desc = " ".join(api.get("description", "").split())
            lines.append(f"- {app}.{api_name}({', '.join(params)}) [{api.get('method', '')}] {desc}")
    return "\n".join(lines).strip()


def load_app_names() -> list[str]:
    return sorted(p.stem for p in API_DOCS_DIR.glob("*.json"))


def load_api_params() -> dict[str, dict]:
    """Map 'app.api_name' -> {'required': [...], 'optional': [...], 'types': {name: type}, 'action': pddl-name}."""
    table: dict[str, dict] = {}
    for doc_path in sorted(API_DOCS_DIR.glob("*.json")):
        app = doc_path.stem
        for api_name, api in _read_json(doc_path).items():
            params = api.get("parameters", [])
            table[f"{app}.{api_name}"] = {
                "required": [q["name"] for q in params if q.get("required")],
                "optional": [q["name"] for q in params if not q.get("required")],
                "types": {q["name"]: q.get("type", "string") for q in params},
                "action": f"{app}-{api_name}".replace("_", "-"),
            }
    return table
