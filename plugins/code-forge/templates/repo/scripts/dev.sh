#!/usr/bin/env bash
# dev.sh — see docs/technical/setup/scripts.md. Stub written by code-forge init-repo; implemented in Phase 4 (foundation).
set -euo pipefail
cd "$(dirname "$0")/.."
[ -f .env ] && set -a && . ./.env && set +a
echo "[dev] not implemented yet — Phase 4 (foundation) fills this in." >&2
exit 1
