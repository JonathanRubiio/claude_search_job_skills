#!/usr/bin/env bash
# Creates the private (git-ignored) workspace and links it where the skills expect it.
# Safe to re-run: never overwrites existing files.
set -euo pipefail
cd "$(dirname "$0")/.."

for d in data inputs outputs "archivos de guia"; do
  mkdir -p "private/$d"
  [ -e "$d" ] || ln -s "private/$d" "$d"
done

copy() { [ -e "private/data/$2" ] || cp "templates/$1" "private/data/$2"; }
copy profile.example.md       profile.md
copy preferences.example.md   preferences.md
copy form-data.example.md     form-data.md
copy tracker.example.md       tracker.md
copy stories.example.md       stories.md
copy banned-terms.example.txt banned-terms.txt
copy applications-log.example.md applications-log.md
copy search-log.example.md search-log.md

echo "Done. Your personal files live in ./private (git-ignored)."
echo "Open Claude Code here (claude) and type: empecemos. With or without a CV, it will guide you."
