# Features

`[slug]/plan.md` per feature, copied from `_plan-template.md`. The folder is the state:

| Folder | Functional `status` |
|---|---|
| `backlog/` | `planned` |
| `in-progress/` (branch `feat/[slug]`) | `active` |
| `done/` (has an "As built" section) | `done` |

Move the folder, `status:`, the functional note and the Roadmap in one change (`/code-forge:status-sync-x` checks). Use repo-root-relative links so moves do not break them.
