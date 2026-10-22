# code-forge

A workflow kit for AI-assisted side projects, packaged as a Claude Code plugin. It carries the skills Claude Code runs per phase, a repo skeleton, templates for the functional and technical docs, and the reference material the skills point at. It does not depend on any particular note-taking tool: the functional docs live in `docs/functional/` inside the repo by default, or in any folder you name (an Obsidian vault project folder works, and the frontmatter is Obsidian-compatible).

Version 0.3.0. See `CHANGELOG.md`.

## The idea

Every project has two document sets. Functional docs say what the product is and why: hub, whitepaper, roadmap, one note per feature, design decisions, user journey. Technical docs say how it is built: architecture, designs, feature plans, setup. The skills read the first and write the second, and keep the two in step. A phase-gated loop runs over them:

0 Idea, 1 Define (`new-project`, `feature-define`), 2 Repo (`init-repo`), 3 Architecture (`architecture`), 4 Foundation and sandbox (`foundation`, `deps-audit`), 5 Design, 6 Feature loop (`feature-plan`, `feature-implement`, `status-sync`), 7 Verify, then back to 6 or to `feature-define` for a new feature. `status-check` at every session start. Details in `reference/workflow.md`; rules in `reference/rules.md`; the functional docs contract in `reference/functional-docs.md`.

## What is inside

| Path | What |
|---|---|
| `.claude-plugin/plugin.json` | makes this folder a Claude Code plugin named `code-forge` |
| `skills/[name]/SKILL.md` | eleven skills, invoked as `/code-forge:[name]`: `new-project`, `feature-define`, `init-repo`, `architecture`, `foundation`, `deps-audit`, `feature-plan`, `feature-implement`, `status-sync`, `status-check`, and `apply-structure` for existing projects |
| `templates/repo/` | the repo skeleton `init-repo` copies: `CLAUDE.md`, `docs/technical/`, `environments/sandbox/`, `scripts/`, CI |
| `templates/functional/` | the functional notes `new-project` and `feature-define` write |
| `templates/adoption-plan.md` | the plan `apply-structure` writes for an existing project |
| `reference/` | the loop, the rules, the functional docs contract, the building-block checklist, per-block decision guides, and `profiles/` with base profiles, extensions and a compatibility matrix |
| `foundations/README.md` | a table for code worth copying instead of generating; fill it with your own starters |
| `scripts/` | `put-in-place.sh` (the path without AI), `sync-check.sh`, `validate.sh` |

## Install

For one session:

```bash
claude --plugin-dir "/path/to/code-forge"
```

For every session, install it from forge-marketplace (see the marketplace README for the other tools):

```bash
claude plugin marketplace add [github-user]/forge-marketplace
claude plugin install code-forge@forge-marketplace
```

`scripts/validate.sh` runs `claude plugin validate` and checks that every file a skill references exists.

## New project

1. `/code-forge:new-project [Name]` in the repo (or anywhere, if the functional docs go to an external folder). It interviews you briefly and writes the functional docs.
2. `/code-forge:init-repo` in the repo. It copies `templates/repo/`, points `CLAUDE.md` at the functional docs, keeps the GitHub workflow only if the code goes to GitHub, vendors the skills into `.claude/skills/` if you want, and commits.
3. `/code-forge:architecture`, then `/code-forge:foundation`, then the feature loop.

Without AI: `scripts/put-in-place.sh [target-dir] --project "Name" [--functional docs/functional | /abs/path] [--host local|github] [--vendor-skills] [--scaffold-functional]`.

## Existing project

`/code-forge:apply-structure` in the repo. It inventories the repo, the docs and the code (with evidence per feature), interviews you on the intended stack, writes `docs/technical/architecture/adoption-plan.md`, executes the sections you approve with one commit each, and asks before pushing.

## Blanks used in the templates

`{{PROJECT}}` display name, `{{PROJECT_SLUG}}` kebab-case, `{{PROMISE}}` the one-line promise, `{{FUNCTIONAL_PATH}}` the functional root (`docs/functional` or an absolute path), `{{SLUGS}}` comma-separated feature slugs, `{{REPO_URL}}`, `{{GIT_HOST}}` local or github, `{{DATE}}` as YYYY-MM-DD, `{{FEATURE_ROWS}}` table rows for `docs/README.md`, `{{SLUG}}` and `{{FEATURE}}` in the feature template.

## Opinions baked in

The default stack is Angular 21 LTS with NgRx Signal Store and Spartan NG on the front, .NET 10 with Mediator and Clean Architecture on the back, OpenAPI with Scalar and an NSwag-generated client, running on a local Windows or Linux machine from a local git repository. Alternatives (Angular only, .NET only, TypeScript on Cloudflare Workers, static hosting, GitHub with Actions, files or SQLite or SQL Server Express or D1 for data, Identity or third-party auth) are documented as composable profiles. Change `reference/profiles/` to make it yours.
