---
name: job-sites
description: Registry and per-site playbooks for job boards used in this project (Get on Board, elempleo, Computrabajo, LinkedIn, Torre, external ATS forms, Remote Leverage, others): how the user's profile was built on each, how applying works, browser-automation gotchas, and which sites are blocked or untested. Use before building a profile or applying on any job site, or when adding a new site.
---

# job-sites

Knowledge base so the work is repeatable by anyone with this project and a logged-in Chrome.

## Files
- `registry.md`: every site, URL patterns, status (`done` / `partial` / `untested` / `blocked`), what to do next.
- `playbooks/<site>.md`: for one site: login, **profile setup** (what we entered and why), **apply flow**, **questions seen + answers**, gotchas.
- `playbooks/_browser-lessons.md`: cross-site rules for the Claude-in-Chrome tools (JS clicks, native setters, typeaheads, upload, blocked domains).
- `playbooks/_template.md`: copy it to add a new site.

## How to use
1. Need to build/refresh the user's profile on a site -> read its playbook "Profile setup"; take the values from `data/profile.md` and `data/form-data.md`. Never invent: a missing field is asked.
2. Need to apply -> follow `job-apply` (gate) + the site's "Apply flow".
3. After touching a site, **feed back**: update the playbook (new gotcha, new question, changed UI) and `registry.md` status. Do this in the same turn, before reporting.
4. New site -> copy `_template.md`, fill as you go, add a row to `registry.md`.

## Rules
- The user logs in. Never type credentials.
- LinkedIn is read-only for discovery (see its playbook); applying there only on explicit request.
- Respect site permissions: if the extension reports "Permission denied" for a domain, do not work around it; ask the user to allow it or paste the content.
- Keep personal data out of playbooks (they are shareable). Reference `data/form-data.md` instead of copying values.
