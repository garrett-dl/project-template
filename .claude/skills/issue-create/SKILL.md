---
name: issue-create
description: Capture a bug, feature, chore, or spike as a TaskNotes issue note in vault/issues/ with the next sequential ISS id and schema-correct frontmatter. Use when the user says open/create/file/log an issue, ticket, bug, or task, or when work is requested that has no issue yet.
---

# Issue create

One note per issue, in `vault/issues/`, frontmatter per `vault/CLAUDE.md`. Fast capture; `issue-refine` adds depth later.

## Procedure

1. **Next ID.** Scan `vault/issues/` for `ISS-NNNN` in file names and `id:` fields; next = max + 1, zero-padded to 4. Never reuse an ID, even for cancelled issues.
2. **Dedupe.** `grep -il "<key words>" vault/issues/*.md`. If a matching open issue exists, say so and offer to update it instead.
3. **Classify.** `type`: `bug` (something is wrong), `feature` (something new), `chore` (maintenance, deps, refactor with no behavior change), `spike` (time-boxed investigation; outcome is a wiki page or a decision, not code).
4. **Write the note** from `vault/issues/_templates/issue.md`:
   - File: `vault/issues/ISS-NNNN-<slug>.md`, slug ≤5 words, kebab-case.
   - `title`: imperative and specific ("Return 429 with Retry-After on rate limit", not "Rate limiting").
   - `status`: `backlog` unless the user wants it now (`todo`).
   - `priority`: `normal` unless stated. `area`: pick from the PROJECT section of `CLAUDE.md` if it lists areas.
   - `created`: today. `tags: [task]` always.
   - **Context**: 2–5 sentences. Link relevant wiki pages with `[[wikilinks]]`. For bugs: observed vs expected, repro steps if known.
   - **Acceptance criteria**: 1–5 checkboxes, each testable.
   - Leave Plan / Notes / Outcome headings present but empty.
5. **Log.** Append `## [date] issue | ISS-NNNN created` to `vault/wiki/log.md` with the title.
6. **Reply** with the ID, title, and file path in one line. Don't paste the whole note back.

## Rules
- Frontmatter keys exactly as in the template; TaskNotes and `Issues.base` read them.
- Dates ISO. Empty fields stay present and empty, not deleted.
- Don't start implementing; that's `issue-work`.
