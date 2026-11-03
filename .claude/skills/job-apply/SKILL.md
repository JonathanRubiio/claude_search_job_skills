---
name: job-apply
description: Execute applications on job sites from the user's logged-in Chrome (Get on Board, elempleo, Computrabajo, LinkedIn, external ATS forms, Torre) using verified profile data, with an authorization gate and tracker logging. Use when the user says "postula", "envía las aplicaciones", "aplica a estas", or hands over vacancy links to apply to.
---

# job-apply

Turns shortlisted vacancies into submitted applications. Site-specific click paths live in `.claude/skills/job-sites/playbooks/<site>.md`; read the one for the site you are about to use.

## Gate (all must be true before ANY submit)
1. **Authorization**: the user asked in chat for this batch ("postula", "envía a todas"). A past batch does not authorize the next one. If unsure, list the vacancies and ask.
2. **Vacancy verified**: opened and read in full today (open, stack, seniority, contract type, remote scope, English requirement, salary). Source: `job-fit` / `job-discovery`.
3. **Honest fit**: no required skill is claimed that `data/profile.md` does not support. Gaps are named, never hidden. Stretch roles (e.g. senior asked, user mid) are allowed only if the user knowingly authorized and nothing false is asserted.
4. **Hard filters** from `data/preferences.md`: employee-only (unless the user overrides in chat), remote or on-site only in the home city, English requirement vs the user's real level, salary floor.
5. **Whole flow read first**: scroll/read every step of the form before submitting step 1. Multi-step forms can store a partial submission at step 1 (Remote Leverage did). If a later step needs something the user must do (English voice recording, assessment, ID upload), stop BEFORE step 1 and ask.
6. **No duplicates**: check `data/applications-log.md` AND `data/tracker.md`. Same company + same role (or the same posting re-published under another URL) -> skip and say so, citing the date it was applied.

## Never do (even if authorized)
Type passwords/tokens/government IDs (ID numbers come prefilled by the site or are typed by the user), create accounts, solve CAPTCHAs, accept terms on the user's behalf beyond the application's own consent checkbox, enter payment data, download files from untrusted sources. If a login is needed: ask the user to log in; never type credentials.

## Procedure per vacancy
1. Read `data/form-data.md` (personal data for forms) and `data/profile.md`. Missing field -> ask the user once, then save it to `data/form-data.md`.
2. Open the playbook for the site. Fill with the recorded answers (salary ask, availability, contract answers, radios).
3. Letter / "why interested" text: use `outputs/<date>-<company>-<role>/` or `cv-tailor` output; 50-1000 chars when the form limits it. Name 1-2 honest gaps. Never write banned terms (`data/banned-terms.txt`; a hook enforces it).
4. Submit with the site's final button. Confirm the success screen (screenshot or page text), not just the click.
5. Log immediately, in the same turn, with today's absolute date: (a) append one line to `data/applications-log.md` (date, tracker ID, company, role, site, URL, ask/contract, evidence = success-screen text); (b) `tracker` row `applied (<date>, <site>, <ask>)`, `Next action: wait for reply`, `Due: +7 days`. The log is append-only: never rewrite old lines. A batch is not reported as done until both are written.
6. If the form revealed new reusable data (a new question and its answer), append it to the site's playbook under "Questions seen".

## Salary asks (defaults, override per `data/preferences.md`)
Use the ask already recorded for that site/company; otherwise USD gross monthly for USD-paid roles, COP for local roles. Keep asks consistent across sites; record each one in `data/form-data.md`.

## After a batch
Report to the user in Spanish: applied (with site and ask), skipped (why), blocked (what they must do), discarded (why). Offer the next discovery wave.
