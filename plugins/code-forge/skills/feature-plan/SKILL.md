---
name: feature-plan
description: Phase 6.1 of the code-forge workflow. Turns a functional feature note plus its design into a technical implementation plan at docs/technical/features/backlog/[slug]/plan.md. Use when the user says "plan feature X", "plan the next feature", or asks for an implementation plan for a feature.
---

# feature-plan

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

You are running Phase 6.1 of the code-forge workflow for one feature, identified by its slug. Write its technical implementation plan. Do not implement anything.

## Before you start: the gate

Check all three. If any fails, say which and stop.

1. The functional note `features/[slug].md` exists and has `status: planned`. If missing, point the user to `/code-forge:feature-define` first.
2. A design exists under `docs/technical/designs/` whose README lists this slug, or the user has said "no UI". If neither, ask for a design session (Phase 5).
3. The foundation is done: `docs/README.md` shows phase 5 or later.

## Steps

1. Read the functional note, the design's README, `docs/technical/architecture/stack.md`, `docs/technical/architecture/dependencies.md` and `${CLAUDE_PLUGIN_ROOT}/reference/rules.md`.
2. Create `docs/technical/features/backlog/[slug]/plan.md` by copying `docs/technical/features/_plan-template.md`. Fill every section. Copy the acceptance criteria from the functional note word for word. Every test you list maps to an acceptance criterion.
3. If the feature needs a new package, add its row to `dependencies.md` now, with the reason and a publish date at least 7 days old. Prefer a built-in when one exists.
4. Add or update the feature's row in `docs/README.md` (functional note, repo folder, design path).
5. Show the plan to the user and stop. Ask them to review it. The next step is `/code-forge:feature-implement [slug]`.

## Rules

- The scope is the functional note. Put every new idea under "Follow-ups", never into scope.
- Plan one feature per run, the next one, not the backlog.
- Use repo-root-relative paths in the plan (for example `docs/technical/designs/...`) so the folder can move later without breaking links.
