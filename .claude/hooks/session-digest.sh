#!/usr/bin/env bash
# SessionStart: print a short project digest (goes into Claude's context).
# Feeds Claude with tracker state, due follow-ups and missing setup files.
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
python3 - <<'PY'
import re, datetime, os
today = datetime.date.today().isoformat()
print(f"[job-hunt digest {today}]")
for f in ("data/profile.md", "data/preferences.md", "data/form-data.md", "data/banned-terms.txt", "data/applications-log.md", "data/search-log.md"):
    if not os.path.exists(f):
        print(f"- MISSING {f}: run scripts/init.sh, then profile-intake (cold start) if the profile is empty.")
if not os.path.exists("data/tracker.md"):
    raise SystemExit
counts, due = {}, []
for line in open("data/tracker.md", encoding="utf-8"):
    if not re.match(r"\| J-\d+", line):
        continue
    c = [x.strip() for x in line.strip().strip("|").split("|")]
    if len(c) < 9:
        continue
    st = c[6].split(" ")[0].split("(")[0].strip()
    counts[st] = counts.get(st, 0) + 1
    if st in ("applied", "screen", "interview", "prepared", "shortlisted") and re.match(r"\d{4}-\d{2}-\d{2}$", c[8]) and c[8] <= today:
        due.append(f"{c[0]} {c[2]} / {c[3][:40]} -> {c[7][:50]} (due {c[8]})")
print("- Tracker: " + ", ".join(f"{k}={v}" for k, v in sorted(counts.items())))
for d in due[:12]:
    print("- DUE: " + d)
print("- Rules: no apply without explicit chat authorization; see CLAUDE.md and .claude/skills/job-apply.")
PY
