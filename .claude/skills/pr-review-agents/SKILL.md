---
name: pr-review-agents
description: Deep adversarial code review on one or more PRs using parallel subagents. Use when the user provides PR URLs and asks for in-depth review, multi-agent review, adversarial review, or "review these PRs". Each PR gets 3 parallel agents (security, code quality, clarity+ticket alignment), results are synthesized into a cross-PR table, and approvals/change-requests are drafted before submission.
---

# PR Review Agents

Run in-depth, adversarial code reviews on one or more PRs by spinning up 3 parallel subagents per PR. Synthesize the findings, show the user, draft review decisions, and submit only after confirmation.

## When to use

- User pastes one or more PR URLs and asks to review them in depth.
- User asks for "adversarial", "multi-agent", "deep", or "thorough" PR review.
- User wants an assessment across security, code quality, readability, and ticket alignment.

Do NOT use for a single quick review — use the existing `review` skill for that.

## Steps

### 1. Collect the PR list

Identify every PR URL in the user's message. For each, extract `owner/repo` and PR number.

### 2. Launch 3 agents per PR, all in parallel

In a **single message** emit one `Agent` tool call per (PR × rubric). For N PRs that's 3N parallel agents, all `run_in_background: true` and `subagent_type: general-purpose`.

The three rubrics per PR:

**A. Security reviewer** — adversarial; find real vulnerabilities. Tailor the threat list to the service type:
- IAM / auth service → token issuance, signature verification, privilege escalation, OAuth/OIDC flows, session fixation, credential hashing
- Session service → session ID entropy, cookie flags, logout invalidation, replay, cross-tenant contamination
- Video / media service → upload validation, path traversal, ffmpeg shell injection, zip/decompression bombs, SSRF, signed URLs, PHI in filenames
- Web frontend → XSS (`dangerouslySetInnerHTML`, `v-html`, `innerHTML`), CSRF, open redirect, CSP/CORS regressions, tokens in localStorage, secrets in bundle
- Generic backend → authn/authz gaps, IDOR, SQL injection, input validation, secrets in logs, PII/PHI leakage, crypto misuse, deserialization, SSRF, path traversal, race conditions, rate limits, vulnerable deps

**B. Code quality / design reviewer** — correctness, design, tests, performance, hygiene. Look for: null handling, error paths, transaction scope, async/await misuse, layering, coupling, abstractions that fit (or don't), duplication, test coverage (meaningful vs tautological, mocked vs integration), N+1 queries, unbounded loops, dead code, leftover debug, breaking changes, migration safety.

**C. Clarity + ticket alignment reviewer** — does the code meet every acceptance criterion on the linked Jira ticket? Checklist each AC as met / partial / missed. Evaluate scope creep or scope gap, naming clarity, comment quality (non-obvious WHY only — no WHAT comments), PR description quality, commit hygiene.

### 3. Agent prompt template

Each agent prompt must include:

- The exact PR URL.
- Step-by-step: `gh pr view <repo>/<num> --json title,body,files,commits`, `gh pr diff <repo>/<num>`, fetch Jira ticket via `mcp__f48068ea-5005-4f3e-9171-03180ebb7424__getJiraIssue` (use `getAccessibleAtlassianResources` first for cloudId) if a ticket ID appears in the title/body, clone to `/tmp/<repo>` + `gh pr checkout <num>` if surrounding code context is needed.
- The rubric (A/B/C above, tailored).
- Required report structure:
  - `## PR summary` (2-3 sentences)
  - `## Findings` with severity + `file:line` + concrete issue + fix for each
  - For rubric C: `## Ticket: <KEY> — <title>` with an AC checklist
  - `## Verdict` (SHIP / SHIP with caveats / BLOCK, or APPROVE / REQUEST CHANGES / COMMENT)
- Word cap (700-800 words).
- Tell the agent to be adversarial, not agreeable. Findings must be specific (file:line), not hand-waving.

### 4. Wait and synthesize

Wait for every agent to complete (background notifications). When all are done, produce a single cross-PR synthesis:

- One-line per-PR verdict table: `| PR | Ticket | Verdict | Notable nits |`
- Themes across PRs: what's good, recurring nits, governance items worth a follow-up ticket.
- Don't paste every agent's full report — distill.

### 5. Draft review decisions BEFORE submitting

Per the user's standing preference (see `feedback_pr_review_draft.md`), ALWAYS show a draft plan first:

- For each PR: the verdict (approve / request changes / comment) and the exact review body text (or "no body").
- Ask for confirmation.

### 6. Submit after confirmation

Use `gh pr review <num> --repo <owner>/<repo> --approve|--request-changes|--comment [--body "..."]`.

Important: when invoked outside a git working directory, `gh pr review <owner>/<repo>/<num>` fails with `not a git repository`. Always use the `<num> --repo <owner>/<repo>` form.

Submit all reviews in a single parallel batch.

## Pitfalls

- **Don't read agent transcript output files.** The background notifications contain the summaries. Reading the raw JSONL transcripts overflows context.
- **Don't skip the draft step.** Even for unanimous approvals, show the draft before running `gh pr review`.
- **Don't generalize nits across unrelated PRs.** A comment should only land on PRs it actually applies to — e.g. a Node-version pin nit only goes on PRs that add the Node devcontainer feature.
- **Respect `feedback_no_dependabot.md`** — if a PR in the list is from dependabot, skip it unless the user explicitly asked.
