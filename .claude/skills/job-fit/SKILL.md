---
name: job-fit
description: Score how well a vacancy matches the user's profile and preferences (0-100) with evidence, gaps and an apply/skip/stretch recommendation. Use when the user pastes a job offer or URL, or after job-discovery returns candidates.
---

# job-fit

Inputs: vacancy (text/URL), `data/profile.md`, `data/preferences.md`.

## Steps
1. Parse the vacancy into: must-haves, nice-to-haves, responsibilities, seniority signals, stack, remote scope/timezone, contract, salary, language, company stage.
2. **Hard filters** (fail = `discard`, explain): deal-breakers in preferences, remote scope excludes user's country, salary below floor (if stated), required stack in "avoid".
3. **Score** (weights):
   - Must-have skills coverage — 35 (each must-have: met with evidence / partial / missing)
   - Seniority & scope match — 15
   - Stack alignment with target + nice-to-haves — 15
   - Logistics (timezone, contract, remote scope, language) — 15
   - Compensation vs target — 10
   - Company quality & signal (real, stable, growth, reviews) — 10
4. **Gap analysis**: for each missing/partial must-have, say if it is bridgeable (adjacent experience to reframe, quick learning) or a blocker. Never claim a skill the profile lacks.
5. **Recommendation**: `apply` (>=75), `stretch` (60-74: apply with strong tailoring/referral), `skip` (<60), `discard` (hard filter).
6. Update `tracker` with score and status (`shortlisted` or `discarded`), and record the vacancy text in `outputs/<date>-<company>-<role>/vacancy.md` for shortlisted ones.

## Output format
```
Fit: 82/100 — apply
Must-haves: 6/7 met | gaps: <x> (bridgeable via <y>)
Why it fits: ...
Risks/flags: ...
Angle for the application: <which 2-3 profile strengths to lead with>
```
