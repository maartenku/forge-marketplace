## Source control and CI/CD: GitHub
Compatible bases: all. Pick it when the code should live off your machine, when you want CI, or for the Cloudflare pairing (Workers Builds and the Pages integration deploy on push and give per-branch previews).

`.github/workflows/ci.yml` runs on push and pull request and calls `scripts/test.sh` (frozen installs, build, tests, audits). `release.yml` runs on a tag: builds images and pushes them to GHCR for `local-machine`, publishes `dist/` for `static-host`, or runs `wrangler deploy` for `cloudflare`. Private repos get limited free Actions minutes; public repos are unlimited.

Dependency automation: Dependabot (`.github/dependabot.yml`) with a cooldown or minimum age of 7 days, grouped minor updates, weekly. Turn on secret scanning and branch protection on `main`.

Git flow: `main` always green; one `feat/[slug]` branch per feature; Conventional Commits with the slug as scope. Commits are made freely. Nothing is pushed without asking the user first.
