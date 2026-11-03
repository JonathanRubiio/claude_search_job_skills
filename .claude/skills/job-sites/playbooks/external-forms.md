# External ATS and agency forms

Reached from LinkedIn "Solicitar" or a company page. Opens in a new tab: find its id with `tabs_context_mcp`.

## Dynamics ATS (portal.dynamicsats.com)
- Fields: Nombre, Apellido, Email, Teléfono, Ciudad, Estado/provincia, País, LinkedIn URL, Expectativa salarial mensual (gross, USD or local currency; Argentina/Chile/Peru hire by payroll), Skills grid (optional), Resume attachment.
- Page loads "Generating form...": wait, then `read_page` for refs.
- `form_input` works for text fields. It does NOT register on the masked salary field: click it and `type` the number with the keyboard (it formats to `2,200.00`).
- País is a tag select: click, type "Colombia", click the suggestion (about 40px below the field).
- Resume: `find` "file input for attachments" -> ref of the "Attach Files" button -> `file_upload` with the CV path. Never click the button (native dialog).
- Submit -> "Thank you for your application." is the success check.

## Agency form (remoteleveragejobs.com), example of a dropped flow
- Step 1 (name, WhatsApp with country picker, city, role, hourly rate, languages, full/part time, how found, portfolio, terms) is **stored as a partial submission when you press Submit**, before step 2.
- Step 2 requires a CV and an **English voice recording (30 s - 2 min)**. If your spoken English is not up to it, drop the application before step 1.
- Lesson: read the whole flow first (see `job-apply` gate 5). Hire model is contractor with US businesses: conflicts with employee-only.
- Phone country picker: click it, type "Colombia", click the result; `form_input` only sets the number.

## Pattern for new forms
1. `read_page filter=interactive` (or `find`) to get refs.
2. Fill with `form_input`; verify with a screenshot; fall back to real typing/clicks for masked or custom widgets.
3. Check required fields and the consent checkbox; submit; confirm the success screen; log in the tracker.
