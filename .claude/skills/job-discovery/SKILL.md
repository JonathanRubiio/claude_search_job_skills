---
name: job-discovery
description: Find remote software-development vacancies open to LATAM candidates via web search and read-only LinkedIn browsing, dedupe against the tracker, and hand them to job-fit. Use for "busca ofertas", weekly discovery, or searching a specific company/role/stack.
---

# job-discovery

Requires `data/preferences.md` (roles, stack, deal-breakers).

## Step 0: load what is already known (always first)
Read `data/tracker.md`, `data/applications-log.md` and `data/search-log.md`. Build the exclusion set (company + role + URL of everything found, applied, discarded or skipped) and the list of queries/sites already run with their dates. This session must surface **only new vacancies**: vary queries (other stack keywords, seniority wording, sites, filters, date window since the last run of that query) instead of repeating the logged ones.

## Query strategy: broad first, specific second (user rule, 2026-11-03)
Do not search only by exact stack ("NestJS" returns a handful and hides good roles with generic titles). Run in this order on every site:
1. **Broad role terms**, no stack: `desarrollador de software`, `desarrollador`, `programador`, `ingeniero de software`, `desarrollador web`, `desarrollador backend`, `desarrollador full stack`, and the English equivalents on English boards.
2. **Broad modality/location filters**: remote (`remoto`, `desde casa`, `teletrabajo`) and the home city; date window 7-15 days. Use the site's own filters before keywords.
3. **Page through** results (at least pages 1-3, or all if < 100) and triage by reading the card, not by keyword match.
4. **Then** run stack-specific queries (Node.js, NestJS, TypeScript, GraphQL) as a complement to catch what generic terms ranked low.
5. **Judge by the posting**, not the title: open every candidate that is remote/home-city and not obviously senior-only or another stack; read stack, contract, English, pay. Stack mismatch (Java/.NET/Python/Django/C#) discards it; unnamed stack ("Desarrollador de Software") is worth opening.
Record in the site playbook which broad queries were run and the hit rate, so the next session starts from the ones that worked.

## Steps
1. **Build queries** following the strategy above (broad first), then from preferences: role x stack x "remote" x ("LATAM" | "Latin America" | specific countries | "worldwide" | "contractor"). 6-10 query variants.
2. **Web search** (WebSearch, standard mode first):
   - Aggregators/boards: LinkedIn Jobs, Remote OK, We Work Remotely, Wellfound, Torre, Get on Board, Workable, Remotive, Himalayas, Working Nomads.
   - Company ATS pages: Greenhouse, Lever, Ashby, Workable, BambooHR boards (`boards.greenhouse.io`, `jobs.lever.co`, `jobs.ashbyhq.com`).
   - LATAM-friendly companies/agencies known to hire in the region (search "hiring in LATAM" lists; verify each).
3. **LinkedIn (read-only, user's logged-in Chrome)**, via `claude-in-chrome` tools:
   - Open the Jobs search URL with filters: keywords, Remote, date posted past week, Easy-Apply optional, location LATAM/country.
   - Read result cards with `get_page_text`/`read_page`; open at most ~15 job details per session; pause between page loads.
   - During discovery never click Apply/Easy Apply, Connect, Message, Follow or save. Applying happens only through `job-apply` when the user asks in chat. Never run loops of rapid page loads. If a CAPTCHA/verification or warning appears, stop and tell the user.
   - If the extension is unavailable, give the user the exact search URLs to open and ask them to paste the descriptions.
4. **Verify each candidate**: posting still open (date, not "no longer accepting"), real company (site, size, funding/reviews), remote scope really includes LATAM/the user's country (many say "remote" but require US residency), contract type, salary if listed, language. Flag ghost-job signals: reposted for months, vague, no named team, mismatch of tech.
5. **Dedupe** against the tracker and the applications log by company+role+URL, and by company+role when the same job is re-published under a new URL. Report duplicates as "already known (J-0xx, applied <date>)", not as new.
6. **Register** survivors in the tracker as `found` with today's date and source URL (use `tracker`), then run `job-fit` on each. Present a table: company, role, seniority, stack, pay, remote scope, flags.
7. **Log the run**: append one line per site/query to `data/search-log.md` (date, site, query/filters, results read, new, already known). Do this before reporting.

## Rules
- Per-site search URLs, filters and hit-rate notes: `.claude/skills/job-sites/registry.md` and `playbooks/linkedin.md`. Update them after each session.
- Report only vacancies you actually opened/verified; say which could not be verified.
- Prefer direct company application links over aggregators.
- Warn about scams: asks for payment/equipment purchase, WhatsApp/Telegram-only contact, "too good" pay, generic Gmail recruiter.
- Cap a batch at ~20 verified listings; quality over volume.
