---
name: feature-define-2
description: code-forge workflow. Writes or refines the functional note for one feature ([functional root]/features/[slug].md) from the user's high-level expectations, asking only what is unclear. Use when the user says "add a feature", "define feature X", "new feature idea", or wants a feature described before it is planned technically. Called by new-project-1 for each initial feature; the entry point for every later feature.
---

# feature-define-2

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

Write the functional note for one feature: what it does, for whom, and how we know it is done. No technical plan here; that is `/code-forge:feature-plan-6`, later, once the stack exists.

## Before you start

1. Find the functional root: the `Functional docs:` line in `CLAUDE.md`, or `docs/functional` if it exists, or ask. If it is outside the repo and not readable, ask for `--add-dir` and stop.
2. You need the user's high-level expectations for the feature. A few lines is enough. If you have nothing, ask for them in one question.

## Steps

1. Read the hub (`README.md`), the whitepaper (for scope boundaries), `features/README.md`, `setup/user-journey.md`, and the template `${CLAUDE_PLUGIN_ROOT}/templates/functional/feature.md`. Check whether a note for this feature already exists. If it does, you are refining it, not creating a second one.
2. Ask only the per-feature questions from `${CLAUDE_PLUGIN_ROOT}/templates/functional/feature-interview.md` (numbers 5 to 8) that the expectations leave open. At most four, in one message. Wait for the answers.
3. Choose the slug: kebab-case, short, unique within the project. It is the filename, the `slug:` field, the technical plan folder, the branch and the commit scope.
4. Write `features/[slug].md` from the template: `type: feature`, `status: planned`, the sections filled, acceptance criteria as two to five observable statements. Mark guesses with "Assumption:".
5. Add the row to `features/README.md`. If the feature changes the user journey, say so and propose the edit; do not change the journey silently.
6. If the repo exists, add the feature's row to `docs/README.md` (functional note, `backlog/[slug]/ (not planned yet)`, no design yet).
7. If the functional root is in the repo, commit `docs(functional): define [slug]`; ask before pushing.
8. Report: the note path, the slug, open questions, and the next step. That is `/code-forge:feature-plan-6 [slug]` when the project is at phase 5 or later; otherwise nothing until the foundation exists.

## Rules

- Functional only. Technical hints go in the one short line; no layers, endpoints or packages.
- Keep it inside the whitepaper's scope boundaries. If it is not, say so and let the user decide.
- One feature per run.
