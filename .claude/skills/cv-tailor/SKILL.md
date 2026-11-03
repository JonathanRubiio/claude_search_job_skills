---
name: cv-tailor
description: Produce an ATS-friendly CV and cover letter tailored to one shortlisted vacancy, using only verified facts from the master profile. Use when the user wants to apply to a specific job or asks for a CV in a given language/format.
---

# cv-tailor

Inputs: `outputs/<date>-<company>-<role>/vacancy.md` (from `job-fit`), `data/profile.md`.

## Steps
1. Extract the vacancy's top keywords (exact phrasing of tools, practices, domain terms) and the "angle" from `job-fit`.
2. **Select, don't invent**: choose and order profile facts that answer the vacancy. Rewrite bullets as `Verb + what + how + result`, mirroring the vacancy's wording only where it is true for the user.
3. **Structure** (1 page for <8 yrs, max 2 otherwise), single column, no tables/graphics/icons (ATS):
   - Header: name, location/timezone, email, LinkedIn, GitHub/portfolio.
   - Summary (2-3 lines): title + years + core stack + strongest proof aligned to this role.
   - Skills: grouped, vacancy keywords first (only ones the user has).
   - Experience: reverse chronological; most relevant bullets first; cut irrelevant ones.
   - Projects (if they cover a gap), Education, Languages.
4. **Keyword check**: list vacancy must-haves and where each appears in the CV; flag missing ones as honest gaps (do not add).
5. **Cover letter / application answers** (short, <200 words): hook tied to the company's product, 2 proofs, why this role, availability/timezone/contract. No generic openers.
6. Save to `outputs/<date>-<company>-<role>/`: `cv.md`, `cover-letter.md`, `keyword-check.md`. Offer export to .docx/.pdf using the docx/pdf skills; filename `Name_Surname_<Role>.pdf`.
7. Update tracker status to `prepared`.

## ATS audit (on request or monthly)
Take the 10 most recent shortlisted/found vacancies in the tracker, extract their recurring keywords, and compare with the base CV: coverage %, missing keywords split into *true for the user* (add) and *not true* (honest gap, never add), formatting risks (tables, columns, icons, non-standard headings). Save to `outputs/ats-audit-<date>.md`.

## Base CV mode (no vacancy)
Used by `profile-intake` right after a cold start, or when the user asks for a general CV. Same structure and honesty rules, but the angle is the user's target role from `data/preferences.md` instead of one vacancy. Save as `outputs/base-cv.md` (and .pdf/.docx on request). `job-apply` can use it when no tailored CV exists; tailor per vacancy when fit is >= 60.

## Rules
- Every number/title/date must exist in `profile.md`; otherwise ask.
- Language follows the vacancy (English by default for international remote), native-quality, no literal translation.
- Avoid buzzwords ("results-driven", "team player"); prefer specifics.
