#!/usr/bin/env bash
# put-in-place.sh: copy the code-forge repo template into a target directory and fill the blanks (no AI needed).
#
#   scripts/put-in-place.sh <target-dir> --project "Name" \
#       [--functional docs/functional | /abs/path] [--slug name] [--promise "one line"] [--slugs "a,b,c"] \
#       [--repo-url URL] [--host local|github] [--vendor-skills] [--scaffold-functional] [--force]
#
# --functional defaults to docs/functional (inside the target). --scaffold-functional also writes the functional
# notes from templates/functional/ there (hub, whitepaper, roadmap, features index, decisions, user journey) when
# the folder is empty. Existing files are never overwritten unless --force.
set -euo pipefail

KIT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-}"; shift || true
[ -z "$TARGET" ] && { echo "usage: $0 <target-dir> --project NAME [options]" >&2; exit 2; }

PROJECT=""; FUNCTIONAL="docs/functional"; SLUG=""; PROMISE="(fill in: the one-line promise)"; SLUGS="(none yet)"
REPO_URL="(no remote)"; HOST="local"; VENDOR=0; SCAFFOLD=0; FORCE=0
while [ $# -gt 0 ]; do
  case "$1" in
    --project) PROJECT="$2"; shift 2;;
    --functional) FUNCTIONAL="$2"; shift 2;;
    --slug) SLUG="$2"; shift 2;;
    --promise) PROMISE="$2"; shift 2;;
    --slugs) SLUGS="$2"; shift 2;;
    --repo-url) REPO_URL="$2"; shift 2;;
    --host) HOST="$2"; shift 2;;
    --vendor-skills) VENDOR=1; shift;;
    --scaffold-functional) SCAFFOLD=1; shift;;
    --force) FORCE=1; shift;;
    *) echo "unknown option: $1" >&2; exit 2;;
  esac
done
[ -z "$PROJECT" ] && { echo "--project is required" >&2; exit 2; }
[ -z "$SLUG" ] && SLUG="$(echo "$PROJECT" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')"
DATE="$(date +%F)"

ROWS=""; IDX=""
if [ "$SLUGS" != "(none yet)" ]; then
  IFS=',' read -ra ARR <<< "$SLUGS"
  for s in "${ARR[@]}"; do s="$(echo "$s" | xargs)"; ROWS+="| $s | $FUNCTIONAL/features/$s.md | backlog/$s/ (not planned yet) | — |"$'\n'; IDX+="| $s | $s | planned |"$'\n'; done
else
  ROWS="| (none yet; define features first) | | | |"$'\n'; IDX="| | | |"$'\n'
fi

fill() { # fill <src> <dst>
  python3 - "$1" "$2" "$PROJECT" "$SLUG" "$PROMISE" "$FUNCTIONAL" "$SLUGS" "$REPO_URL" "$HOST" "$DATE" "$ROWS" "$IDX" <<'PY'
import sys
src,dst,project,slug,promise,functional,slugs,repo,host,date,rows,idx=sys.argv[1:13]
s=open(src,encoding="utf-8").read()
for k,v in {"{{PROJECT}}":project,"{{PROJECT_SLUG}}":slug,"{{PROMISE}}":promise,"{{FUNCTIONAL_PATH}}":functional,
            "{{SLUGS}}":slugs,"{{REPO_URL}}":repo,"{{GIT_HOST}}":host,"{{DATE}}":date,
            "{{FEATURE_ROWS}}":rows.rstrip("\n"),"{{FEATURE_INDEX_ROWS}}":idx.rstrip("\n")}.items():
    s=s.replace(k,v)
open(dst,"w",encoding="utf-8").write(s)
PY
}

mkdir -p "$TARGET"
written=0; skipped=0
while IFS= read -r -d '' src; do
  rel="${src#"$KIT/templates/repo/"}"
  case "$HOST" in
    local) [[ "$rel" == .github/* ]] && continue;;
  esac
  dst="$TARGET/$rel"
  if [ -e "$dst" ] && [ "$FORCE" -ne 1 ]; then skipped=$((skipped+1)); continue; fi
  mkdir -p "$(dirname "$dst")"
  case "$rel" in
    *.md|*.yml|*.sh|.*) fill "$src" "$dst";;
    *) cp "$src" "$dst";;
  esac
  [ -x "$src" ] && chmod +x "$dst"
  written=$((written+1))
done < <(find "$KIT/templates/repo" -type f -print0)

if [ "$SCAFFOLD" -eq 1 ]; then
  case "$FUNCTIONAL" in /*) FROOT="$FUNCTIONAL";; *) FROOT="$TARGET/$FUNCTIONAL";; esac
  mkdir -p "$FROOT/features" "$FROOT/design" "$FROOT/setup"
  for pair in "README.md:README.md" "whitepaper.md:whitepaper.md" "roadmap.md:roadmap.md" "features-index.md:features/README.md" "decisions.md:design/decisions.md" "user-journey.md:setup/user-journey.md"; do
    src="$KIT/templates/functional/${pair%%:*}"; dst="$FROOT/${pair##*:}"
    if [ -e "$dst" ] && [ "$FORCE" -ne 1 ]; then skipped=$((skipped+1)); continue; fi
    fill "$src" "$dst"; written=$((written+1))
  done
  echo "functional docs scaffolded in $FROOT (feature notes are written by /code-forge:feature-define)"
fi

if [ "$VENDOR" -eq 1 ]; then
  mkdir -p "$TARGET/.claude/skills"
  cp -R "$KIT/skills/." "$TARGET/.claude/skills/"
  echo "vendored skills into $TARGET/.claude/skills/"
fi

echo "put-in-place: $written files written, $skipped existing files kept (use --force to overwrite)."
case "$FUNCTIONAL" in /*) echo "functional docs are external: start sessions with claude --add-dir \"$FUNCTIONAL\"";; esac
