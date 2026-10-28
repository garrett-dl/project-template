---
name: wiki-ingest
description: Compile a new raw source (article, paper, repo doc, dataset) from vault/raw/ into the wiki — write the source page, update concept/entity pages, flag contradictions, update index and log. Use when the user says ingest, process, file, or add a source, or drops a file into vault/raw/.
---

# Wiki ingest

Turn one raw source into durable, cross-linked wiki knowledge. Follow `vault/CLAUDE.md` for page schemas; this skill is the procedure.

## Inputs
- Path(s) under `vault/raw/`. If the user gives a URL instead, clip it first with the `defuddle` skill into `vault/raw/articles/<yyyy-mm-dd>-<slug>.md`, then ingest that file.
- Optional emphasis from the user ("focus on the auth parts").

## Procedure

1. **Orient.** Read `vault/wiki/index.md` and the last 5 log entries. Note which existing pages are likely relevant.
2. **Read the source completely.** For files with images, read the text, then view referenced images in `raw/assets/` that carry information (diagrams, tables). For PDFs, read in page ranges.
3. **Discuss before writing** (unless the user asked for batch mode). In 5–10 lines: the source's main claims, what's new relative to the wiki, anything that contradicts existing pages. Let the user steer emphasis.
4. **Source page.** Create `vault/wiki/sources/<Title>.md` per schema. Key claims must be standalone sentences someone could cite without reading the source.
5. **Propagate.** For each concept/entity the source materially informs:
   - Existing page → update. Rewrite the Overview if the picture changed; add a bullet under the relevant section; add the source to **Sources**; bump `sources` count and `updated`.
   - No page, but ≥2 sources now mention it or it's central to the project → create one.
   - Contradiction → keep both claims, mark with `> [!warning] Conflict` naming the two sources, and say which seems more current/credible if you can.
   Expect 3–15 pages touched per source. Fewer is fine for a thin source; don't pad.
6. **Index and log.** Add/update lines in `index.md` (alphabetical within group). Append a `## [date] ingest | <title>` entry to `log.md` listing pages created/updated and any conflicts flagged.
7. **Report.** Pages created, pages updated, conflicts, and 2–3 questions this source raises that the wiki can't yet answer.

## Rules
- Never modify anything under `vault/raw/`.
- Extend, don't create: search the index and `grep -ril` the wiki for the subject before making a page.
- Wikilink every mention of a page that exists. `[[Name]]` must match the file name.
- Keep frontmatter exactly to schema; Bases depends on it.
- If the source is huge (>~15k words), ingest section by section and say so in the log.
