#!/usr/bin/env bash
# PostToolUse (Write|Edit): after data/tracker.md changes, validate rows (columns, status, dates, duplicate IDs).
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
python3 -c '
import sys, json, os, re
try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
p = d.get("tool_input", {}).get("file_path", "")
if not p.endswith("data/tracker.md"):
    sys.exit(0)
ok = {"found","shortlisted","prepared","applied","screen","interview","offer","rejected","ghosted","discarded","skipped"}
errs, seen = [], set()
for n, line in enumerate(open("data/tracker.md", encoding="utf-8"), 1):
    if not re.match(r"\| J-\d+", line):
        continue
    c = [x.strip() for x in line.strip().strip("|").split("|")]
    if len(c) != 10:
        errs.append(f"line {n}: {len(c)} columns, expected 10"); continue
    if c[0] in seen: errs.append(f"line {n}: duplicate id {c[0]}")
    seen.add(c[0])
    if c[6].split(" ")[0].split("(")[0] not in ok: errs.append(f"line {n} {c[0]}: unknown status {c[6][:30]!r}")
    if not re.match(r"\d{4}-\d{2}-\d{2}$", c[1]): errs.append(f"line {n} {c[0]}: date found must be YYYY-MM-DD")
    if c[6].startswith(("applied","prepared","screen","interview")) and not re.match(r"\d{4}-\d{2}-\d{2}$", c[8]):
        errs.append(f"line {n} {c[0]}: active status needs Due date")
if errs:
    sys.stderr.write("tracker.md lint:\n- " + "\n- ".join(errs) + "\n"); sys.exit(2)
'
