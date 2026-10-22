---
name: foundation-5
description: Phase 4 of the code-forge workflow. Implements the approved foundation plan copy-first (project layout, auth, DB wiring, API contract, CI), builds the sandbox under environments/sandbox/, implements the scripts, runs the first dependency audit, and proves the gate (fresh clone runs the empty app, tests green). Use when the user says "build the foundation", "implement the foundation plan", or the repo is at loop phase 4.
---

# foundation-5

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

You are running Phase 4 of the code-forge workflow. Implement the approved foundation plan, build the sandbox and the scripts, and prove that a fresh clone runs. Build no features.

## Before you start: the Phase 3 gate

`docs/technical/architecture/foundation-plan.md` must exist and carry an "Approved by" name and date. If it does not, stop and point the user to `/code-forge:architecture-4`, or ask for approval.

## Steps

1. Re-read `foundation-plan.md`, `stack.md`, `dependencies.md`, `${CLAUDE_PLUGIN_ROOT}/reference/rules.md` and `${CLAUDE_PLUGIN_ROOT}/foundations/README.md`.
2. Do the copy-from steps first: copy the listed pieces, rename namespaces and project names, strip what this project does not need, and record the source and your adaptations in `overview.md` under "Reusable pieces". Only then do the generate steps.
3. Install only the packages listed in `dependencies.md`, pinned. Check that each pinned version is at least 7 days old. Configure pnpm `minimumReleaseAge` (`.npmrc` or `pnpm-workspace.yaml`) and NuGet `RestorePackagesWithLockFile`. Commit the lockfiles.
4. Build `environments/sandbox/` as the plan describes: the dev database (compose file or SQLite), `seed/` with realistic fake data, `fs/` if the app touches folders, `stubs/` for external APIs, seeded dev users. Document it in `docs/technical/setup/sandbox.md`.
5. Implement `scripts/dev.sh`, `sandbox-up.sh`, `sandbox-reset.sh`, `test.sh` (tests plus the dependency audits), `build.sh`, and for stacks with an HTTP API `generate-api.sh` (OpenAPI export plus the NSwag client, with a drift check in `scripts/test.sh` and in CI when there is one). Document them in `docs/technical/setup/scripts.md` and `docs/technical/setup/environments.md`.
6. With GitHub, complete the CI workflow: toolchain setup, frozen installs, `scripts/test.sh`. With local git there is no CI; make sure `scripts/test.sh` runs cleanly by hand.
7. Prove the gate and paste the evidence in your final message: from a fresh clone, `scripts/sandbox-up.sh` then `scripts/dev.sh` serves the empty app; `scripts/test.sh` is green locally, and in CI when there is one.
8. Run `/code-forge:deps-audit-x`. This is the first moment real packages exist. Fix what it flags.
9. Sync: add "foundation done ([date])" to the functional roadmap (`roadmap.md`), set the hub to `Loop phase: 5`, update the `docs/README.md` header to phase 5 (design) and fill its run section. Commit in small `feat(foundation): …` commits throughout. Ask before pushing.

## Rules

- No feature code. If a plan step needs a product decision, stop and ask.
- Never touch real data or external accounts.
- When you generate something reusable (a Dockerfile, a seeder, the OpenAPI/NSwag wiring, a CI setup), tell the user so it can be added as a pointer to the kit's `foundations/README.md`.
