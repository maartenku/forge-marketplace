#!/usr/bin/env bash
# validate.sh — plugin validation + internal consistency checks for the kit.
set -euo pipefail
KIT="$(cd "$(dirname "$0")/.." && pwd)"
fail=0
if command -v claude >/dev/null 2>&1; then
  claude plugin validate "$KIT" || fail=1
else
  echo "claude CLI not found — skipping 'claude plugin validate'"
fi
# every ${CLAUDE_PLUGIN_ROOT}/<path> reference in skills must exist
while IFS= read -r p; do
  [ -e "$KIT/$p" ] || { echo "MISSING reference in skills: $p"; fail=1; }
done < <(grep -rhoE 'CLAUDE_PLUGIN_ROOT\}/[A-Za-z0-9_./-]+' "$KIT/skills" | sed -E 's#^CLAUDE_PLUGIN_ROOT\}/##; s#/$##' | sort -u)
# every skill has frontmatter name == folder
for d in "$KIT"/skills/*/; do
  n="$(basename "$d")"
  grep -q "^name: $n$" "$d/SKILL.md" || { echo "skill $n: frontmatter name mismatch"; fail=1; }
done
# templates: no stray blanks outside the known set
grep -rhoE '\{\{[A-Z_]+\}\}' "$KIT/templates" | sort -u | grep -vE '^\{\{(PROJECT|PROJECT_SLUG|PROMISE|FUNCTIONAL_PATH|SLUGS|REPO_URL|GIT_HOST|DATE|FEATURE_ROWS|FEATURE_INDEX_ROWS|SLUG|FEATURE)\}\}$' && { echo "unknown blank(s) above"; fail=1; } || true
[ "$fail" -eq 0 ] && echo "code-forge: all checks passed"
exit $fail
