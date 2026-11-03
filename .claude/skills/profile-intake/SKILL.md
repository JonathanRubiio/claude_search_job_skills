---
name: profile-intake
description: Build or refresh the master profile (data/profile.md) from the user's CV in inputs/, LinkedIn URL and GitHub/portfolio, plus a guided interview for gaps. Use first, before any audit, tailoring or job matching, and whenever the user has new experience to add.
---

# profile-intake

Goal: one verified, structured `data/profile.md` that every other skill trusts.

## Cold start (first run, nothing available)
Use when `data/profile.md` is the template and `inputs/` has no CV, or the user says they have no CV. Goal: collect everything needed to write a CV and to search for jobs afterwards. Say upfront: this takes about 20-30 minutes, answers can be rough, "I don't know" is fine, and nothing is invented.

Ask in themed rounds (max 5 questions each, wait for answers, then move on). Save raw answers to `inputs/intake-answers.md` as you go so nothing is lost if the session stops.
1. **Who and where**: full name (first/second surnames), city, country, timezone, email, phone/WhatsApp, LinkedIn, GitHub, portfolio. Work authorization by country (never ask for ID numbers).
2. **What you want**: target roles ranked, seniority you aim for, stack you want / accept / refuse, remote or on-site (which city), contract types accepted (employee, contractor), salary floor and target + currency, deal-breakers, availability to start, willingness to relocate.
3. **Languages**: spoken and written level for each (be honest; roles requiring more will be skipped), can you do interviews in English?
4. **Experience, one job at a time** (newest first): employer (or sector if confidential), title, start/end month, stack, what you owned, team size, 2-4 achievements each with a number (users, time saved, cost, latency, uptime, volume). If no numbers: ask "what changed because of your work?". Ask which employer/client/title names must not appear anywhere -> `data/banned-terms.txt`.
5. **Projects and proof**: personal/open-source projects (what, stack, link, your role), certifications, courses, publications, talks.
6. **Education**: degree/technical studies, institution, dates (in-progress allowed, no future end dates).
7. **Skills with evidence**: for each technology, years and where used (level 1-5 rules below).
8. **Gaps**: employment gaps, years missing vs the target seniority, technologies the market asks and you lack, things you are learning.
9. **Form data**: gender / birth date / marital status only if applications in the user's market ask for them; address; standard answers (availability, contract, work mode).

Then: write `data/profile.md`, `data/preferences.md`, `data/form-data.md`, `data/banned-terms.txt`; list every unknown as `TODO` under "Unverified claims"; show a summary and get confirmation; finally run `cv-tailor` in **base CV mode** to produce `outputs/base-cv.md` (+ offer .pdf/.docx). Only after that, hand over to `linkedin-audit` / `job-discovery` via `job-hunt`.

## Steps
1. **Collect sources**
   - Read CV files in `inputs/` (PDF via Read with `pages`, docx via the docx skill if needed).
   - LinkedIn URL and GitHub/portfolio: read with Chrome tools (`claude-in-chrome`, read-only: `get_page_text`/`read_page`) or WebFetch for public pages. If login-walled, ask the user to paste the text.
   - GitHub: list pinned/top repos, languages, recent activity, READMEs of the 3-6 most relevant.
2. **Extract** into the `data/profile.md` template: identity, skills with years/evidence, experience with achievements, projects, education, languages.
3. **Reconcile conflicts** between sources (dates, titles, stack). List them under "Unverified claims"; do not pick silently.
4. **Quantify**: for each role, ask for the missing metric behind every vague bullet ("mejoré rendimiento" -> how much, vs what, measured how). Max 5 questions per round, grouped.
5. **Honest gaps**: fill "Gaps and weaknesses" (missing years, no cloud, no English evidence, employment gaps) — used later to position, never to hide.
6. **Fill `data/preferences.md`** with the user: roles ranked, stack must/nice/avoid, salary floor/target in USD, deal-breakers, deliverables language.
7. Show a summary and ask the user to confirm. Only confirmed facts leave "Unverified claims".

## Rules
- Never infer skills from a job title or from a keyword in a repo you didn't read.
- Skill level 1-5: 1 = touched, 3 = production use, 5 = can teach/architect. Require evidence for 4-5.
- Keep it factual; no marketing language in the profile file.
