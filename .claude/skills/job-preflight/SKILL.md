---
name: job-preflight
description: Before any browser work (profile edits, discovery rounds, applications), list the job sites about to be used, confirm the user is logged in on each in Chrome, verify extension permissions, and record per-site session status in data/site-status.md. Use at the start of any Chrome-based task or scheduled round, and when a site returns a login wall or "Permission denied".
---

# job-preflight

Claude never types credentials, so every Chrome task depends on sessions the user opened. This skill makes that dependency explicit and recorded.

## Steps
1. **Scope**: from the task, list the sites needed (profile edit, discovery, apply). Source: `.claude/skills/job-sites/registry.md` rows with status `done`, `partial` or `untested` (skip `blocked`/`dormant` unless the user insists).
2. **Chrome ready?** Call `tabs_context_mcp`. If the extension does not answer, stop and tell the user to open Chrome with the Claude in Chrome extension enabled.
3. **Per site, read-only check** (one page load each, spaced out): open the site's logged-in URL from its playbook and classify:
   - `ok`: logged-in marker visible (profile menu, "Mi cuenta", no "Acceder").
   - `needs-login`: login wall, redirect to `/acceso` or `/login`. Do not type anything.
   - `denied`: extension reports "Permission denied for this domain". Ask the user to allow the domain; never work around it.
   - `challenge`: CAPTCHA or human check. Stop on that site; the user passes it by hand.
4. **Record** the result in `data/site-status.md` (site, state, date-time, note).
5. **Report** in the user's language, short: ready sites, sites needing login (with the exact URL to open), denied domains. Ask the user to fix them, or continue with the ready sites only.

## Rules
- Never click apply/connect/follow/save during a preflight. Never type credentials.
- A site not `ok` is skipped for this run, not retried in a loop.
- Unattended runs (`job-round`) do a lightweight preflight and continue with whatever is `ok`.
