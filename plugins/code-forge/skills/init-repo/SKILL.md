---
name: init-repo
description: Phase 2 of the code-forge workflow. Lays down the repo skeleton (CLAUDE.md, docs/technical, environments/sandbox, scripts, CI) from the kit template in the current repository, points it at the functional docs (docs/functional or an external folder), optionally vendors the skills, and commits. Use when the user says "init the repo", "set up the repository", or has just created an empty repo for a project.
---

# init-repo

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

You are running Phase 2 of the code-forge workflow. Turn the current repository (empty or freshly cloned) into the standard skeleton. Produce structure and documentation only. No stack scaffolding and no dependencies; that is Phase 4.

## Before you start: the Phase 1 gate

1. Find the functional docs: `docs/functional` in this repo, or an absolute path the user gives (readable through `--add-dir`). They must contain a hub, a whitepaper, a roadmap and at least one note in `features/`. If they do not, stop and tell the user to run `/code-forge:new-project` first.
2. Ask once where the code lives: local git with no remote (the default) or GitHub.

## Steps

1. Collect the blanks:
   - `{{PROJECT}}` from the hub title; `{{PROJECT_SLUG}}` as kebab-case of it.
   - `{{PROMISE}}` from the hub's first paragraph.
   - `{{FUNCTIONAL_PATH}}`: `docs/functional`, or the absolute external path.
   - `{{SLUGS}}`: the `slug:` values from `features/*.md`, comma-separated.
   - `{{REPO_URL}}`: `git remote get-url origin`, or `(not pushed yet)`.
   - `{{GIT_HOST}}` as `local` or `github`, and `{{DATE}}` as today in `YYYY-MM-DD`.
   - `{{FEATURE_ROWS}}`: one markdown table row per feature: `| [slug] | [functional note path] | backlog/[slug]/ (not planned yet) | — |`.
2. Copy everything under `${CLAUDE_PLUGIN_ROOT}/templates/repo/` into the repo root. Do not overwrite files that already exist. If a `CLAUDE.md` exists, merge the template's Loop, Docs and Rules sections into it and keep the user's own content.
3. Replace every `{{BLANK}}` in the copied files with the values from step 1.
4. With local git, delete `.github/` (there is no CI; `scripts/test.sh` runs by hand). With GitHub, keep `.github/workflows/ci.yml`.
5. Ask whether to vendor the skills. If yes, copy `${CLAUDE_PLUGIN_ROOT}/skills/*` into `.claude/skills/`. If no, leave `.claude/skills/.keep`.
6. Make `scripts/*.sh` executable. Do not run `ng new`, `dotnet new` or any package install.
7. Run `git init` if the folder is not a repository yet. Commit as `chore: code-forge init-repo (phase 2)`. If a remote exists, ask whether to push, and push only on a yes.
8. In the hub (`README.md` in the functional root), set `Repo: [url or path]` and `Loop phase: 3`, and bump `modified`.
9. Tell the user the next step is `/code-forge:architecture`. If the functional root is external, also give the session command: `claude --add-dir "[FUNCTIONAL_PATH]"`.

## Rules

- The gate you leave behind: a new session can read `CLAUDE.md` and the functional `features/` folder.
- Never commit `.env`, only `.env.example`.
- `${CLAUDE_PLUGIN_ROOT}/scripts/put-in-place.sh` does steps 2 to 5 without AI. Mention it if the user prefers a script.
