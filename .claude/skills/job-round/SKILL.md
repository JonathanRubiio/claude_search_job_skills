---
name: job-round
description: One scheduled discovery round (morning 07:00, midday 12:00, evening 17:00): rotate through the registry sites one by one with new queries, dedupe against the tracker and logs, score fits, grow the site list, queue follow-ups, and write a digest. Discovery only, it never applies. Use for "haz una ronda", "/loop" or cron-triggered runs.
---

# job-round

Discovery-only. **Never** applies, connects, messages, saves or posts. Applications happen later, when the user says so in chat (`job-apply` gate). Never types credentials or solves CAPTCHAs.

## Slots
| Slot | Focus |
|------|-------|
| 07:00 morning | Full rotation (up to 4 sites) + `site-discovery` + follow-ups due + status checks |
| 12:00 midday | Fast pass over boards with daily-fresh posts (up to 3 sites), filter by posted today |
| 17:00 evening | Last pass (up to 3 sites) + day summary + proposed apply list for tomorrow |

## Steps
0. **Load state**: `data/tracker.md`, `data/applications-log.md`, `data/search-log.md`, `data/site-status.md`, `data/preferences.md`, registry. Build the exclusion set and the queries already run.
1. **Preflight** (`job-preflight`, lightweight): classify sessions. Continue only with `ok` sites. Sites `needs-login`/`denied`/`challenge` go into the digest with the action the user must take.
2. **Pick sites by rotation**: sort eligible sites (`done`/`partial`/`untested`, not `blocked`/`dormant`) by oldest last run in `data/site-status.md`; take the slot's quota. Search **one site at a time**, reading its playbook first, with pauses between page loads. LinkedIn: read-only, <= 15 details per day across all rounds.
3. **Query**: pick queries not present in `search-log.md` for that site (change stack keyword, seniority wording, remote wording, date window since last run). Prefer "posted since last run".
4. **Per result**: open and read, verify it is open and real, `job-fit`. Register new ones in the tracker (`found`/`shortlisted`/`discarded`) with today's date. Known ones are counted as "already known".
5. **Grow the list**: run `site-discovery` (morning slot; evening if time). Test one candidate site per round.
6. **Follow-ups**: list tracker rows `applied` > 7 days (due or overdue). Draft messages via `outreach` into `outputs/`. Never send.
7. **Log** (same turn): one line per site/query in `data/search-log.md`; update `data/site-status.md` (last run, hit rate, state).
8. **Digest**: write `outputs/digests/<YYYY-MM-DD>-<slot>.md` with: new shortlisted vacancies (company, role, fit, link, why), already-known count, sites searched, sites needing the user's action (login/permission/CAPTCHA), follow-up drafts ready, suggested apply list. The `session-digest` hook shows the latest one when the user opens Claude.
9. If a CAPTCHA, warning or rate limit appears: stop that site, note it, move on.

## Starting the routine (needs the machine on, Chrome open with sessions logged in)
- In a Claude Code session: `/loop` with a cron expression, e.g. prompts "run job-round morning slot" at `0 7 * * *`, `0 12 * * *`, `0 17 * * *` (session-bound: it lives while the session is open).
- Or the desktop app's local scheduled tasks, which use local files and Chrome but only run while the computer is awake.
- Cloud routines run without your machine but have no access to your logged-in Chrome: use them only for public-API/public-page searches.
Whether the Chrome extension works in an unattended run must be tested once with the user present.
