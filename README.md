# OfferPilot

**English** · [Español](README.es.md)

A job-search co-pilot for software developers, built as a set of [Claude Code](https://claude.com/claude-code) skills. It builds your master profile, audits your LinkedIn, finds and scores vacancies, tailors your CV, fills application forms in *your* logged-in Chrome, drafts outreach, and prepares you for interviews, tracking everything in one pipeline file.

It is tuned for **remote LATAM software roles** (Get on Board, elempleo, Computrabajo, LinkedIn, Torre...), but the skills and preferences are editable for any market.

> **Drafts by default.** OfferPilot never sends, applies, connects or posts unless you explicitly tell it to in chat for that batch. It never types your passwords, creates accounts or solves CAPTCHAs. It never invents experience: every claim must trace back to your profile.

---

## What you need

- [Claude Code](https://claude.com/claude-code) (CLI, desktop or IDE extension).
- Google Chrome with the **Claude in Chrome** extension (needed for reading job boards and filling forms; the profile/CV/interview skills work without it).
- `git`, `bash` and `python3` (the hooks use them). macOS or Linux; Windows via WSL.
- Your CV (PDF or Word) and, ideally, your LinkedIn and GitHub URLs.

## Quick start

```bash
# 1. Get the project
git clone https://github.com/JonathanRubiio/claude_search_job_skills.git
cd claude_search_job_skills

# 2. Create your private workspace (./private, git-ignored) from the templates
./scripts/init.sh

# 3. Drop your CV in inputs/
cp ~/Downloads/my-cv.pdf inputs/

# 4. Open Claude Code in this folder
claude
```

Then type **`empecemos`** or **`job hunt`** (the router skill reads your state and tells you what is next). Everything under `private/` (exposed as `data/`, `inputs/` and `outputs/`) is git-ignored: your personal data never leaves your machine.

## Step by step: from zero to interviews

### First run: no CV, no data? Start here
Just type `empecemos`. With an empty workspace, `job-hunt` runs `profile-intake` in **cold start** mode: about 20-30 minutes of guided questions in themed rounds (who/where, what you want, languages, each job with metrics, projects, education, skills, gaps, form data). Rough answers are fine; unknowns stay `TODO`, nothing is invented. Raw answers are saved to `inputs/intake-answers.md`, then it writes your profile, preferences, form data and banned terms, and builds a **base CV** (`outputs/base-cv.md`, optional PDF/Word). Only then does it move on to LinkedIn, searching and applying.


| # | Step | You say | What happens | You get |
|---|------|---------|--------------|---------|
| 1 | **Build your profile** | "empecemos" / "carga mi CV" | `profile-intake` reads your CV, LinkedIn and GitHub, asks for the missing metrics (max 5 questions per round), lists honest gaps and conflicts, and fills `data/preferences.md` with you (roles, stack, salary floor, deal-breakers, language). | `data/profile.md`, `data/preferences.md` |
| 2 | **Fill form data** | "llena form-data" | You enter your name, contact data, salary asks and standard answers once. Forms reuse them. Add terms that must never appear in any document (client names, titles) to `data/banned-terms.txt`; a hook blocks them. | `data/form-data.md`, `data/banned-terms.txt` |
| 3 | **Fix LinkedIn** | "audita mi LinkedIn" | `linkedin-audit` scores your profile out of 100, rewrites headline/About/Experience/Skills using only your real facts and keywords from real vacancies. **You paste the changes**; the tool never edits your profile. | `outputs/linkedin-audit-<date>.md` |
| 4 | **Find vacancies** | "busca ofertas" | `job-discovery` searches the web and your LinkedIn (read-only, low volume), verifies each posting, removes duplicates and registers survivors in the tracker. | rows in `data/tracker.md` |
| 5 | **Score fit** | paste a job URL/text | `job-fit` returns a 0-100 score with evidence, gaps and an apply / stretch / skip / discard call. | recommendation + `vacancy.md` |
| 6 | **Tailor your CV** | "arma el CV para esta" | `cv-tailor` writes an ATS-friendly CV and a short cover letter for that vacancy and a keyword check showing honest gaps. | `outputs/<date>-<company>-<role>/` |
| 7 | **Apply** | log in to the site yourself, then "postula a estas vacantes" | `job-apply` checks the gate (authorization, vacancy still open, honest fit, hard filters, whole flow read first, no duplicates), fills the form from your data, submits, confirms the success page and logs it. | applications + tracker rows |
| 8 | **Reach out** | "redacta mensaje al recruiter" | `outreach` drafts 2 variants (direct / warmer) of connection notes, DMs, referral asks, follow-ups and thank-yous. **You send them.** | `outreach.md` |
| 9 | **Prepare interviews** | "tengo entrevista con X" | `interview-prep` builds a company brief, a plan per stage, a STAR story bank, runs a mock interview one question at a time and debriefs. | `interview-prep.md`, `data/stories.md` |
| 10 | **Review weekly** | "qué sigue" / "estado" | `tracker` shows due follow-ups, stale applications, funnel conversion and the bottleneck, plus 1-3 actions for the week. | next actions |

Suggested cadence: Monday discovery + fit, Tue-Thu tailor + outreach + apply, Friday tracker review and interview prep, monthly LinkedIn re-score.

## Traceability: never repeat, never lose track
- `data/tracker.md`: current state of every vacancy.
- `data/applications-log.md`: append-only, dated line for every submitted application (company, role, site, URL, ask, success-screen evidence).
- `data/search-log.md`: append-only, dated line for every search run (site, query, results, new vs already known).

Before each search, `job-discovery` reads all three, excludes everything already found/applied/discarded (including the same job re-published under a new URL) and varies queries from those already run, so each session surfaces only **new** vacancies. After each application or search, the matching log is written in the same turn.

## The skills in detail

All skills live in `.claude/skills/<name>/SKILL.md` and are invoked by Claude Code when your request matches (or by name).

### `job-hunt`: router
Entry point. Checks state in order (profile empty? preferences blank? LinkedIn audited? tracker stale? shortlisted without CV? interviews pending? overdue actions?) and routes to the right skill. Replies short: current state, recommended next step, the one input it needs. Never does a step's work itself.

### `profile-intake`: master profile
Reads CV (PDF/Word), LinkedIn and GitHub (read-only), extracts identity, skills (level 1-5, evidence required for 4-5), experience, projects, education and languages. Reconciles conflicts between sources instead of choosing silently, asks for the metric behind each vague bullet, records honest gaps, and fills your preferences. It is the **single source of truth**: every other skill derives from `data/profile.md`.

### `linkedin-audit`: LinkedIn rewrite
Scores 8 areas (headline, About, Experience, Skills, keyword match, Featured, completeness/settings, tone) with `rubric.md`. Builds the keyword basis from 10+ real vacancies, offers 2-3 headline variants, rewrites weak sections with `Verb + what + how + result` bullets, and gives a prioritized action list and settings checklist (custom URL, Open to Work to recruiters only...). Re-run monthly to compare scores.

### `job-discovery`: find vacancies
Builds 6-10 query variants (role x stack x remote x LATAM/worldwide/contractor), searches boards and company ATS pages, and browses LinkedIn **read-only** (max ~15 details per session, never clicks Apply/Connect/Follow). Verifies each posting (still open, real company, remote scope really includes your country, contract, salary), flags ghost-job and scam signals, dedupes against the tracker and caps a batch at ~20 verified listings.

### `job-fit`: match score
Applies hard filters first (deal-breakers, remote scope, salary floor, avoided stack), then scores must-have coverage (35), seniority (15), stack (15), logistics (15), compensation (10) and company quality (10). Gap analysis marks each gap bridgeable or blocker. Verdicts: `apply` ≥ 75, `stretch` 60-74, `skip` < 60, `discard` on a hard filter.

### `cv-tailor`: CV and cover letter per vacancy
Selects and reorders real profile facts to answer the vacancy's keywords; single-column ATS format (1 page under 8 years' experience); cover letter under 200 words; keyword-check table showing where each must-have appears and which are honest gaps (never added). Exports to .docx/.pdf. Language follows the vacancy.

### `job-apply`: submit applications
Runs only on your explicit chat order for that batch. Six-point gate (authorization, vacancy verified today, honest fit, hard filters, whole flow read first, no duplicates). Uses the site's playbook, fills from `data/form-data.md`, confirms the success screen, logs `applied` with a +7 day follow-up in the tracker. Never types credentials/IDs, creates accounts, solves CAPTCHAs or enters payment data.

### `job-sites`: per-site knowledge base
A registry (status of each site: done / partial / untested / blocked, search URLs) plus one playbook per site: Get on Board, elempleo, Computrabajo, LinkedIn, Torre, Indeed, Hireline, Remotive, Magneto365, external ATS forms, and cross-site browser-automation lessons. After you use a site, the playbook is updated so the next run is faster. Copy `playbooks/_template.md` to add a site.

### `outreach`: messages (drafts only)
Connection notes (≤ 200 chars), recruiter/hiring-manager DMs (≤ 90 words), referral asks, follow-ups (after 5-7 business days, max 2) and thank-yous (within 24h). Every message references something specific; no blasts. You copy and send.

### `interview-prep`: get ready
Company brief with sources, plan per stage (recruiter screen, technical, behavioral, hiring manager), 15-25 likely technical topics tied to your real experience, STAR story bank, one-question-at-a-time mock interview with critique, tailored questions to ask, and a post-interview debrief. Honest "I haven't done X, here's adjacent experience" answers instead of fabricated ones.

### `tracker`: pipeline
Maintains `data/tracker.md` (`found` > `shortlisted` > `prepared` > `applied` > `screen` > `interview` > `offer` | `rejected` | `ghosted` | `discarded`). Surfaces overdue actions, suggests follow-ups after 10 days, marks ghosted after 21 (asking first), shows funnel conversion and diagnoses the bottleneck (discovery? CV? pitch? interview skills?).

## Automatic hooks (`.claude/hooks/`)

| Hook | When | What it does |
|------|------|--------------|
| `session-digest.sh` | session start | Prints tracker counts, due follow-ups and missing setup files |
| `guard-banned-terms.sh` | before Write/Edit | Blocks deliverables in `outputs/` containing any term from `data/banned-terms.txt` |
| `tracker-lint.sh` | after Write/Edit | Validates tracker rows (columns, status, dates, duplicate IDs) |

## Project layout

```
CLAUDE.md                 hard rules for Claude in this project
.claude/skills/           the system (10 skills + site playbooks)
.claude/hooks/            session digest, banned-terms guard, tracker lint
templates/                blank data files to copy into data/
private/     (git-ignored) everything personal; data/ inputs/ outputs/ are symlinks into it
data/        your profile, preferences, tracker, stories, form data
inputs/      your CV and raw material
outputs/     per-vacancy CVs, letters, outreach, prep
```

## Hard rules (see `CLAUDE.md`)

1. Nothing invented or inflated; every claim traces to `data/profile.md`.
2. No sending, applying or connecting without your explicit order in chat; no credentials, accounts or CAPTCHAs.
3. LinkedIn is read-only and low volume.
4. No git commit/push without your explicit authorization at that moment.
5. Your personal data stays in this project.
6. Playbooks and tracker are updated after touching any site.
7. Banned terms never appear in deliverables.

## Responsible use

Automating job sites can conflict with their terms of service. Keep volume low, use your own logged-in session, and review every application before it goes out. You are responsible for what is submitted in your name. Playbooks reflect site UIs at the time they were written and will drift: update them when a flow changes.

## Contributing

Playbooks for new sites and markets are the most useful contribution. Copy `.claude/skills/job-sites/playbooks/_template.md`, keep it free of personal data (reference `data/form-data.md` instead of values), and add a row to `registry.md`.

## License

[MIT](LICENSE)
