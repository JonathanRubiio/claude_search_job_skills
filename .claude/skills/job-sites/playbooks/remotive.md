# Remotive playbook

- Web search is paywalled (shows 0.4% of jobs, filters locked). Public API works and is readable in-browser: `https://remotive.com/api/remote-jobs?category=software-dev&search=node&limit=60`; parse `document.body.innerText` as JSON and filter `candidate_required_location` for LATAM/Colombia/Worldwide.
- Last verified: 2026-11-02: results were mostly contractor/freelance. If you only accept employee contracts the site is low-value. Check only occasionally.
