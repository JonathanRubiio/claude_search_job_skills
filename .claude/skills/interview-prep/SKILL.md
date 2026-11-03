---
name: interview-prep
description: Prepare for recruiter screens, technical and behavioral interviews for a specific vacancy, build the STAR story bank, run mock interviews and debrief. Use when a process reaches screen/interview stage or the user wants practice.
---

# interview-prep

Inputs: vacancy folder, `data/profile.md`, `data/stories.md`, tracker row (stage).

## Steps
1. **Company brief**: product, customers, stack, recent news, interview process (search web; Glassdoor-style reports if available). Note sources and uncertainty.
2. **Stage plan** by stage:
   - *Recruiter screen*: 60-second pitch, why this company/role, salary answer strategy (give range in USD anchored to target, contractor vs employee, ask their band first when appropriate), availability, timezone, English level proof.
   - *Technical*: from the vacancy stack, list the 15-25 likeliest topics and questions (language internals, system design at the right seniority, API design, databases, testing, cloud/CI, concurrency). For each: concise answer outline, tied to the user's real experience. Coding practice: suggest 5 problems at the right difficulty by pattern.
   - *Behavioral*: map 6-8 competencies the company values to stories.
   - *Hiring manager / final*: questions that probe the team (ownership, on-call, roadmap, how success is measured).
3. **STAR bank**: pull real events from `profile.md` into `data/stories.md` using its template; ask for missing specifics. Each story gets 2-3 competency tags and a 90-second spoken version.
4. **Mock interview**: ask one question at a time, wait for the user's answer, then critique (structure, specificity, metrics, length, English clarity) and give an improved version. Track weak topics in the prep file.
5. **Questions to ask them**: 6-8 tailored questions.
6. **Debrief** after each real interview: what was asked, what went well/poorly, follow-up promised, update tracker (`screen` -> `interview` ...), draft thank-you via `outreach`.
7. Save to `outputs/<date>-<company>-<role>/interview-prep.md`.

## Rules
- Stories and answers must be true; never script fabricated experience. If the user lacks something, prepare an honest "I haven't done X, here's adjacent experience and how I'd learn it".
- Calibrate technical depth to the stated seniority.
