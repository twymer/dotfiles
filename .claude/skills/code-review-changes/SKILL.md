---
name: code-review-changes
description: Code review local changes for bugs, CLAUDE.md compliance, plan compliance, and comment quality
disable-model-invocation: true
---

Provide a code review for local changes on the current branch.

## Pre-flight Check

Before starting, ensure you are working from the repository root directory:

- Your working directory must be the repository root (where `CLAUDE.md` and `Makefile` exist)
- If unsure, run `ls CLAUDE.md Makefile` to verify you're in the correct directory

**Agent assumptions (applies to all agents and subagents):**

- All tools are functional and will work without error. Do not test tools or make exploratory calls.
- Only call a tool if it is required to complete the task. Every tool call should have a clear purpose.

**Tip:** Route permission requests to Opus via a hook — let it scan for attacks and auto-approve the safe ones (see <https://code.claude.com/docs/en/hooks#permissionrequest>)

To do this, follow these steps precisely:

1. **Gather the full changeset** by checking ALL of the following:
    - Git staged changes: `git diff --cached --stat`
    - Unstaged changes: `git diff --stat`
    - Committed changes on the current branch vs main: `git log main..HEAD --oneline` and `git diff main...HEAD --stat`

    The review must cover the **entire changeset** (all staged, unstaged, and committed changes vs main), not just changes from the current session.

    If there are no changes to review (no staged/unstaged changes and no commits ahead of main), inform the user and stop.

2. Launch a sonnet agent to view the full changeset and return a summary of what was modified. The agent should combine all changes (staged, unstaged, and committed vs main) into a unified view. Use `git diff HEAD` for uncommitted changes and `git diff main...HEAD` for committed changes. If changes exist in both, review both.

3. Launch 7 agents in parallel to independently review the changes in the discovered changeset. Each agent should return the list of issues, where each issue includes a description, file path, line number(s), and the reason it was flagged (e.g. "CLAUDE.md adherence", "bug", "plan compliance", "sloppy comment", "test coverage"). The agents should do the following:

    Agents 1 + 2: CLAUDE.md compliance Opus agents
    Audit changes for CLAUDE.md compliance in parallel. Note: When evaluating CLAUDE.md compliance for a file, you should only consider CLAUDE.md files that share a file path with the file or parents.

    Agent 3: Opus bug agent (parallel subagent with agent 4)
    Scan for obvious bugs. Focus only on the diff itself without reading extra context. Flag only significant bugs; ignore nitpicks and likely false positives. Do not flag issues that you cannot validate without looking at context outside of the git diff.

    Agent 4: Opus bug agent (parallel subagent with agent 3)
    Look for problems that exist in the introduced code. This could be security issues, incorrect logic, etc. Only look for issues that fall within the changed code.

    Agent 5: Opus plan compliance agent
    Check if any plan files have been added or modified in `.plans/` within the changeset. If a plan file exists:
    - Read the plan file to understand the intended implementation
    - Verify the changes comply with the plan (correct approach, architecture, patterns)
    - Check if all items in the plan have been completed
    - Flag any deviations from the plan or incomplete items as "plan compliance" issues
      If no plan file exists in the changeset, return no issues.

    Agent 6: Sonnet sloppy comment agent
    Scan for low-value or refactoring comments in the changed code. Flag comments that:
    - Document what was removed/moved/changed (e.g., "// Removed old implementation", "// Moved from X", "// Previously did Y")
    - Are vague or unhelpful (e.g., "// Handle this", "// Do the thing", "// Fix later")
    - State the obvious without adding clarity (e.g., "// Increment counter" above `counter++`)
    - Are TODO/FIXME comments without actionable context

    Do NOT flag comments that:
    - Explain _why_ something is done a certain way (behavioral context)
    - Clarify non-obvious logic or edge cases
    - Document API contracts, parameters, or return values
    - Are legitimate documentation (JSDoc, XML docs, docstrings)

    Comments should add long-term clarity. If the code is self-documenting, no comment is needed. Flag as "sloppy comment" issues.

    Agent 7: Opus test coverage coordinator agent
    Coordinate test coverage analysis for all changed production code using sub-agents with smart batching.

    First, identify all modified or added production files in the changeset (exclude test files, data contracts, interfaces, constants, enums, DI modules).

    Then, use the following batching strategy:
    - **≤5 production files**: Launch a single Opus sub-agent to review all files together
    - **>5 production files**: Group files by parent directory and launch one Opus sub-agent per directory batch

    This batching approach allows sub-agents to recognize shared test patterns (e.g., multiple classes tested by a single integration test file).

    Each sub-agent should:
    - Read all production files in its batch to understand public methods, code paths, and dependencies
    - Search for corresponding test files
    - Read existing test files to understand current coverage
    - Analyze what test coverage exists vs. what is needed for the changed/added code
    - Return a structured assessment with: file path, test status (missing/incomplete/adequate), specific gaps, and recommended test type

    Aggregate sub-agent results and flag issues for:
    - **Missing tests**: New production code added without corresponding tests
    - **Stale tests**: Changes to production code that invalidate existing tests (tests testing old behavior)
    - **Incomplete coverage**: Significant new code paths, branches, or error handling added without test coverage

    Do NOT flag:
    - Minor refactoring that doesn't change behavior (existing tests still valid)
    - Changes to code that already has comprehensive test coverage
    - Test files themselves

    **CRITICAL: We only want HIGH SIGNAL issues.** Flag issues where:
    - The code will fail to compile or parse (syntax errors, type errors, missing imports, unresolved references)
    - The code will definitely produce wrong results regardless of inputs (clear logic errors)
    - Clear, unambiguous CLAUDE.md violations where you can quote the exact rule being broken

    Do NOT flag:
    - Code style or quality concerns
    - Potential issues that depend on specific inputs or state
    - Subjective suggestions or improvements

    If you are not certain an issue is real, do not flag it. False positives erode trust and waste reviewer time.

    In addition to the above, each subagent should be provided with a summary of the changes for context regarding the author's intent.

4. For each issue found in the previous step by agents 3, 4, 5, 6, and 7, launch parallel subagents to validate the issue. These subagents should get the changes summary along with a description of the issue. The agent's job is to review the issue to validate that the stated issue is truly an issue with high confidence. For example, if an issue such as "variable is not defined" was flagged, the subagent's job would be to validate that is actually true in the code. Another example would be CLAUDE.md issues. The agent should validate that the CLAUDE.md rule that was violated is scoped for this file and is actually violated. For plan compliance issues, validate that the plan actually requires what was flagged and that the implementation genuinely deviates or is incomplete. For sloppy comment issues, validate that the comment genuinely lacks value and isn't providing useful behavioral context. For test coverage issues, validate that tests are genuinely missing or inadequate for the changed code. Use Opus subagents for bugs, logic issues, plan compliance, and test coverage, and sonnet agents for CLAUDE.md violations and sloppy comments.

5. Filter out any issues that were not validated in step 4. This step will give us our list of high signal issues for our review.

6. Output the review results directly:

    If NO issues were found:

    ```
    ## Code Review

    No issues found. Checked for bugs, CLAUDE.md compliance, plan compliance, comment quality, and test coverage.
    ```

    If issues were found, output a markdown table with the following columns:

    | #   | File | Line(s) | Category | Description | Suggested Fix |
    | --- | ---- | ------- | -------- | ----------- | ------------- |
    - **#**: Sequential issue number for easy referencing
    - **File**: File path
    - **Line(s)**: Line number(s)
    - **Category**: One of: bug, CLAUDE.md violation, plan compliance, sloppy comment, test coverage
    - **Description**: Brief description of the issue
    - **Suggested Fix**: For small, self-contained fixes, include the fix. For larger fixes, describe the recommended approach.

Use this list when evaluating issues in Steps 4 and 5 (these are false positives, do NOT flag):

- Pre-existing issues
- Something that appears to be a bug but is actually correct
- Pedantic nitpicks that a senior engineer would not flag
- Issues that a linter will catch (do not run the linter to verify)
- General code quality concerns (e.g., lack of test coverage, general security issues) unless explicitly required in CLAUDE.md
- Issues mentioned in CLAUDE.md but explicitly silenced in the code (e.g., via a lint ignore comment)
- Minor deviations from a plan that achieve the same goal through a reasonable alternative approach
- Plan items that are clearly optional or marked as future work
- Comments that provide genuine behavioral context even if terse
- Pre-existing comments not introduced in the changeset

Notes:

- Create a todo list before starting.
- When citing CLAUDE.md rules, quote the exact rule being violated.
- Use `git diff --cached` for staged changes or `git diff main...HEAD` for committed changes when reviewing.
