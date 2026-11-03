# Browser-automation lessons (Claude in Chrome)

1. **Start** with `tabs_context_mcp`; reuse the user's logged-in tab only because the user asked. Re-read the tab list after a "Couldn't determine which page this action targets", a screenshot timeout, or "Security check failed" (cross-domain navigation), then retry once. After 2-3 failures, stop and ask the user.
2. **Batch** independent calls (`browser_batch` or parallel tool calls).
3. **Prefer JS for flow control** on SPA forms: click the submit button via `setTimeout(()=>b.click(),50)`; set values with the native `value` setter + `input`/`change` events (React/Angular ignore a plain `.value=`).
4. **Custom dropdowns / typeaheads**: real click, type, click suggestion. JS-set hidden `<select>`s often do not register (Computrabajo). Long lists: scroll inside the list.
5. **Masked inputs** (salary, phone): `form_input` can leave them empty; use the keyboard (`type`) and re-screenshot.
6. **File upload**: never click upload buttons. `find` the file input, then `file_upload` with an absolute path inside the project.
7. **Domain permissions**: "Permission denied for this action on this domain" means the extension blocks that site; ask the user to allow it. Do not try other tools to bypass.
8. **New tabs**: external apply buttons open a new tab; its id appears in `tabs_context_mcp`.
9. **Output truncation**: long `javascript_exec` strings are cut (`[TRUNCATED]`). Slice the text in a second call.
10. **Verify success** with the confirmation screen text or screenshot before logging `applied`.
11. **Dates and selects** save wrong sometimes (Computrabajo end month): re-read the saved entry.
12. **Never**: type credentials, solve CAPTCHAs, trigger alert/confirm dialogs, run rapid loops of page loads on LinkedIn.
