---
name: wiki-lint
description: Health-check the vault wiki — find contradictions, stale claims, orphan pages, missing pages, near-duplicates, index drift, and broken wikilinks; fix mechanical issues and propose content fixes. Use when the user says lint, audit, clean up, or health-check the wiki, or periodically after several ingests.
---

# Wiki lint

Keep the wiki trustworthy as it grows. Mechanical problems get fixed; content problems get proposed.

## Checks

Run all unless the user scopes it (e.g. "lint concepts only").

| # | Check | How | Action |
|---|-------|-----|--------|
| 1 | Index drift | Every `.md` under `wiki/{sources,concepts,entities,comparisons,decisions}` has an index line, and every index line points at an existing file | Fix directly |
| 2 | Broken wikilinks | `grep -oh "\[\[[^]|#]*" vault/wiki -r` → strip `[[` → check file exists (also check `aliases`) | Fix if obvious target; else list |
| 3 | Orphans | Pages with zero inbound `[[links]]` from other wiki pages (index doesn't count) | List; propose where to link from |
| 4 | Missing pages | Terms wikilinked or capitalized consistently on ≥3 pages that have no page | Propose; create only if user agrees |
| 5 | Near-duplicates | Two pages whose titles/aliases/overviews describe the same thing | Propose merge; on approval merge, leave the loser as a one-line redirect page with `aliases`, update links |
| 6 | Contradictions | Claims on different pages that can't both be true; existing `Conflict` callouts still unresolved | List with both sources; propose resolution if a newer source settles it |
| 7 | Stale claims | Claims dated/sourced before a newer source on the same topic that says otherwise | Propose update |
| 8 | Frontmatter | Required keys present, `type` matches folder, `updated`/`ingested` are ISO dates, `sources` count matches the Sources section | Fix directly |
| 9 | Thin pages | Concept/entity pages with <3 sentences of overview | List |
| 10 | Issues ↔ decisions | Every `done` issue with design decisions in Notes has an ADR; every ADR links back to an issue | List |

## Procedure
1. Run checks 1, 2, 8 mechanically (shell is fine) and fix.
2. Read the index and skim pages for checks 3–7, 9, 10.
3. Write a short report: fixed / proposed / questions worth investigating next (the wiki is good at surfacing what you don't know yet).
4. Apply approved proposals.
5. Append `## [date] lint | <scope>` to `log.md` with counts fixed and proposals outstanding.

## Rules
- Never delete a page without asking; merge instead.
- Never touch `vault/raw/`.
- Don't "improve" prose that isn't wrong; lint is for correctness and connectivity.
