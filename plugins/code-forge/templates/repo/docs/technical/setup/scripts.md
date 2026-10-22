# Scripts: {{PROJECT}}

| Script | Does |
|---|---|
| `sandbox-up.sh` | start sandbox services |
| `sandbox-reset.sh` | drop, migrate, reseed; restore `fs/` |
| `dev.sh` | run everything against the sandbox |
| `test.sh` | frozen install, build, tests, audits; run by hand before every merge, and by CI when there is one |
| `build.sh` | production build / images |
| `generate-api.sh` | OpenAPI document to NSwag Angular client (CI fails on a diff) |

All: `set -euo pipefail`, run from repo root, load `.env` if present.
