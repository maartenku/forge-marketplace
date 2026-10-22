# Functional docs

Every project has two document sets. The functional docs say what the product is and why (hub, whitepaper, roadmap, feature notes, design decisions, user journey). The technical docs say how it is built (`docs/technical/`: architecture, designs, feature plans, setup). The skills read the first and write the second.

## Where they live

The functional root is one setting, written in `CLAUDE.md` under Project as `Functional docs: [path]`.

- `docs/functional` (the default): inside the repository, next to `docs/technical`. Everything is one git history and renders on GitHub.
- An absolute path: any folder outside the repo, for example a project folder inside an Obsidian vault. Start sessions with `claude --add-dir "[path]"` so the skills can read and write it.

Both work the same way; only the path differs. Nothing in the kit assumes a vault exists.

## Files

```
[functional root]/
  README.md             hub: what it is, status, loop phase, repo location, map of the notes
  whitepaper.md         why it exists, audience, scope boundaries, what success looks like
  roadmap.md            phases and where the build stands; one line per state change
  features/
    README.md           feature index: slug, title, status
    [slug].md           one functional note per feature
  design/
    decisions.md        high-level design decisions only, never design output
  setup/
    user-journey.md     from install to first value; what Phase 7 verifies
  log.md                optional running log of decisions
```

Filenames are kebab-case. The feature file is named after its slug, and the slug is the same string used for the technical plan folder, the branch and the commit scope.

## Frontmatter

Each note starts with a small YAML block. Obsidian, Dataview and most static-site tools read it; nothing in the kit depends on any other field.

```yaml
---
type: hub            # hub | whitepaper | roadmap | feature | features-index | design | journey | log
status: planned      # only on hub, roadmap and feature: idea | planned | active | done | dropped
slug: trip-planning  # feature notes only; must match the filename
created: 2026-01-01
modified: 2026-01-01
---
```

Rules: `status` exists only where there is a lifecycle (hub, roadmap, feature). `modified` is bumped on every substantive edit. Do not add other fields unless the project needs them; if you do, use them consistently across notes.

## Linking

Inside the functional root use relative markdown links (`[Trip planning](features/trip-planning.md)`). They work on GitHub and in Obsidian. If the functional root is in an Obsidian vault and you prefer wikilinks, use them consistently within that root, but keep links from the technical docs to the functional docs as paths (`design:` and `functional_note:` fields in `plan.md`), because the repo side cannot resolve wikilinks.

## State

Functional notes never move. Their state is the `status` field. Technical feature plans do move, between `docs/technical/features/backlog/`, `in-progress/` and `done/`. The two are kept in step by `status-sync`: `backlog` means `planned`, `in-progress` means `active`, `done` means `done`. `idea` and `dropped` exist only on the functional side.

## Writing the notes

The AI writes the feature notes from the user's high-level expectations, asking only what is unclear (the interview in `templates/functional/feature-interview.md`). Feature notes are functional: behaviour, boundaries, acceptance criteria. Technical detail belongs in the plan. Templates for every note are in `templates/functional/`.
