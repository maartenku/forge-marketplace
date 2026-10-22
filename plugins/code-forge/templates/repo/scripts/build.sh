#!/usr/bin/env bash
# build.sh — see docs/technical/setup/scripts.md. Stub written by code-forge init-repo-3; implemented in Phase 4 (foundation).
set -euo pipefail
cd "$(dirname "$0")/.."
[ -f .env ] && set -a && . ./.env && set +a
echo "[build] not implemented yet — Phase 4 (foundation) fills this in." >&2
exit 1
