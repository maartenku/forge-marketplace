#!/usr/bin/env bash
# sync-check.sh — compare a repo's vendored skills and its CLAUDE.md Rules block against this kit.
#   scripts/sync-check.sh <repo-dir> [--fix]
set -euo pipefail
KIT="$(cd "$(dirname "$0")/.." && pwd)"
REPO="${1:-}"; FIX="${2:-}"
[ -z "$REPO" ] && { echo "usage: $0 <repo-dir> [--fix]" >&2; exit 2; }
drift=0

# 1. vendored skills
if [ -d "$REPO/.claude/skills" ] && ls "$REPO/.claude/skills"/*/SKILL.md >/dev/null 2>&1; then
  for d in "$KIT"/skills/*/; do
    n="$(basename "$d")"
    if [ ! -f "$REPO/.claude/skills/$n/SKILL.md" ]; then echo "MISSING skill: $n"; drift=1
    elif ! diff -q "$d/SKILL.md" "$REPO/.claude/skills/$n/SKILL.md" >/dev/null; then echo "DRIFT skill: $n"; drift=1; fi
  done
  if [ "$FIX" = "--fix" ]; then cp -R "$KIT/skills/." "$REPO/.claude/skills/"; echo "skills re-vendored."; fi
else
  echo "no vendored skills in $REPO (plugin-only setup) — skipping skill check"
fi

# 2. CLAUDE.md Rules block
extract() { awk '/^## Rules/{f=1} /^## Commands/{f=0} f' "$1"; }
if [ -f "$REPO/CLAUDE.md" ]; then
  if ! diff -q <(extract "$KIT/templates/repo/CLAUDE.md") <(extract "$REPO/CLAUDE.md") >/dev/null; then
    echo "DRIFT: CLAUDE.md '## Rules' block differs from the kit template"; drift=1
    diff <(extract "$KIT/templates/repo/CLAUDE.md") <(extract "$REPO/CLAUDE.md") || true
    if [ "$FIX" = "--fix" ]; then
      python3 - "$KIT/templates/repo/CLAUDE.md" "$REPO/CLAUDE.md" <<'PY'
import sys,re
tpl,repo=sys.argv[1:3]
def block(s): return re.search(r"(^## Rules.*?)(?=^## Commands)",s,re.S|re.M).group(1)
t=open(tpl,encoding="utf-8").read(); r=open(repo,encoding="utf-8").read()
r=r.replace(block(r),block(t)); open(repo,"w",encoding="utf-8").write(r); print("Rules block replaced.")
PY
    fi
  fi
else
  echo "no CLAUDE.md in $REPO"; drift=1
fi

[ "$drift" -eq 0 ] && echo "in sync with kit $(python3 -c "import json;print(json.load(open('$KIT/.claude-plugin/plugin.json'))['version'])")"
exit $drift
