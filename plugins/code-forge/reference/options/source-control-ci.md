# Source control

Default: a local git repository with no remote (`profiles/extensions/source-control/local-git.md`). `git init` on day one, `main` always green, one `feat/[slug]` branch per feature (or per implementation plan), Conventional Commits with the slug as scope. There is no CI; `scripts/test.sh` runs by hand before every merge into `main`. Back the folder up like any other.

| Alternative | Pick when | Watch out |
|---|---|---|
| GitHub with GitHub Actions (`github.md`) | the code should live off your machine, you want CI (`ci.yml` running `scripts/test.sh`, `release.yml` on tags), Dependabot, or the Cloudflare pairing with per-branch previews | private repos have limited free Actions minutes; nothing is pushed without the user saying so |

Dependency automation only exists with GitHub: Dependabot with a 7-day minimum age, grouped minor updates, weekly. Without it, `deps-audit-x` on a schedule does the same job by hand.
