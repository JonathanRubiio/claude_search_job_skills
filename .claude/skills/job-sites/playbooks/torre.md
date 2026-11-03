# Torre playbook

- URLs: posting `https://torre.ai/post/<id>-<slug>` | search UI `https://torre.ai/app/search-job?phase=results` | communities `https://torre.ai/sub/colombiatech/jobs`
- Login: user logs in ("Acceder" disappears when logged in).
- Last verified: 2026-11-02. Status: **blocked for the agent**.

## What works
- `get_page_text` on a `torre.ai/post/...` link returns the full description (read after `tabs_context_mcp` if the first call reports a domain change).

## What does not
- Browser actions (screenshot, click) return "Permission denied for this action on this domain" until the user allows torre.ai in the extension.
- The search UI renders without readable text for the agent; `javascript_tool` reports query-string data as blocked.
- `search.torre.co/opportunities/_search` returned HTTP 400 "Invalid request" with the bodies tried (skill/role term, status filter). Do not burn more turns here.

## Workflow until unblocked
1. Ask the user to paste `torre.ai/post/...` links of interest (or allow torre.ai in the extension).
2. Read each posting, run `job-fit`, apply via the Torre UI only after the user allows clicks.

## Not done / open
- Apply flow unknown. Build the Torre "genome" (profile) only with the user present.
