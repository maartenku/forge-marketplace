---
name: architecture-4
description: Phase 3 of the code-forge workflow. Walks the seven building blocks (application type, frontend, backend, data, authorization, hosting, source control/CI), composes stack.md from a base profile plus extensions, derives dependencies from the feature notes, lists reusable foundations, and writes docs/technical/architecture/* plus ADRs. Use when the user says "architecture", "choose the stack", "foundation plan", or the repo is at loop phase 3.
---

# architecture-4

Paths that start with `${CLAUDE_PLUGIN_ROOT}` point to the code-forge plugin folder. If your tool does not fill in that variable, use the folder two levels above this SKILL.md.

You are running Phase 3 of the code-forge workflow. Decide the architecture for this project by walking the building blocks, and write it down in `docs/technical/architecture/`. Write no code and install nothing.

## Before you start: the Phase 2 gate

`CLAUDE.md` must exist in the repo and the functional docs must be readable (whitepaper, `features/`, `design/`, `setup/`; the root is the `Functional docs:` line in `CLAUDE.md`). If either is missing, say what is missing and stop.

## Read first

- Functional docs: the whitepaper, every feature note, `design/decisions.md`, `setup/user-journey.md`.
- Kit: `${CLAUDE_PLUGIN_ROOT}/reference/building-blocks.md`, the decision guides in `${CLAUDE_PLUGIN_ROOT}/reference/options/`, the profiles in `${CLAUDE_PLUGIN_ROOT}/reference/profiles/` (start with its `README.md`: base profiles, extensions, compatibility matrix), `${CLAUDE_PLUGIN_ROOT}/foundations/README.md`, and the dependency rules in `${CLAUDE_PLUGIN_ROOT}/reference/rules.md`.

## Steps

1. Walk the seven blocks in order. Take the default where there is one unless a feature or a stated constraint argues against it. Data has no default: always ask (files only, EF Core with SQLite, EF Core with SQL Server Express, or Cloudflare D1, following the features). Collect the blocks where the default is doubtful and ask about them together in one round, at most four questions. Every non-default choice gets its own ADR.
2. Fill `docs/technical/architecture/overview.md`: the block table (choice, one-line why, ADR reference), the base profile and the four extensions you picked, the "Reusable pieces" table (from `foundations/README.md` and any earlier repos the user names), and the constraints that shaped the choices.
3. Compose `docs/technical/architecture/stack.md`: paste the chosen `reference/profiles/base/*.md` in full, then append one `reference/profiles/extensions/[category]/*.md` for each of hosting, auth, database and source-control, checked against the compatibility matrix in `reference/profiles/README.md`. Trim to what this project uses. Keep every section heading and write "none" rather than deleting a section. A pairing outside the matrix needs an ADR that names the risk.
4. Write `docs/technical/architecture/dependencies.md`: for each feature, what it needs and whether a built-in covers it or a package is required. Apply the rules: fewest sane dependencies, no version younger than 7 days (state the pinned version's publish date), a reason per package.
5. Write one `docs/technical/architecture/decisions/ADR-000N-[slug].md` per deviation, from `ADR-0000-template.md`.
6. Write `docs/technical/architecture/foundation-plan.md`: ordered steps, each marked copy-from or generate, the sandbox contents, the gate.
7. Update the `docs/README.md` header to phase 3 with next gate "foundation plan approved", and set the functional hub to `Loop phase: 3 (awaiting approval)`.
8. Stop. Show the user `overview.md` and `foundation-plan.md` and ask for approval. When they approve, write their name and the date into the plan's "Approved by" line and tell them the next step is `/code-forge:foundation-5`.

## Rules

- No code, no package installs, no scaffolding commands.
- If you need an option that is not in `reference/options/`, say so, propose adding it to the kit, and still write the ADR.
- Treat the blocks as independent. An Angular-only frontend does not imply Cloudflare hosting.
