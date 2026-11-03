# Job Hunt System

Goal: improve the user's profile (LinkedIn + CV), find software-development roles that fit, and convert them into interviews.
Default market: remote LATAM, software development (editable in `data/preferences.md`). Reply in the language the user writes in; the language of deliverables is set in `data/preferences.md`.

## Layout

- `inputs/`: raw material the user drops in (CV PDF/Word, exports, notes).
- `data/profile.md`: master profile, single source of truth about the user. Everything else derives from it.
- `data/preferences.md`: target roles, must-haves, deal-breakers, salary floor, languages.
- `data/tracker.md`: pipeline of vacancies and their status.
- `data/stories.md`: STAR story bank for interviews.
- `data/site-status.md`: per-user login state, last run and hit rate per site (job-preflight / job-round).
- `outputs/digests/`: one digest per scheduled discovery round.
- `data/applications-log.md` and `data/search-log.md`: append-only, dated logs of every application and every search run. They are how discovery avoids repeats and how every action stays traceable.
- `data/form-data.md`: quick-fill personal data and salary asks for application forms. `data/banned-terms.txt`: terms no deliverable may contain (enforced by a hook).
- `archivos de guia/` (optional): final deliverables you want to keep handy (CV PDF, letters). Git-ignored.
- `templates/`: blank versions of every data file; copy them to `data/` (without `.example`) to start.
- `outputs/<YYYY-MM-DD>-<company>-<role>/`: per-vacancy deliverables (tailored CV, messages, prep).
- `.claude/skills/`: the system. Entry point is `job-hunt`. `job-apply` runs applications; `job-sites` holds the per-site playbooks (profile setup, apply flow, gotchas) and the site registry.
- `.claude/hooks/` + `.claude/settings.json`: session digest (tracker state, due follow-ups), banned-terms guard, tracker lint.

## Pipeline

`profile-intake` -> `linkedin-audit` / `profile-sync` -> `job-discovery` (+ `site-discovery`, `job-round`) -> `job-fit` -> `cv-tailor` -> `job-apply` (+ `outreach`) -> `interview-prep`, tracked in `tracker`. Site knowledge: `job-sites`.
The `job-hunt` skill routes between them.

## Hard rules

1. Never invent or inflate experience, metrics, titles, dates or skills. Every claim in a CV/message must trace to `data/profile.md`. If a fact is missing, ask the user.
2. Never send, submit, post, connect or apply on the user's behalf unless the user explicitly asks in chat for that batch; then follow the `job-apply` gate. Never type credentials/IDs, create accounts or solve CAPTCHAs. Default is drafts; the user sends.
3. LinkedIn browsing is read-only and low-volume (see `job-discovery`). No mass actions, no scraping loops, no automated connection requests or messages.
4. Never git commit/push without explicit authorization at that moment.
5. Keep personal data (CV, phone, email) inside this project; don't send it to third-party services.
6. Feedback loop: after touching any job site, update its playbook in `.claude/skills/job-sites/playbooks/` and `registry.md` in the same turn, and log the application in `data/tracker.md`.
7. Traceability: before searching, read the tracker and both logs and surface only new vacancies; after applying or searching, append to the matching log in the same turn with absolute dates.
8. Scheduled rounds (`job-round`) are discovery-only and read-only: they never apply, connect, message or save. Every Chrome task starts with `job-preflight`; a site that is not `ok` is skipped and reported, never worked around.
9. Do not mention banned terms (`data/banned-terms.txt`) in any deliverable; the hook blocks it.
8. Search broad before specific: generic role terms and the site's remote/city/date filters first, stack-specific queries second; triage by reading postings, not by title keywords (see `job-discovery`).
