#!/usr/bin/env bash
# Repo checks: skill frontmatter, README coverage of every skill, and no private data in tracked files.
set -uo pipefail
cd "$(dirname "$0")/.."
fail=0
err() { echo "FAIL: $*"; fail=1; }

for d in .claude/skills/*/; do
  n=$(basename "$d"); f="$d/SKILL.md"
  [[ $n =~ ^[a-z0-9-]+$ ]] || { err "$n: invalid skill directory name"; continue; }
  [ -f "$f" ] || { err "$n: missing SKILL.md"; continue; }
  head -1 "$f" | grep -q '^---$' || err "$n: no frontmatter"
  grep -qxF "name: $n" "$f" || err "$n: frontmatter name must equal directory name"
  grep -q '^description: .\{40,\}' "$f" || err "$n: description missing or too short"
  grep -qF "\`$n\`" README.md || err "$n: not documented in README.md"
  grep -qF "\`$n\`" README.es.md || err "$n: not documented in README.es.md"
done

for f in .claude/hooks/*.sh scripts/*.sh; do bash -n "$f" || err "$f: syntax error"; done

tracked=$(git ls-files 2>/dev/null)
if [ -n "$tracked" ]; then
  echo "$tracked" | grep -E '^(private|data|inputs|outputs|archivos de guia)(/|$)' && err "private paths are tracked"
  # The banned-terms list is private (git-ignored), so this check only runs locally; CI cannot see it.
  if [ -f data/banned-terms.txt ]; then
    while IFS= read -r t || [ -n "$t" ]; do
      case "$t" in ''|\#*) continue;; esac
      git grep -n -i -F -- "$t" -- . >/dev/null 2>&1 && err "banned term '$t' appears in tracked files"
    done < data/banned-terms.txt
  fi
fi

[ $fail -eq 0 ] && echo "OK: all checks passed"
exit $fail
