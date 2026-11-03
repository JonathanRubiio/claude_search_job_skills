# LinkedIn playbook

- URLs: jobs search `https://www.linkedin.com/jobs/search/?keywords=...` | job `https://www.linkedin.com/jobs/view/<id>/`
- Login: user logs in. Session reused.
- Last verified: see git history

## Profile
Profile edits are done by the user by hand (the skill never edits the profile). Text drafts live in `outputs/linkedin-rewrite-*.md`. Use `linkedin-audit` for the rubric.

## Discovery (read-only, low volume)
- Filters: `f_WT=2` remote, `f_TPR=r604800` week or `r2592000` month, `f_E=3,4` mid levels, `f_JT=F` full-time, `f_AL=true` Easy Apply only; location "Colombia" or your city.
- Query variants: stack keyword alone, role + stack in Spanish and English, `A OR B OR C` of your stack.
- Extract cards with JS: `[...document.querySelectorAll('li[data-occludable-job-id], .job-card-container')]` -> text + `a[href*="/jobs/view/"]` id. Cap ~15 job details per session and ~6 searches.
- Read a posting: `document.querySelector('main').innerText`, then slice from "Acerca del empleo". The output truncates: slice a second time from the requirements heading.

## Apply flow
- Buttons: "Solicitud sencilla" = Easy Apply inside LinkedIn (untested here). "Solicitar" with an external-link icon opens the company ATS in a NEW tab: switch to it with `tabs_context_mcp`, then follow `external-forms.md`.
- `find` is denied on linkedin.com; use a screenshot and a coordinate click on the apply button.
- Only apply when the user asks for it in chat (job-apply gate). Never Connect/Message/Follow.

## Calibration
Most mid-level-looking results are senior (6+ yrs), a different stack, hybrid in big cities, or require fluent English. Expect a low hit rate; do not lower the filters to inflate numbers.

## Gotchas
- Navigating to another domain can trigger "Security check failed": re-read the tab state and retry.
- Cards repeat promoted listings and the same company in several locations: dedupe by id.
