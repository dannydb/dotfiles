---
name: triage-copilot-review
description: Review and resolve GitHub Copilot PR review comments on the current branch's PR. Use when the user wants to triage Copilot's automated code review.
disable-model-invocation: true
---

## Current State

- Branch: !`git branch --show-current`

## Instructions

You are triaging GitHub Copilot's automated code review on the current branch's PR. Work through each comment one at a time, presenting your assessment and letting the user decide what to do.

### Step 1: Find the PR and Copilot's review

1. Use `gh pr view --json number,url` to get the PR number for the current branch.
2. Use `gh api repos/{owner}/{repo}/pulls/{pr_number}/reviews` to list all reviews.
3. Find the review(s) from Copilot (the user login will be `copilot[bot]`, `Copilot`, or `copilot-pull-request-reviewer[bot]`). Note the `id` of Copilot's review.
4. Use `gh api repos/{owner}/{repo}/pulls/{pr_number}/comments` to get all review comments, filtering for those from Copilot (check for `Copilot`, `copilot[bot]`, or `copilot-pull-request-reviewer[bot]` logins).
5. Fetch review thread IDs via GraphQL for resolving threads later:
   ```
   gh api graphql -f query='query {
     repository(owner: "{owner}", name: "{repo}") {
       pullRequest(number: {pr_number}) {
         reviewThreads(first: 50) {
           nodes {
             id
             isResolved
             comments(first: 1) {
               nodes { author { login } body }
             }
           }
         }
       }
     }
   }'
   ```
   Save the `id` (PRRT\_...) for each Copilot thread — these are needed to resolve threads.

### Step 2: For each Copilot comment

For each comment from Copilot:

1. **Read the relevant code** around the file and line mentioned in the comment (`path` and `line`/`original_line` fields).
2. **Assess the comment**: Is Copilot's suggestion valid, actionable, and correct? Or does it misunderstand context, suggest something unnecessary, or conflict with project conventions?
3. **Present your assessment** to the user:
   - Show the file and line(s) the comment refers to
   - Show Copilot's comment text
   - Give your assessment: agree, disagree, or partially agree
   - If you agree, propose a specific fix
   - If you disagree, explain why
4. **Wait for the user's decision** before proceeding.

### Step 3: Act on the user's decision

**If the user decides to do nothing:**

1. Reply to the comment thread: `gh api repos/{owner}/{repo}/pulls/{pr_number}/comments/{comment_id}/replies -f body="No action needed."` (use POST method)
2. Resolve the thread using the `resolveReviewThread` GraphQL mutation with the thread ID (PRRT\_...) from Step 1:
   ```
   gh api graphql -f query='mutation { resolveReviewThread(input: {threadId: "<thread_id>"}) { thread { isResolved } } }'
   ```
   **If the user decides to address it:**
3. Make the code change.
4. Run linters/tests on affected files per the pre-commit checks in CLAUDE.md.
5. Create a commit and push it.
6. Reply to the comment thread: `gh api repos/{owner}/{repo}/pulls/{pr_number}/comments/{comment_id}/replies -f body="Addressed in <commit_sha>"` (use POST method)
7. Resolve the thread using the same `resolveReviewThread` mutation above.

### Step 4: After all comments are resolved

Once every comment has been handled, dismiss Copilot's overall review:
Use `gh api repos/{owner}/{repo}/pulls/{pr_number}/reviews/{review_id}/dismissals -f event=DISMISS -f message="Resolved"` to dismiss the review.

### Important Notes

- The `{owner}/{repo}` can be derived from `gh repo view --json nameWithOwner -q .nameWithOwner`.
- Comment `node_id` fields are needed for GraphQL mutations — these are returned in the REST API responses.
- Always present one comment at a time and wait for user input before proceeding to the next.
- Follow the project's pre-commit checks (rubocop, yarn lint, rspec, yarn test) before committing any changes.
