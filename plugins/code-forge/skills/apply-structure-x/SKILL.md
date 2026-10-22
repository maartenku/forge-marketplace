---
name: apply-structure-x
description: code-forge workflow. Brings an existing project (a repo, with or without separate functional docs) in line with the kit: restructures folders, rewrites feature notes and implementation plans to the templates, reconciles every status against what the code actually contains, interviews the user on the intended stack, and writes a plan to converge the codebase on it. Use when the user says "apply the structure", "migrate this project to the workflow", "adopt code-forge here", "clean up this repo's docs", or points the kit at a project that predates it.
---

# apply-structure-x

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

Bring an existing project under the code-forge workflow without losing anything. Work in five stages: inventory, interview, plan, execute (after approval), report. Stop for approval after the plan. Never delete. Move with `git mv`. Anything you cannot map goes to `docs/_legacy/` with a note saying why.

## Before you start

1. Confirm the repo root (current directory) and whether functional docs already exist somewhere: in the repo, or in an external folder such as an Obsidian vault (`--add-dir`, or ask). Either may be missing.
2. Read `${CLAUDE_PLUGIN_ROOT}/reference/workflow.md`, `rules.md`, `profiles/README.md`, and the repo template under `${CLAUDE_PLUGIN_ROOT}/templates/repo/` so you know the target shape.

## Stage 1: inventory (read only)

Produce a short inventory before touching anything.

- Repo layout: top-level folders, where code lives, where docs live, existing `CLAUDE.md`, README and ADRs, scripts, CI files, env handling, lockfiles, package manifests.
- Docs found: every markdown file that looks like a feature spec, implementation plan, design, architecture note or status list. For each: path, what it is, which feature it belongs to (guess a slug), its stated status if any.
- Vault folder, if present: hub, Whitepaper, Roadmap, feature notes and their `status`, non-canonical notes and folders.
- Code evidence per feature: for each candidate slug, grep the codebase for its endpoints, components, entities, migrations and tests; check `git log --oneline -- [paths]` and whether its tests pass. Classify it as done, partial, not started or unknown, and keep the evidence (files, test names, commit hashes).
- Current stack: frontend framework and version, backend framework, ORM and database, auth approach, API docs tooling (Swagger, OpenAPI, generated client), hosting hints (Dockerfiles, compose), CI, git host, dependency count.

## Stage 2: interview

Ask in one round, at most eight questions, only what the inventory cannot answer.

1. Intended base profile and extensions (hosting, auth, database, source control) from `reference/profiles/README.md`. Show the current stack next to the default so the user picks "keep", "default" or "other" per block.
2. Vault folder: use the existing one, create one with `/code-forge:new-project-1`, or none (repo-only project)?
3. Which legacy docs win when two disagree?
4. Features you classified partial or unknown: done or not?
5. Anything that must not move (paths other tools depend on)?
6. Source control: local git only, or GitHub; whether a remote exists; the merge strategy if branches are involved.

## Stage 3: plan

Write `docs/technical/architecture/adoption-plan.md` from `${CLAUDE_PLUGIN_ROOT}/templates/adoption-plan.md`. Five sections, a table in each.

1. Folder moves: source to target for every path, following `templates/repo/` (`docs/technical/architecture/`, `docs/technical/designs/`, `docs/technical/features/{backlog,in-progress,done}/[slug]/`, `docs/technical/setup/`, `environments/sandbox/`, `scripts/`). Unmappable files go to `docs/_legacy/[original-path]`.
2. Document rewrites: which files become which template. Feature specs become functional `features/[slug].md` (per `feature-define-2`) and/or repo `plan.md` (technical, per `docs/technical/features/_plan-template.md`); architecture notes become `overview.md`, `stack.md` or ADRs; setup docs become `docs/technical/setup/*`; the existing `CLAUDE.md` is merged with the template. Mark what is extracted and what is rewritten.
3. Status reconciliation: one row per feature with slug, legacy status, code evidence, proposed state (`backlog`, `in-progress` or `done`), functional `status`, confidence. Low-confidence rows are the questions from Stage 2.
4. Stack convergence: the chosen base and extensions against the current stack, gap by gap (for example "Swagger UI to Scalar plus NSwag client", "no lockfile to lockfile plus 7-day rule", "controllers without Mediator to Mediator handlers per use case", "PostgreSQL to SQL Server Express or SQLite, or an ADR to keep it"). For each gap: keep (ADR) or converge. Converge items become `docs/technical/features/backlog/adopt-[gap]/plan.md` entries, ordered by risk. This skill does not execute them.
5. Sandbox and scripts: what exists, what the five scripts plus `generate-api.sh` will wrap, what `environments/sandbox/` needs.

Stop. Show the plan and ask for approval per section. The user may approve 1 to 3 now and defer 4 and 5.

## Stage 4: execute (approved sections only, in this order, one commit per step)

1. Skeleton: copy the missing pieces of `templates/repo/` (never overwrite); merge the template's Loop, Docs and Rules sections into the existing `CLAUDE.md`, keeping the user's content; fill the blanks.
2. Folder moves with `git mv`; update links inside moved docs to repo-root-relative paths. Commit `chore(adopt): restructure docs`.
3. Rewrites: functional feature notes (one per feature, functional, keeping existing wording where it is good); repo `plan.md` files in the template shape with the legacy text kept under an "Original notes" heading; `overview.md`, `stack.md` (composed from the chosen profiles) and ADRs for every "keep" decision; `docs/technical/setup/*`; `docs/README.md` with the phase header. Commit `docs(adopt): rewrite to templates`.
4. Status reconciliation: place each `plan.md` in `backlog/`, `in-progress/` or `done/` per the approved table; set `status:` and `updated:`; for `done` write an "As built" section from the code evidence; set the functional `status`, add Roadmap lines, update the `docs/README.md` rows. Commit `docs(adopt): reconcile status`.
5. Convergence backlog: create the `adopt-[gap]` plan folders from section 4 of the plan. Commit `docs(adopt): stack convergence backlog`.
6. If the functional docs live in an Obsidian vault that keeps an index of projects, update it.
7. Ask before pushing. Then run `/code-forge:status-check-x` and paste its output.

## Stage 5: report

Files moved, files rewritten, the final status table, the convergence backlog in order, what went to `docs/_legacy/`, and the open questions.

## Rules

- Read only until the plan is approved. Never delete. Never rewrite code; convergence is a backlog, executed later through `feature-plan-6` and `feature-implement-7`.
- Code evidence beats legacy status. When they disagree and the user has not ruled, mark the feature `in-progress` and say why.
- Functional notes never move for status. They may move once for structure (into `features/`, `design/`, `setup/`), and only with the user's approval in the plan.
- Every "keep the current choice" is an ADR, not a silent exception.
- `${CLAUDE_PLUGIN_ROOT}/reference/rules.md` applies: sandbox over real data, no pushes without asking.
