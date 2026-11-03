# Get on Board playbook

- URLs: profile edit `https://www.getonbrd.com/webpros/edit` | tags `https://www.getonbrd.com/jobs/tag/nestjs` | apply `<job-url>/applications/new`
- Login: user logs in. Session reused.
- Last verified: see git history

## Profile setup (what was entered)
| Field/section | Value source | Notes |
|---------------|--------------|-------|
| Professional + academic text (ES and EN) | rewritten from `data/profile.md` | No banned terms, no invented certs or metrics |
| LinkedIn URL | `data/profile.md` | Check it is correct |
| Skills | profile | Set levels honestly; lower any skill the profile does not support |
| CV | your CV PDF | Uploaded and set as default with a descriptive label (e.g. "CV Backend 2026"); "update profile from CV" left unchecked to avoid overwriting edited text |
| Not touched | GitHub link (needs OAuth), portfolio, seniority, video | Ask the user |

## Apply flow (3 steps + preview)
0. If `<job-url>/applications/new` returns 404, open the job page and click the green "Postular" with a COORDINATE click (a `ref` click may not navigate); the form URL differs (`/jobs/<slug>/applications/new?apply_click=...`).
1. Open `<job-url>/applications/new` (logged in).
2. **Step 1**: experience, prefilled from profile; check it.
3. **Step 2**: pick CV, salary ask in USD (gross monthly), "why interested" (50-1000 chars, use the tailored letter, name gaps).
4. **Step 3**: company questions (textareas, in page order) and radios.
5. Preview modal -> "Enviar postulación ahora". Confirm the success page.
- Advance steps reliably with JS, not coordinates: click `button[type=submit]` whose text is "Siguiente" using `setTimeout(()=>b.click(),50)`.
- Fill with native setters: `Object.getOwnPropertyDescriptor(HTMLTextAreaElement.prototype,'value').set.call(el,v)` (same for `HTMLInputElement`), then dispatch `input` and `change`.

## Questions seen -> answers
| Question | Answer | Why |
|----------|--------|-----|
| Were you invited via LinkedIn / found through a LinkedIn post | No | True |
| Open to freelance / contractor | No (employee only) | `preferences.md` |
| Work "por proyecto" | Yes only with a labor contract | Accepts por obra o labor |
| Availability | As recorded in `form-data.md` | Ask the user |
| Net salary | Convert from the gross ask and disclose it to the user | Never guess silently |
| Salary ask (USD) | Gross monthly from `form-data.md` | Keep consistent across sites |

## Discovery and tracking
- `get_page_text` can return "Permission denied" on getonbrd.com at times; `javascript_exec` still works. List a tag page: `[...document.querySelectorAll('a[href*="/jobs/"]')]` -> href + text (title, company, location, salary, date). Job pages have no `<main>`: use `document.body.innerText` and slice from "Más trabajos de".
- Job page header shows contract (Full time / Freelance), seniority, applicant count, "Replies between X and Y days", and "Tu país no coincide con la ubicación del empleo" when the country is excluded.
- `https://www.getonbrd.com/applications` lists status per application (ENVIADA / VISTA...). Check it to know who opened the CV (VISTA = a recruiter opened it).
- `https://www.getonbrd.com/invitations`: companies' invitations to apply. The "Postular" button there is the only way (`<job-url>/applications/new` returns 404 for invitation-only flow). A `ref` click on the extension did not register, but a coordinate click on the blue button did (form at `/jobs/<id>/applications/new?invitation_id=...`). Invitation forms have no salary field, only experience, CV and "why interested".
- Invitations can be stale (8 months old) and for Freelance contracts: check the filters before applying.

## Gotchas
- Tag pages (`/jobs/tag/<tag>`): `javascript_tool` returns `[BLOCKED: Cookie/query string data]` when the output contains hrefs with query strings; return `a.pathname` only, or read the list with `get_page_text` (~50 cards, 3 pages). Then open each candidate and slice `document.body.innerText` from "Más trabajos de".
- Job header shows `Senior`/`Mid` level, contractor wording in the description, and the applicant count: use them to discard fast (1000+ applicants and old replies = low odds).
- Same company often posts the same role twice (e.g. "Full-Stack con IA"): apply once, skip duplicates.
- Contract type is often unstated: ask in the interview, note `confirm` in the tracker.
- Listing pages show applicant counts (1,500+ on some): apply early with a specific letter.
- Some roles are "LATAM residents only, Chile-compatible hours": state your timezone in the text.
- Real clicks on "Siguiente" sometimes do nothing; use the JS click.

## Profile completion check (2026-11-03)
- `webpros/edit` has no GitHub field; the "Portafolio" field now holds the GitHub URL (all three "Guardar todos los cambios" buttons belong to the same form).
- A YouTube URL (`webpro[youtube]`) was already present and unknown to the agent: the user should confirm it is intended.
- Description line: "Desarrollador Backend NestJS y Node.js".
