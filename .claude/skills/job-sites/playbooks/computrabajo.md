# Computrabajo playbook

- URLs: offers `https://co.computrabajo.com/ofertas-de-trabajo/oferta-de-trabajo-de-<slug>-<id>` | CV wizard (post-registration steps 3-4)
- Login: user logs in / registers. Never create the account for the user.
- Last verified: 2026-11-02

## Profile setup (CV created through the wizard)
| Section | Value source | Notes |
|---------|--------------|-------|
| Education | profile | First save can put the wrong end month ("Enero"); correct it through edit (pencil) |
| Experience | profile | Title, employer, start date, "Actualmente" if current |
| Optional | older studies, skills, languages | Add if relevant |

## Apply flow
1. Open the offer, click "Aplicar" (one click) -> "Te aplicaste correctamente".
- Some offers require a minimum education (e.g. Especialización): in-progress counts only if the site shows it; apply anyway only if the user agrees.

## Gotchas
- The wizard uses custom dropdowns over hidden native `<select>`s. Setting the `<select>` by JS does NOT register. Use real clicks; for long lists scroll inside the list, then click the item.
- Verify each saved entry by re-reading the CV page: dates can save wrong.
- Strong source of on-site roles in mid-size Colombian cities.

## Discovery
- Search URL patterns: `/trabajo-de-<role>-en-<dept>-en-<city>?pubdate=15`, `/trabajo-de-desarrollador-backend-remoto?pubdate=15`. Cards: `article.box_offer`, link `a.js-o-link`. Read a posting with `document.body.innerText` from "Descripción de la oferta".
- Small cities have very few developer roles (1-2 per month). Remote results are mostly Bogotá companies; check the stack against your profile.
- The session can expire: clicking "Aplicar" redirected to `candidato.co.computrabajo.com/acceso` and the page then showed a Chrome error. Do not type credentials: ask the user to log in again.

## Broad-search log (rule: broad first)
- `https://co.computrabajo.com/trabajo-de-desarrollador-de-software` -> 261 offers (2026-11-03). Sorted by recency. Result: almost all on-site Bogotá/Medellín/Cali/Manizales or Django/Angular/C#/.NET/VB; 0 viable. The generic list is still the right first pass because it surfaces roles whose title has no stack.
- Broad queries run 2026-11-03 (all `?pubdate=15` or 30): `desarrollador-remoto` (65 offers), `ingeniero-de-software-remoto` (12), `desarrollador-en-cucuta` (60, mixes in remote national roles), `sistemas-en-cucuta` (204, nothing for dev). Only viable find came from `desarrollador-en-cucuta`: Integral Group Full Stack Senior (remote, indefinido). Stack queries alone had missed it.
- Cúcuta-filtered pages also list remote roles from other cities: read those too.
- Next broad queries to run each session: `trabajo-de-desarrollador`, `trabajo-de-programador`, `trabajo-de-ingeniero-de-software`, each with `-remoto` and with `-en-cucuta`; use `?pubdate=15` and page `?p=2`, `?p=3`.

## Not done / open
- Add older jobs, skills and languages from `data/profile.md`.
