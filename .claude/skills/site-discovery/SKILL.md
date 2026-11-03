---
name: site-discovery
description: Find new job sites and boards worth searching (by country, stack and modality), evaluate them, and add them to the site registry as candidates so job-round can test and rotate through them. Use when the user asks for more places to search, when the registry is small or stale, or as the "grow the list" step of every discovery round.
---

# site-discovery

Goal: the registry keeps growing and improving. More good sources = more new vacancies.

## Steps
1. **Read** `.claude/skills/job-sites/registry.md` and `data/preferences.md` (country, stack, modality, language, contract type). Never propose a site already listed under any status.
2. **Search the web** (WebSearch standard) for 3-5 queries per run, varying angle: country job boards, remote-LATAM boards, stack-specific boards (Node, Python, etc.), company ATS aggregators, communities/newsletters with job posts, "hiring in LATAM" lists, recruiter agencies for the user's seniority.
3. **Screen each candidate** without logging in: is it real and active (recent posts), does it list the user's role/stack, does the remote scope include the user's country, language, employee vs contractor, free to browse, any scam signals. Max 5 candidates per run.
4. **Register** survivors in `registry.md` under "Candidates" as `untested` with URL, why it fits, how to search it (URL pattern if visible). Create a stub playbook from `playbooks/_template.md` only when first tested.
5. **Test** (in the next `job-round`, or now if the user is present): one search, record hit rate (relevant results / results read) and the login requirement in the playbook and `data/site-status.md`. Promote to `partial`/`done`, or mark `dormant` (hit rate ~0 after two tests) or `blocked` (extension denies the domain).
6. Report: sites added, sites promoted/demoted, and which need the user's login before they can be used.

## Rules
- Public pages only; no scraping loops, no accounts created for the user.
- Keep playbooks and registry free of personal data.
- Quality over volume: a site that returns nothing relevant twice goes `dormant`.
