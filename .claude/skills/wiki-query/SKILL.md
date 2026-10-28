---
name: wiki-query
description: Answer a question from the vault wiki with citations, and file answers worth keeping (comparisons, analyses, connections) back into the wiki. Use when the user asks what the wiki/notes/research says about something, asks to compare things covered in the wiki, or says "from the wiki".
---

# Wiki query

Answer from compiled knowledge, cite it, and let good answers compound.

## Procedure

1. **Index first.** Read `vault/wiki/index.md`. Pick candidate pages by title/summary. If the index is thin on the topic, also `grep -ril "<term>" vault/wiki/`.
2. **Read the candidates.** Follow wikilinks one hop if they look load-bearing. Don't read the whole wiki.
3. **Check for conflicts.** If pages carry `> [!warning] Conflict` callouts on the topic, surface the disagreement rather than picking silently.
4. **Answer.** Lead with the answer. Cite with wikilinks inline, e.g. "…rate limiting is per-tenant ([[Rate Limiting]], [[Acme API Docs]])." Distinguish what the wiki supports from what you're inferring. If the wiki can't answer, say so and suggest which sources would fill the gap (web search is allowed for suggestions, but don't ingest without asking).
5. **File if worth keeping.** Worth keeping = a comparison, an analysis that took real synthesis, or a connection between pages that wasn't explicit before. If so:
   - Comparison → `vault/wiki/comparisons/<A> vs <B>.md` (type `comparison`).
   - Analysis/connection → the most relevant concept page's **Details** or a new concept page.
   - Add to `index.md`; append `## [date] query | <question>` to `log.md` with pages read and page filed.
   When unsure whether it's worth keeping, ask in one line at the end of the answer.
6. **Format.** Prose for answers; a table when comparing ≥3 attributes; never a bare page dump.

## Rules
- Only cite pages you actually opened.
- Don't modify source pages during a query; questions don't change what a source said.
- If the question is really an issue ("should we fix X?"), answer, then offer `issue-create`.
