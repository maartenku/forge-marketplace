# Rules every project inherits

Copied into the Rules block of `CLAUDE.md`.

## Data and environments
- Work against the sandbox in `environments/sandbox/` (seeded database, example files, stubs). Use real data or real accounts only when a task explicitly says so, and then read-only unless told otherwise.
- Secrets live only in `.env`, which is git-ignored. Keep `.env.example` complete. Nothing secret goes into code, docs or commits.
- The sandbox is rebuildable with one script, `scripts/sandbox-reset.sh`. If it cannot be rebuilt, it is not a sandbox.

## Dependencies and supply chain
- Lockfiles are committed (`pnpm-lock.yaml` or `package-lock.json`, and NuGet `packages.lock.json` via `RestorePackagesWithLockFile`). Installs run frozen in `scripts/test.sh` and in CI when there is one.
- No package version younger than 7 days. Mechanisms: pnpm `minimumReleaseAge`, npm `--before=[date]`, Dependabot's cooldown on GitHub; for NuGet, check the publish date by hand.
- Fewest sane dependencies. Before adding one, ask: can the framework do it? Is it maintained? Is it small? Write the package and the reason in `docs/technical/architecture/dependencies.md` before installing.
- Audits run in `scripts/test.sh`: `pnpm audit` and `dotnet list package --vulnerable --include-transitive`. Pin majors. No `latest`, no `*`.

## Process discipline
- Know the phase. Read `docs/README.md` at session start and state the phase and the next gate before working.
- Plan before implementing. No feature code without `docs/technical/features/*/[slug]/plan.md`; no foundation code without `docs/technical/architecture/foundation-plan.md`.
- Sync docs in the same change: the repo folder move, the functional `status`, the Roadmap line, `docs/README.md`.
- Copy foundations before generating them. Check `docs/technical/architecture/overview.md` under "Reusable pieces" and the kit's `foundations/README.md` first.
- Deviations from the stack are ADRs in `docs/technical/architecture/decisions/`.
- Ask when the gate is not met. Never invent missing input.

## Code and quality
- Clean Architecture on the backend (Domain, Application, Infrastructure, Api); feature folders on the frontend.
- Tests: unit tests for Application, integration tests per endpoint group, Vitest for Web, one Playwright smoke test for the user journey. All run through `scripts/test.sh`.
- Prefer boring, well-known patterns. Small commits, Conventional Commits with the feature slug as scope.
- Git: `main` plus `feat/[slug]` per feature (or per implementation plan). Never run `git push` without asking the user first; pushing is always a question. Committing locally is fine. When a change is large or unusual, ask before committing too.

## Scope and pace
- Ship the thinnest slice that proves the user journey. Polish later. Extra ideas go into the functional feature index with status `idea`.
- Time-box decisions. If one takes more than a session, take the default and write the ADR.
