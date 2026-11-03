# elempleo playbook

- URLs: CV `https://www.elempleo.com/co/hoja-de-vida` | offers `https://www.elempleo.com/co/ofertas-trabajo/<slug>-<id>`
- Login: user logs in. Document number comes prefilled by the site: never type it.
- Last verified: 2026-11-02

## Profile setup (CV at 85%, visible)
| Field/section | Value source | Notes |
|---------------|--------------|-------|
| Personal info | `data/form-data.md` | Surnames: set FirstSurName and SecondSurName separately; a single "Surname1 Surname2" field duplicated the second surname |
| Perfil laboral | profile + preferences | Salary range in millions ("$6 a $8"); CanMove/CanTravel unchecked (remote / home city only) |
| Experience | profile | Only the employer, with the honest title; no banned terms |
| Education | profile | Add each study; the add-study form sometimes does not open (retry) |
| Profession | - | Typeahead returned "No tenemos coincidencias" for every term; left "Sin Profesión" |

## Apply flow
1. Open the offer, click "Postularme a oferta" (one click).
2. "Postulación exitosa" page; then a data-processing modal ("Entendido") and an optional video ("Omitir").
- No letter field on one-click offers: the letter is not sent. If a letter matters, apply elsewhere or via the company.

## Gotchas
- Titles lie: a posting titled "semisenior" and "Remoto" can describe a Senior role in another stack in the body ("Descripción del cargo"). Always read the description before scoring.
- Chrome sometimes shows "Security check" errors on screenshots/navigation: call `tabs_context_mcp` and retry.
- Typeaheads (sector, position, institution, city) work by clicking the field, typing, then clicking the suggestion; typing alone does not set the value.
- A study in progress must not have a future end date: leave the end date empty.
- The automatic CV import ("Usar mi HV" -> "Analizar con IA") did nothing: fill manually.
- Offers show contract type ("Indefinido", "Por obra o labor") and salary range: use them for the fit filter.

## Not done / open
- Find a profession value that the typeahead accepts; confirm study city.

## Profile completion round (2026-11-03: stays 95%)
- Viewport quirk: `getBoundingClientRect` is in a 1710px-wide viewport while clicks use a 1456px frame: multiply coordinates by 0.85. The page jumps when sections open: re-measure before every click.
- Optional sections are anchors `#estudios-formales`, `#languages`, `#habilidades`, `#anexos`, `#red-social`; each "Agregar..." opens an inline form.
- Languages: `select[name="Languages.SelectedIds"]` (4 = Inglés) set by JS, then click the Básico button in each of the 4 rows (Escrito, Hablado, Leído, Escucha), then "Guardar idioma".
- Skills: type in the field, click the orange "+" (Enter does not add), repeat; then "Guardar habilidades". Saved: Node.js, NestJS, TypeScript, GraphQL, API REST, MySQL, MongoDB, Microservicios, Docker.
- Social: only Facebook, X, LinkedIn. Saved LinkedIn URL.
- Anexos: `find` the "Adjuntar" file input, `file_upload` the CV PDF; URLs field + "+" for GitHub; then "Guardar anexos". Saved CV and GitHub.
- Education: Universitaria / Ingeniería de Sistemas, Telemática y afines (35) / Culminado / Sep 2023 - Oct 2025 / CUN filled by JS + typeahead, but it requires the study CITY (unknown, not in profile): NOT saved. Ask the user, then re-add.
