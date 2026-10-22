---
name: status-sync-x
description: code-forge workflow housekeeping. Reconciles the repo's docs/technical/features state folders with the functional feature notes' status, the functional roadmap (`roadmap.md`) and docs/README.md; reports drift and fixes it. Use when the user says "sync status", "update the docs", "are the docs in sync", at the end of any feature step, or after manual edits.
---

# status-sync-x

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

Reconcile the places a feature's state lives: the `docs/technical/features/` folders, the functional feature notes and index, the roadmap, and `docs/README.md`. Change state fields only.

## Read

- Repo: every `docs/technical/features/**/plan.md` (its folder, `status:`, `design:`), the `docs/README.md` header and feature table.
- Functional root (from `CLAUDE.md`): every `features/*.md` (its `status`), `features/README.md`, `roadmap.md`, and the hub (`Loop phase`, `Repo`).

## Steps

1. Build a table with one row per feature: slug, technical folder, technical `status`, functional `status`, index row, roadmap mention, design present.
2. Mark the mismatches. Truth rules: the technical folder is the truth for implementation state (`backlog` is `planned`, `in-progress` is `active`, `done` is `done`). The functional note is the truth for `idea` and `dropped`; when it says so, leave the technical folder alone or ask before removing it. The `docs/README.md` phase follows the highest gate that has been passed.
3. Show the table and the fixes you propose. Apply them after the user confirms, or immediately when invoked with `--fix`: move folders, set `status:` and `updated:`, set the functional `status` and `modified`, fix `features/README.md`, add missing roadmap lines in the form "[date]: [feature] [state]", refresh the `docs/README.md` header and rows, add a `log.md` entry if the project keeps one.
4. Commit the doc changes (`docs: status sync [date]`) and ask before pushing. Report what changed. If nothing did, say "in sync".

## Rules

- Touch state fields only, never a feature's scope, criteria or plan text.
- Never move a functional note.
- When `/code-forge:status-check-x` calls you, run as a dry run and report only.
