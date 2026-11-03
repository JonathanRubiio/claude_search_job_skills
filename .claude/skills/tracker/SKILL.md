---
name: tracker
description: Maintain data/tracker.md (add/update vacancies, statuses, next actions and due dates), surface overdue follow-ups, and report funnel metrics. Used by the other job skills and directly for status or "qué sigue" questions.
---

# tracker

File: `data/tracker.md`. One row per vacancy.

## Operations
- **add**: assign next ID (`J-001`...), date found, company, role, source URL, status `found`. Dedupe on company+role+URL.
- **update**: change status/fit/next action/due. Always set `Next action` and `Due` for any active status.
- **review** (default for status requests):
  1. Overdue or due-today actions first.
  2. Stale rows: `applied` >10 days without reply -> suggest follow-up via `outreach`; >21 days -> mark `ghosted` (ask first).
  3. Funnel counts: found -> shortlisted -> applied -> screen -> interview -> offer, with conversion rates.
  4. Diagnose the bottleneck: low shortlist = discovery/filters; applied but no screens = CV/profile (`linkedin-audit`, `cv-tailor`); screens but no interviews = pitch; interviews but no offers = `interview-prep`.
  5. Recommend 1-3 concrete actions for the week.
- **archive**: move `rejected`/`discarded`/`ghosted` older than 60 days to a `## Archive` section.

## Traceability files
- `data/tracker.md`: current state of every vacancy (mutable).
- `data/applications-log.md`: append-only record of each submitted application with its date (written by `job-apply`).
- `data/search-log.md`: append-only record of each search run (written by `job-discovery`).
If the tracker says `applied` but the log has no line, add the missing line (use the date in the status) and tell the user.

## Rules
- Dates absolute (YYYY-MM-DD).
- Record rejection reasons when known; they feed back into `preferences.md` and the CV.
