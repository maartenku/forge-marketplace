# {{PROJECT}}: docs

> Phase 3, Architecture. Next gate: `technical/architecture/overview.md` and `foundation-plan.md` approved. Updated {{DATE}}.

Functional docs (what and why): `{{FUNCTIONAL_PATH}}`. Technical docs (how): `docs/technical/`.

| Folder | Holds |
|---|---|
| `technical/architecture/` | overview, stack, dependencies, foundation plan, `decisions/` |
| `technical/designs/` | design output, one folder per screen or flow |
| `technical/features/backlog`, `in-progress`, `done/` | `[slug]/plan.md`; the folder is the state |
| `technical/setup/` | environments, sandbox, scripts |

## Features
| Slug | Functional note | Technical folder | Design |
|---|---|---|---|
{{FEATURE_ROWS}}

## Run
From Phase 4: `scripts/sandbox-up.sh && scripts/dev.sh`
