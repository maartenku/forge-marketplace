# Changelog

## 0.4.0, 2026-10-22
- Skill names end in their place in the new-project order: `new-project-1`, `feature-define-2`, `init-repo-3`, `architecture-4`, `foundation-5`, `feature-plan-6`, `feature-implement-7`. Support skills end in `-x`: `status-check-x`, `status-sync-x`, `deps-audit-x`, `apply-structure-x`. Invoke them as `/code-forge:new-project-1` and so on.

## 0.3.0, 2026-10-22
- Renamed from vibekit to code-forge and published in forge-marketplace. Skills are now invoked as `/code-forge:[name]`.
- Functional templates fill `modified` from `{{DATE}}` instead of a fixed date.
- Removed leftover references to a personal setup.
- Every skill says where `${CLAUDE_PLUGIN_ROOT}` points, so Codex and Copilot can find the reference files.

## 0.2.0, 2026-10-22
- Menu reworked for sharing. Source control: `local-git` (default, no remote, no CI) or `github`; Gitea removed. Hosting: `local-machine` (default: a local Windows or Linux PC or server, direct or Docker), `static-host`, `cloudflare`. Data: no default; `files-only` (new), `ef-sqlite`, `ef-sqlexpress`, `cloudflare-d1`. Backend: .NET 10, TypeScript on Workers, or none. Frontend gains an explicit "no frontend". PocketBase, backend-in-a-box, Python and PostgreSQL rows removed. `init-repo` and `put-in-place.sh` take `local` or `github`; the Gitea workflow template is gone.

## 0.1.0, 2026-10-22
- First release of the vault-agnostic kit.
- Functional docs live in `docs/functional/` (default) or any folder named in `CLAUDE.md`; technical docs in `docs/technical/`. The functional docs contract (files, frontmatter, linking, state) ships as `reference/functional-docs.md` with templates in `templates/functional/`.
- Eleven skills: `new-project`, `feature-define`, `init-repo`, `architecture`, `foundation`, `deps-audit`, `feature-plan`, `feature-implement`, `status-sync`, `status-check`, `apply-structure`.
- Stack profiles: four bases and ten extensions with a compatibility matrix. `foundations/README.md` is an empty table to fill with your own starters.
