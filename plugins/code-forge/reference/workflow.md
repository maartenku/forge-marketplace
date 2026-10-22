# The loop

Phases 0 to 5 run once per project; 6 and 7 repeat per feature. A new feature enters with `feature-define-2` (its functional note) and jumps to 6.

## Skill order

The number at the end of a skill name is its place in this order. Skills ending in `-x` are support skills that run whenever they are needed. The skill numbers are not the phase numbers in the table below.

1. `new-project-1`
2. `feature-define-2` (per feature; also the entry point for later features)
3. `init-repo-3`
4. `architecture-4`
5. `foundation-5`
6. Design (Phase 5, no skill), then `feature-plan-6`
7. `feature-implement-7`, then loop from 2 or 6

Support skills:
- `status-check-x` at every session start.
- `status-sync-x` at every session end, and after manual edits to the docs.
- `deps-audit-x` after `foundation-5`, after any feature that adds packages, and weekly on active projects.

Existing project: `apply-structure-x` instead of 1 to 3. It runs inventory, interview, adoption plan and approved execution, lands the project at the phase the evidence supports, and the loop continues from there.

## Phases and gates

| Phase | Produces | Gate (must hold before the next phase) |
|---|---|---|
| 0 Idea | one paragraph: what, for whom, why now | the paragraph exists |
| 1 Define | `new-project-1`: the functional docs per `reference/functional-docs.md`, in `docs/functional` or an external folder: hub (`status`, repo location, loop phase), whitepaper, roadmap, `design/decisions.md`, `setup/user-journey.md`; then `feature-define-2` per feature: one functional note written by the AI from the user's high-level expectations | hub, whitepaper, roadmap, at least one feature, a user journey; "needs code?" answered |
| 2 Repo | repo from `templates/repo/`, `CLAUDE.md` filled and pointing at the functional root, `docs/README.md` at phase 3, skills vendored if wanted, first commit; the hub gets the repo URL | a session can read `CLAUDE.md` and the functional `features/` folder |
| 3 Architecture | `docs/technical/architecture/overview.md` (7 blocks, reusable pieces), `stack.md` (base profile plus extensions, trimmed), `dependencies.md` (per feature), `foundation-plan.md`, `decisions/ADR-*` per deviation | the user has read overview and foundation plan and said go; no code yet |
| 4 Foundation and sandbox | foundation implemented copy-first; `environments/sandbox/` (database and seeds, filesystem tree, stubs, dev users); `scripts/*.sh`; CI running `test.sh` when the repo is on GitHub; `docs/technical/setup/*.md`; first `deps-audit-x` | fresh clone, `sandbox-up`, `dev` runs the empty app; `test.sh` green locally (and in CI when there is one) |
| 5 Design | `docs/technical/designs/[screen]/` with a README naming the features covered; product decisions back to `design/decisions.md` | every feature in the first slice has a design or an explicit "no UI" |
| 6 Feature loop | 6.1 `docs/technical/features/backlog/[slug]/plan.md`. 6.2 move to `in-progress/`, branch `feat/[slug]`, functional note `active`. 6.3 build and test. 6.4 green, merge, move to `done/`, "As built", functional note `done`, Roadmap line, `docs/README.md` | plan reviewed before 6.3; acceptance criteria met before 6.4 |
| 7 Verify | the user walks the user journey on the sandbox; findings become bug folders, notes, or new functional feature notes; deploy decision | the journey works end to end on the sandbox |

## Sync rule

Every state change touches four places in one unit of work: the repo folder (`backlog`, `in-progress`, `done`), the functional feature note `status` (`planned`, `active`, `done`), the functional roadmap (`roadmap.md`), and the `docs/README.md` phase. Repo docs move. Functional notes never move; they carry `status`.

## Session hygiene

Start with `status-check-x` (it reads `docs/README.md` and states "Phase N, next gate: ..."). One feature per session where possible. End with `status-sync-x`.
