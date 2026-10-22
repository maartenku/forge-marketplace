---
name: deps-audit-x
description: code-forge workflow dependency audit. Verifies lockfiles are committed and frozen in CI, flags any package version younger than 7 days, finds unused or duplicate dependencies, runs the npm/pnpm and dotnet vulnerability audits, and updates docs/technical/architecture/dependencies.md. Use before merging a foundation or any feature that added packages, when the user says "audit dependencies" or "check packages", or weekly on active projects.
---

# deps-audit-x

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

Audit this repository's dependencies against the kit rules in `${CLAUDE_PLUGIN_ROOT}/reference/rules.md` and bring `docs/technical/architecture/dependencies.md` back in line with what is installed.

## Steps

1. Lockfiles. Confirm `pnpm-lock.yaml` or `package-lock.json`, and `packages.lock.json` for .NET, exist and are tracked by git, and that installs run frozen in `scripts/test.sh` and in CI when there is one (`pnpm install --frozen-lockfile`, `dotnet restore --locked-mode`). Report any gap.
2. Minimum age. For every direct dependency, look up the publish date of the pinned version (`npm view [pkg]@[version] time --json`; for NuGet, `https://api.nuget.org/v3/registration5-semver1/[id]/[version].json`, field `published`). Flag anything younger than 7 days and name the newest older version that qualifies. Confirm `minimumReleaseAge` is configured for pnpm, and for Dependabot when the repo is on GitHub.
3. Unused and duplicate. JavaScript: run `pnpm dlx depcheck` or grep the imports. .NET: compare `dotnet list package` with the actual `using`s and references. Flag two packages doing the same job (two HTTP clients, two validation libraries).
4. Vulnerabilities. Run `pnpm audit --audit-level moderate` and `dotnet list package --vulnerable --include-transitive`. Treat moderate and above as failures.
5. Reconcile the doc. Every direct package needs a row in `dependencies.md` with a reason; packages that are no longer installed move to "Rejected / removed".
6. Present a table (package, version, age, used, vulnerabilities, proposed action) and the removals or downgrades you propose. Apply them only after the user confirms, then commit `chore(deps): audit [date]`. Ask before pushing.

## Rules

- Never fix a vulnerability by upgrading to a version younger than 7 days. Take the oldest fixed version that qualifies, or pin and record the exception as an ADR.
