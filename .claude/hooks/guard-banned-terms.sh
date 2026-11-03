#!/usr/bin/env bash
# PreToolUse (Write|Edit): block deliverables that contain terms listed in data/banned-terms.txt.
# Applies only to outputs/ and "archivos de guia/". Add `<!-- banned-terms:ignore -->` to a file to exempt it.
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0
python3 -c '
import sys, json, os, re
try:
    d = json.load(sys.stdin)
except Exception:
    sys.exit(0)
ti = d.get("tool_input", {})
path = ti.get("file_path", "")
rel = os.path.relpath(path) if path else ""
if not (rel.startswith("outputs/") or rel.startswith("archivos de guia/")):
    sys.exit(0)
text = ti.get("content") or ti.get("new_string") or ""
if "banned-terms:ignore" in text:
    sys.exit(0)
bt = "data/banned-terms.txt"
if not os.path.exists(bt):
    sys.exit(0)
terms = [t.strip() for t in open(bt, encoding="utf-8") if t.strip() and not t.startswith("#")]
hits = [t for t in terms if re.search(re.escape(t), text, re.I)]
if hits:
    sys.stderr.write("BLOCKED: deliverable contains banned term(s): " + ", ".join(hits) + ". See data/banned-terms.txt; reword (e.g. client names -> sector publico/transporte/industria).\n")
    sys.exit(2)
'
