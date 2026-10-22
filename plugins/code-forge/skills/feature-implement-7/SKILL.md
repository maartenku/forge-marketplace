---
name: feature-implement-7
description: Phase 6.2 to 6.4 of the code-forge workflow. Implements a reviewed feature plan on a feat/[slug] branch, moves the feature doc through in-progress to done, writes the "As built" section, and syncs the functional feature note, Roadmap and docs/README.md. Use when the user says "implement X", "build feature X", or "start on X".
---

# feature-implement-7

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

You are running Phase 6.2 to 6.4 of the code-forge workflow for one feature, identified by its slug. Build it to its plan, then move its documentation to done and sync the functional docs.

## Before you start: the gate

`docs/technical/features/backlog/[slug]/plan.md` must exist and the user must confirm it was reviewed. Otherwise stop and point to `/code-forge:feature-plan-6 [slug]`.

## Steps

Start (6.2)
1. Create the branch from `main`: `git switch -c feat/[slug]`. If the plan says the feature is split into several implementation plans, use one branch per plan.
2. Move the docs: `git mv docs/technical/features/backlog/[slug] docs/technical/features/in-progress/[slug]`. Set `status: active` and today's date in `updated:`.
3. In the functional docs, set the feature note's `status: active`, bump `modified`, update `features/README.md`, and mention the feature in the hub. Commit `docs([slug]): start`.

Build (6.3)
4. Implement the plan layer by layer with tests alongside. After any endpoint change run `scripts/generate-api.sh` and commit the regenerated client; never hand-edit `api.generated.ts`. Commit small: `feat([slug]): …`, `test([slug]): …`. Run only against `environments/sandbox/`.
5. If you need a package the plan's dependency delta does not list, stop and ask. On approval add it to `dependencies.md` first.

Finish (6.4)
6. If this feature added packages, run `/code-forge:deps-audit-x` first. Then run `scripts/test.sh` until green. Walk every acceptance criterion in `plan.md` and tick it. If one is unmet, the feature is not done; say so and stop here.
7. Merge into `main` locally (ask which merge strategy if the project has not decided; suggest squash) and delete the branch. Ask before pushing `main` or the branch. Never push on your own.
8. Move the docs: `git mv docs/technical/features/in-progress/[slug] docs/technical/features/done/[slug]`. Set `status: done` and fill the "As built" section: deviations from the plan, follow-ups, what the next session should know.
9. Sync the functional docs: feature note `status: done`, `features/README.md`, a Roadmap line "[date]: [feature] done", the hub callout, a `log.md` entry if the project keeps one. Update the feature's row and the phase header in `docs/README.md`. Commit `docs([slug]): done`.
10. Report what shipped, the follow-ups, and the next candidate feature.

## Rules

- One feature per run.
- Never finish with failing tests, unmet criteria, or anything that touched real data.
- Bugs and ideas you meet on the way go into Follow-ups, not into this feature.
- `${CLAUDE_PLUGIN_ROOT}/reference/rules.md` applies throughout.
