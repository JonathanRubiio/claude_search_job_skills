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
- Chrome sometimes shows "Security check" errors on screenshots/navigation: call `tabs_context_mcp` and retry.
- Typeaheads (sector, position, institution, city) work by clicking the field, typing, then clicking the suggestion; typing alone does not set the value.
- A study in progress must not have a future end date: leave the end date empty.
- The automatic CV import ("Usar mi HV" -> "Analizar con IA") did nothing: fill manually.
- Offers show contract type ("Indefinido", "Por obra o labor") and salary range: use them for the fit filter.

## Not done / open
- Find a profession value that the typeahead accepts; confirm study city.
