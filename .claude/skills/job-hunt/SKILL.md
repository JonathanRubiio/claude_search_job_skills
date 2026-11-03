---
name: job-hunt
description: Entry point and router for the personal job-search system (software dev, remote LATAM). Use when the user says "empecemos", "qué sigue", "job hunt", asks for status, or wants to improve their profile, find jobs, apply or prepare interviews without naming a specific step.
---

# job-hunt (orchestrator)

Reads the project state and decides the next step. Never do a step's work here; delegate to the matching skill.

## State check (always first)
0. `data/` missing or `data/profile.md` is still the template and `inputs/` has no CV? -> **first-run onboarding**: run `scripts/init.sh` if `data/` does not exist, then `profile-intake` in *cold start* mode. Do not route anywhere else until the base profile and base CV exist.
1. `data/profile.md` — empty or mostly `TODO`? -> run `profile-intake`.
2. `data/preferences.md` — blanks in roles/stack/salary/deal-breakers? -> ask the user, fill it.
3. LinkedIn audit done? (`outputs/linkedin-audit-*.md` exists) -> if not, `linkedin-audit`.
4. `data/tracker.md` — empty or stale (>7 days since last `found`)? -> `job-discovery`.
5. Entries `shortlisted` without a folder in `outputs/` -> `job-fit` then `cv-tailor`; submit with `job-apply` only when the user asks.
6. Entries `screen`/`interview` -> `interview-prep`.
7. Overdue `Next action` / `Due` in tracker -> surface first.

## Routing table
| User intent | Skill |
|-------------|-------|
| Load/refresh CV, LinkedIn, GitHub data | `profile-intake` |
| Improve LinkedIn profile | `linkedin-audit` |
| Find vacancies | `job-discovery` |
| "Does this job fit me?" / pasted offer | `job-fit` |
| Tailor CV / cover letter for an offer | `cv-tailor` |
| Message to recruiter / hiring manager / referral | `outreach` |
| Apply / "postula" / send applications | `job-apply` (gate, then site playbook) |
| How a site works, build profile on a job site, add a site | `job-sites` |
| Prepare for screen/technical/behavioral | `interview-prep` |
| Status, follow-ups, metrics | `tracker` |

## Weekly cadence to propose
- Mon: `job-discovery` (new batch) + `job-fit` on results.
- Tue-Thu: `cv-tailor` + `outreach` for top 5 fits, user applies/sends.
- Fri: `tracker` review, follow-ups, `interview-prep` for upcoming.
- Monthly: `linkedin-audit` re-score, update `profile.md` with new wins.

## Output
Reply in Spanish, short: current state (1-3 lines), recommended next step, and ask for the one input needed to proceed.
