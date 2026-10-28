---
name: issue-work
description: Pick up a TaskNotes issue from vault/issues/ and drive it to done — branch, implement per the Plan, keep the issue's Notes current, record decisions as ADRs in the wiki, run tests, commit with the issue id, and close the issue with an Outcome. Use when the user says work on, start, implement, fix, or finish ISS-NNNN, or asks to do the work an issue describes.
---

# Issue work

Execute an issue end to end, leaving a trail in the issue note and the wiki.

## Preconditions
- The issue exists and has acceptance criteria. If it has no Plan, run `issue-refine` first (quickly, inline, for S-sized work).
- Load the relevant `project-*` skills and the **Commands** from `CLAUDE.md` → PROJECT before writing code.

## Procedure

1. **Start.**
   - Set `status: in-progress`. Create a branch `<type>/ISS-NNNN-<slug>` (e.g. `feat/ISS-0042-rate-limiting`); write it to `branch:`.
   - Append to **Notes**: `- YYYY-MM-DD started`.
   - Log `## [date] issue | ISS-NNNN started`.
2. **Implement** following the Plan. Small, reviewable commits: `type(scope): message (ISS-NNNN)`.
   - When you deviate from the Plan, note why under **Notes**.
   - When you make a design decision with lasting consequences (schema, API shape, library choice, trade-off), create `vault/wiki/decisions/ADR-NNNN <Title>.md` per schema (next ADR id = max + 1), link it from the issue's Notes, add to index, and log it.
   - When you learn something about the codebase that future sessions need, put it in the relevant wiki entity page (or create one) — not only in the issue.
3. **Verify.** Run the project's test/lint/build commands. Walk the acceptance criteria and tick each `- [x]` only when verified. If one can't be met, say so; don't tick it.
4. **Close.**
   - Fill **Outcome**: what shipped, how verified, links to ADRs and relevant wiki pages, anything deferred (create follow-up issues with `issue-create` and link them).
   - Set `status: review` if the user wants to look before merge, else `done`; set `completedDate`. Fill `pr:` if a PR exists.
   - Log `## [date] issue | ISS-NNNN done`.
5. **Report** in a few lines: what changed, how it was verified, open follow-ups, and the merge/PR step the user needs to take.

## Rules
- Never mark an acceptance criterion done without running the check.
- Don't push, merge, or open PRs unless asked; stopping at a committed branch is the default.
- Keep `vault/raw/` untouched; keep wiki updates to what the work actually taught you.
- If the issue turns out to be wrong or unnecessary, set `status: cancelled` with the reason in Outcome rather than forcing it through.
