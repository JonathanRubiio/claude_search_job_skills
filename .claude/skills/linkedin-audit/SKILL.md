---
name: linkedin-audit
description: Audit and rewrite the user's LinkedIn profile (headline, About, Experience, Skills, Featured, banner/photo, settings) for recruiter search and conversion, scored against a rubric. Use when improving LinkedIn, being found by recruiters, or re-scoring monthly.
---

# linkedin-audit

Requires `data/profile.md` and `data/preferences.md` filled (else run `profile-intake`).

## Steps
1. Read the live profile (Chrome read-only on the user's own profile, or pasted text). Record current text of every section.
2. **Keyword basis**: collect 15-25 recurring terms from 10+ real vacancies for the target role (use `job-discovery` results or search). Rank by frequency; split must-have vs nice-to-have. Save in the audit file.
3. **Score** each area 0-10 using `rubric.md` (this folder). Total /100.
4. **Rewrite** each weak section (see templates below), using only facts from `profile.md`. Offer 2-3 headline variants.
5. **Write the audit** to `outputs/linkedin-audit-<YYYY-MM-DD>.md`: score table, before/after per section, prioritized action list (impact vs effort), settings checklist.
6. The user pastes changes into LinkedIn; you never edit the profile.

## Templates
- **Headline** (<=220 chars): `<Target title> | <2-3 core techs> | <differentiator or outcome> | Remote LATAM/Open to <region>`. Keywords first; no "passionate", no emojis spam.
- **About** (first 3 lines visible before "see more"): line 1 who you help/what you build; 2 proof (metric); 3 stack + what you seek. Then short paragraphs: impact, stack, how you work, contact/CTA. Written in first person, scannable.
- **Experience**: per role 3-5 bullets `Verb + what + how (stack) + measurable result`. Most recent role most detailed. Add stack line at end for keyword indexing.
- **Skills**: top 3 pinned = target-role must-haves; 30-50 total, ordered by keyword rank; ask for endorsements on pinned ones.
- **Featured**: 2-3 items: best repo/demo, article, project case study.
- **Open to Work**: set to "recruiters only" with target titles and remote; avoid the public green banner unless the user prefers it.
- **Settings checklist**: custom URL, location/timezone set to match market, contact info, language versions, "Open to Work" job titles/locations, activity visibility.

## Rules
- Do not add skills or achievements not in `profile.md`.
- Keep bilingual versions if `preferences.md` says es+en: write English as native copy, not a literal translation.
- Re-run monthly and compare scores.
