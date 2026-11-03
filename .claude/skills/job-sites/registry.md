# Site registry

Status: `done` = profile built + applications sent via this flow; `partial`; `untested`; `blocked`.
Update the status column as you use each site.

| Site | Role in the funnel | Status | Playbook | Notes |
|------|--------------------|--------|----------|-------|
| Get on Board | Remote LATAM tech jobs, native in-site application | done | `getonboard.md` | Profile edited, applications sent |
| elempleo | Colombian generalist board, one-click apply | done | `elempleo.md` | CV completeness ~85%; profession typeahead fails |
| Computrabajo | Colombian board, strong for on-site roles outside Bogotá | done | `computrabajo.md` | CV wizard done; one-click apply |
| LinkedIn Jobs | Biggest volume; mostly senior / English | partial | `linkedin.md` | Search URLs recorded; Easy Apply untested; external "Solicitar" opens an ATS |
| External ATS forms | Dynamics ATS, agency forms | partial | `external-forms.md` | Remote Leverage dropped (needs English audio) |
| Torre | Global network, Colombia sub-communities | blocked | `torre.md` | Agent cannot click/read results; user must paste `/post/` links or allow the domain |
| Indeed Colombia | Aggregator | partial | `indeed.md` | Readable; Cloudflare human check after ~3 searches (user must pass it) |
| Magneto365 | Colombian board | blocked | `magneto365.md` | Extension denies reading the domain |
| Hireline | LATAM remote tech | done | `hireline.md` | Very low volume; recheck monthly |
| Remotive | Remote aggregator (mostly contractor) | done | `remotive.md` | Paywalled UI; API usable; mostly contractor roles |
| startup.jobs / devjobsscanner | Aggregators | blocked | - | Pages blocked for the agent; user opens manually |
| Company ATS pages | Direct company pages | partial | - | Links often go dead (closed) |
| Multiplica Talent | Colombian staffing | blocked | - | Page blocked for the agent |

## Candidates (found by `site-discovery`, `untested`)
One row per candidate: URL, why it fits, how to search it. `job-round` tests one per round, then promotes it to the table above or marks it `dormant`/`blocked`.

| Site | URL | Why it fits | Added |
|------|-----|-------------|-------|

## Per-user state
Login state, last search run and hit rate per site are personal and live in `data/site-status.md`, not here.

## Search URL cheat-sheet
- LinkedIn: `https://www.linkedin.com/jobs/search/?keywords=<q>&location=<place>&f_WT=2&f_TPR=r604800` (`f_WT=2` remote, `f_WT=1` on-site, `f_WT=3` hybrid; `f_TPR=r604800` week, `r2592000` month; `f_E=3,4` associate/mid-senior; `f_JT=F` full-time; `f_AL=true` Easy Apply only).
- Get on Board: `https://www.getonbrd.com/jobs/tag/nestjs`, `.../tag/node-js`.
- elempleo: `https://www.elempleo.com/co/ofertas-empleo/trabajo-desarrollador-node-js-modalidad-remoto`.
- Torre: `https://torre.ai/sub/colombiatech/jobs`, `https://torre.ai/sub/remote-latam-information-technology/jobs`.

## Search rule
Always broad first (generic role + remote/city/date filters, several pages), then stack-specific. Details: `job-discovery` skill, section "Query strategy".
