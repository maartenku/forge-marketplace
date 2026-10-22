---
name: status-check-x
description: code-forge workflow process keeper. States the project's current loop phase, the next gate, what is missing for it, whether docs are in sync, and which skill to run next. Use at session start, or when the user asks "where are we", "what's next", "what's the status of this project", or seems about to skip a phase.
---

# status-check-x

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

Tell the user where this project stands in the loop and what comes next. Read only; change nothing. Answer in five lines.

## Steps

1. Read the `docs/README.md` header. If there is none, read the `Loop phase:` line in the functional hub (`README.md` in the functional root). If neither exists, the project is at phase 0 or 1: say so and suggest `/code-forge:new-project-1` (or `/code-forge:apply-structure-x` for an existing codebase).
2. Check the gate for the current phase against `${CLAUDE_PLUGIN_ROOT}/reference/workflow.md`:
   - Phase 2: `CLAUDE.md` exists and the functional `features/` folder is readable.
   - Phase 3: `overview.md` and `foundation-plan.md` are filled and the plan is approved.
   - Phase 4: `scripts/test.sh` runs green and `environments/sandbox/` is populated.
   - Phase 5: every first-slice feature has a design or an explicit "no UI".
   - Phase 6: the next feature has a reviewed plan, or the current feature's criteria are met.
   - Phase 7: the user journey has been walked on the sandbox.
3. Run `/code-forge:status-sync-x` as a dry run and count the mismatches.
4. Print exactly:
   ```
   Phase: N, [name]
   Next gate: [one line]
   Missing: [list, or "nothing"]
   Docs sync: [in sync | N mismatches, run /code-forge:status-sync-x]
   Next: /code-forge:[skill] [args]
   ```
5. If the user's request would skip the gate (for example "implement X" while X has no plan), say so once and offer the gate step instead. Do no other work.
