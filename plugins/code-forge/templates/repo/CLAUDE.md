# CLAUDE.md: {{PROJECT}}

## Project
- What: {{PROMISE}}
- Functional docs (what and why: hub, feature notes, roadmap, user journey): `{{FUNCTIONAL_PATH}}`. If this is outside the repo, sessions start with `claude --add-dir "{{FUNCTIONAL_PATH}}"`; if it is not readable, ask before planning.
- Technical docs (how): `docs/technical/`. The map is in `docs/README.md`.
- Repo: {{REPO_URL}} (source control: {{GIT_HOST}}).
- Feature slugs: {{SLUGS}}. One slug is the functional note `features/[slug].md`, the folder `docs/technical/features/*/[slug]/`, the branch `feat/[slug]` and the commit scope.
- Skills: the `code-forge` plugin (`/code-forge:*`). Copies in `.claude/skills/`, if any, come from the kit; edit them there.

## Loop
0 Idea, 1 Define (functional docs), 2 Repo, 3 Architecture, 4 Foundation and sandbox, 5 Design, 6 Features (plan, implement, sync), 7 Verify, back to 6.

- Session start: `/code-forge:status-check-x`. State the phase and the next gate. If the gate's inputs are missing, stop and say so.
- No application code before `docs/technical/architecture/foundation-plan.md` is approved. No feature code before its `plan.md` is reviewed. Plan the next feature only.
- Deviations from `docs/technical/architecture/stack.md` get an ADR in `docs/technical/architecture/decisions/`.

## Docs you keep in sync, in the same change
- `docs/technical/features/{backlog,in-progress,done}/[slug]/plan.md`: the folder is the state and `status:` matches it. Technical plans move; functional notes never move, they carry `status`.
- A feature starts: move to `in-progress/`, functional note `active`. A feature finishes: move to `done/`, write "As built", functional note `done`, a roadmap line, update `docs/README.md` and `features/README.md`.
- `docs/technical/architecture/dependencies.md` lists every package with its reason, written before installing.

## Rules (shared across projects; edit them in the kit, not here)
- Work in the sandbox (`environments/sandbox/`), never with real data unless the task says so, and then read-only.
- Secrets only in `.env`. Keep `.env.example` complete.
- Lockfiles committed and frozen in CI. No package version younger than 7 days. Fewest sane dependencies.
- Copy foundations before generating them (`overview.md` under Reusable pieces; the kit's `foundations/`).
- Clean Architecture on the backend, feature folders on the frontend. Tests run through `scripts/test.sh`: unit for Application, integration for Api, Vitest for Web, one Playwright smoke test.
- Git: `main` plus `feat/[slug]`, Conventional Commits with the slug as scope. Never push without asking. Ask before committing anything large or unusual.
- When unsure, ask. Never invent missing input.

## Commands
`scripts/sandbox-up.sh`, `scripts/sandbox-reset.sh`, `scripts/dev.sh`, `scripts/test.sh`, `scripts/build.sh`, `scripts/generate-api.sh` (regenerates the NSwag client; never hand-edit `api.generated.ts`). Details in `docs/technical/setup/`.

## Done, per feature
Plan reviewed, criteria met, `scripts/test.sh` green, merged, docs moved and "As built" written, functional docs synced, `docs/README.md` updated.
