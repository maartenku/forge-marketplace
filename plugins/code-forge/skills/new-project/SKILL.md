---
name: new-project
description: Phase 1 of the code-forge workflow. Creates the functional docs for a new project (hub, whitepaper, roadmap, feature notes, design decisions, user journey) from the user's high-level expectations, either in docs/functional inside the repo or in any folder the user names (an Obsidian vault, for example). Use when the user wants to start, define or set up a new project, says "new project" or "start a project", or asks to turn an idea into project docs.
---

# new-project

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

You are running Phase 1 of the code-forge workflow. Create the functional docs for a new project. You write the notes yourself from the user's high-level expectations. The user reviews them; they do not draft.

## Before you start

1. You need one paragraph from the user: what it is, for whom, why now. If it is missing, ask for it in one question and wait.
2. Ask where the functional docs should live, unless the user already said: `docs/functional` in the repository (the default; create the repo folder if it does not exist yet), or an absolute path outside it (for example a project folder in an Obsidian vault, which the session needs through `--add-dir`). Call that path the functional root.

## Steps

1. Read `${CLAUDE_PLUGIN_ROOT}/reference/functional-docs.md` for the files, the frontmatter and the linking rules, and the templates in `${CLAUDE_PLUGIN_ROOT}/templates/functional/`.
2. Interview the user with the per-project questions in `${CLAUDE_PLUGIN_ROOT}/templates/functional/feature-interview.md` (promise, first user journey, needs code, constraints), plus whatever the feature expectations leave open. At most six questions, all in one message. Wait for the answers.
3. Write every note in one pass, from the templates, filling `{{PROJECT}}`, `{{PROMISE}}`, `{{DATE}}`:
   - `README.md`, the hub, with `status: planned`, `Loop phase: 1` and `Repo: (none yet)`.
   - `whitepaper.md`.
   - `roadmap.md`, with the phases applied to this project's first slice.
   - `features/README.md`, then one `features/[slug].md` per feature, following `${CLAUDE_PLUGIN_ROOT}/skills/feature-define/SKILL.md` for each (do not re-ask questions already answered).
   - `design/decisions.md`, decisions only.
   - `setup/user-journey.md`.
   Mark anything you guessed with a visible "Assumption:" note.
4. If the functional root is inside a repository, commit as `docs(functional): define [project]`. Ask before pushing.
5. Report back: the files you created, the feature slugs, the assumptions, and the gate question: does this project need code? If yes, the next step is `/code-forge:init-repo`. Later features are added with `/code-forge:feature-define`.

## Rules

- Do not invent features the user did not name. You may propose at most two, marked as assumptions.
- Keep feature notes functional. Technical hints go in the short "Technical hints" line and nowhere else.
- Do not create `log.md` or any other extra note until the project needs it.
- The full loop is in `${CLAUDE_PLUGIN_ROOT}/reference/workflow.md` and the rules in `${CLAUDE_PLUGIN_ROOT}/reference/rules.md`.
