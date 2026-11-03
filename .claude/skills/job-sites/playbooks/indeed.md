# Indeed Colombia playbook

- URLs: search `https://co.indeed.com/jobs?q=<q>&l=<place>&fromage=14` | job `https://co.indeed.com/viewjob?jk=<id>`
- Login: not needed to read. "Postúlate rápidamente" applies with an Indeed profile (user's account, untested).
- Last verified: 2026-11-02

## Profile setup (onboarding, 5 steps, done; user was already logged in)
| Step (URL) | Value | Notes |
|------------|-------|-------|
| `/onboarding/location` | Your home city and postal code | Prefilled from the account |
| `/onboarding/pay` | Minimum monthly pay | Indeed suggests a value; set it to the floor in `preferences.md`. Triple-click the field, then type |
| `/onboarding/job-types` | Indefinido + Tiempo completo | Prefilled; leave Freelance/Temporal/Practicas unchecked (employee only) |
| `/onboarding/desired-job` | Your target role title | Typing a 2nd title in the same field concatenates; use the "Agregar otro" button. Select the suggestion before Continuar |
| `/onboarding/privacy` | "Las empresas pueden encontrarte" | Your decision (visible to recruiters) |
- After onboarding the home page says no CV yet: next is "Subir HV" with your CV PDF, then skills/languages.
- The home "Empleos para ti" feed is mostly English-language assistant/marketing roles: ignore it, use targeted searches.

## Discovery
- Card extraction: `[...document.querySelectorAll('div.job_seen_beacon')]` -> text + `a[data-jk]` (each card appears 2-3 times: dedupe by jk).
- Read a posting: `document.body.innerText` from "Descripción completa". Many postings end with employer screening questions (English level, years, AWS, salary): note them for the answers table.
- The remote attribute filter `sc=0kf:attr(DSQF7);` returned zero for "nestjs". Use the words `remoto` / `desde casa` in the query with location "Colombia" instead.
- Query variants that returned results: queries combining your role, stack and `remoto`.

## Blockers
- **Cloudflare "Verifica que eres un ser humano"** appeared on the 3rd search in a row (city search). Never solve it. Stop, tell the user; they can pass it by hand in the browser, then resume at low volume (max ~4 searches and ~6 postings per session).

## Calibration
Results tend to be on-site in Bogotá, Python/Java/.NET, senior, or English-required. Expect a low hit rate for mid-level remote Node/TypeScript roles; do not lower the filters to inflate numbers.

## CV upload (example run: NOT saved)
Profile page `https://profile.indeed.com/` (menu icon > Perfil) shows "Subir HV". The button is not a file input: clicking it creates a hidden `input[type=file]`; `find` it and `file_upload` accepted the PDF (4 KB) but the page never showed it, even after reload. Not retried (no loops). User must click "Subir HV" and pick your CV PDF by hand. The profile also shows an empty "Nombre" and no phone: user to fill.
