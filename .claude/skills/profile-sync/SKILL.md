---
name: profile-sync
description: Improve and keep consistent the user's profile on each job site (LinkedIn text drafts, Get on Board, elempleo, Computrabajo, Indeed, Torre, others) from the master profile, adapting to each site's fields and limits, applying via the user's Chrome only on request. Use when building or refreshing profiles across job sites or after profile.md changes.
---

# profile-sync

One master truth (`data/profile.md`), many site-specific renderings.

## Steps
1. **Inputs**: `data/profile.md`, `data/preferences.md`, `data/form-data.md`, base CV (`outputs/base-cv.md`), `.claude/skills/job-sites/registry.md`, the site's playbook "Profile setup".
2. **Gap map**: for each site in `data/site-status.md` with state `ok`, compare what the playbook says is required (sections, fields, limits) against what is filled. Output a table: site | completeness | missing | priority.
3. **Render** per site from the master profile: headline/summary within the site's limits, skills in the site's vocabulary and levels (honest levels only), experience bullets (`Verb + what + how + result`), languages, salary range/pay expectation as recorded in `form-data.md`, privacy/visibility settings per `preferences.md`. Banned terms never appear (`data/banned-terms.txt`).
4. **LinkedIn**: produce text for the user to paste (never edited by Claude); use `linkedin-audit`.
5. **Other sites**: run `job-preflight`, then, only if the user asks in chat for this batch, fill the profile through Chrome following the playbook (real clicks for custom dropdowns, verify each saved section by re-reading it). Never create accounts or type credentials/IDs.
6. **Record**: update the site's playbook (what was entered, gotchas) and `registry.md`, and mark the section in `data/site-status.md`.

## Rules
- Nothing invented; a missing fact is asked, not guessed.
- Keep the same facts, titles and dates across all sites; report inconsistencies you find between sites.
- Re-run after every `profile-intake` update and monthly.
