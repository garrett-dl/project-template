---
name: issue-refine
description: Turn a rough issue in vault/issues/ into a ready-to-work one — sharpen the title and acceptance criteria, research context in the wiki and codebase, write a concrete Plan, surface risks and open questions, and split if too big. Use when the user says refine, groom, flesh out, spec, or plan an issue, or before starting work on a thin issue.
---

# Issue refine

Make the issue precise enough that `issue-work` can execute it without re-deriving intent.

## Procedure

1. **Read** the issue note, `vault/wiki/index.md`, and any wiki pages the issue links. Then look at the code the issue touches (grep for the feature/module; read the entry points). Load any `project-*` skill relevant to that area.
2. **Sharpen.**
   - Title: imperative, specific, one outcome.
   - Context: add what you learned from the wiki/code; wikilink pages; cite file paths with backticks.
   - Acceptance criteria: each one observable and testable; add missing edge cases; remove vague ones.
3. **Plan** (replace the empty section):
   - Approach in 2–6 bullets.
   - Files to touch, grouped by package.
   - Tests to add or change.
   - Risks / unknowns, each with how to resolve (spike, question for user, check a source).
   - Rough size: S (<1h), M (half day), L (day+). If L, propose a split into child issues (create them with `issue-create`; link them under Plan; parent gets `type: feature` and children reference `projects: ["[[ISS-NNNN-parent]]"]`).
4. **Decisions needed?** If the plan hinges on a choice the user should make, list the options with a recommendation and **stop**; don't guess on irreversible choices.
5. **Status.** Move `backlog` → `todo` when the issue is ready. Set `priority`/`scheduled` if the user indicates urgency.
6. **Log** `## [date] issue | ISS-NNNN refined` with size and whether it was split.
7. **Reply** with: title, size, the plan in brief, and any decisions or questions. Keep it scannable.

## Rules
- Edit the issue in place; keep headings in order.
- Research the wiki before the web. If the wiki is silent on something important, say so and offer `wiki-ingest` for a source.
- Don't write code during refinement.
