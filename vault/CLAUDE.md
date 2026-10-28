# Vault schema

This file is the "schema" layer of the LLM-wiki pattern: it defines how the vault is structured and how Claude maintains it. Co-evolve it as the project teaches you what works. Root `CLAUDE.md` holds repo-wide rules; this file governs everything under `vault/`.

Open **this folder** (`vault/`) in Obsidian, not the repo root.

## Layout

```
vault/
├── raw/            # Layer 1 — immutable sources. READ ONLY.
│   ├── articles/   # clipped web pages (Obsidian Web Clipper / defuddle)
│   ├── papers/     # PDFs, preprints
│   ├── repos/      # README/doc snapshots of external code
│   ├── data/       # CSV/JSON datasets
│   └── assets/     # images; Obsidian attachment folder points here
├── wiki/           # Layer 2 — Claude-maintained compiled knowledge
│   ├── index.md    # catalog of every page, by category
│   ├── log.md      # append-only chronological record
│   ├── sources/    # one page per raw source (summary + key claims)
│   ├── concepts/   # ideas, techniques, patterns
│   ├── entities/   # libraries, services, people, products, APIs
│   ├── comparisons/# X vs Y analyses, usually filed from queries
│   └── decisions/  # ADR-style records linked from issues
├── issues/         # TaskNotes notes, one per issue
│   └── _templates/ # issue template(s)
└── TaskNotes/      # created by the plugin; holds its .base views
```

## Page types and frontmatter

All wiki pages have frontmatter. Keep it minimal and consistent so Bases can query it.

### Source page (`wiki/sources/<Title>.md`)
```yaml
---
type: source
title: <human title>
raw: "[[raw/articles/<file>]]"     # wikilink to the raw file
author:
published: YYYY-MM-DD
ingested: YYYY-MM-DD
tags: [source]
---
```
Body: **Summary** (3–8 sentences) → **Key claims** (bulleted, each a standalone sentence) → **Relevance to project** → **Links** (every concept/entity page touched).

### Concept page (`wiki/concepts/<Name>.md`) and Entity page (`wiki/entities/<Name>.md`)
```yaml
---
type: concept        # or entity
title: <Name>
aliases: []
sources: 3           # count of source pages citing this
updated: YYYY-MM-DD
tags: [concept]      # or [entity]
---
```
Body: **Overview** → **Details** (sections as needed) → **Open questions** → **Sources** (wikilinks to source pages). Rewrite the Overview when new sources change the picture; don't just append.

### Comparison page (`wiki/comparisons/<A> vs <B>.md`)
Same frontmatter as concept with `type: comparison`. Body is a table plus a verdict section. Usually created by `wiki-query` from a question worth keeping.

### Decision page (`wiki/decisions/ADR-NNNN <Title>.md`)
```yaml
---
type: decision
id: ADR-0001
title: <Title>
status: proposed | accepted | superseded
date: YYYY-MM-DD
issue: "[[ISS-0042-slug]]"
supersedes:
tags: [decision]
---
```
Body: **Context** → **Decision** → **Consequences** → **Alternatives considered**.

## index.md

One line per page, grouped under `## Sources`, `## Concepts`, `## Entities`, `## Comparisons`, `## Decisions`:

```
- [[Page Name]] — one-line summary (updated YYYY-MM-DD)
```

Update on every ingest, query that files a page, lint that creates/merges pages, and decision. When answering a question, read `index.md` first, then open only the pages that matter.

## log.md

Append-only. Each entry starts with a grep-able header:

```
## [YYYY-MM-DD] ingest | <source title>
## [YYYY-MM-DD] query | <question, abbreviated>
## [YYYY-MM-DD] lint | <scope>
## [YYYY-MM-DD] issue | ISS-NNNN <created|refined|started|done>
## [YYYY-MM-DD] decision | ADR-NNNN <title>
```

followed by 1–5 lines: what was read, which pages were created/updated, anything notable. `grep "^## \[" wiki/log.md | tail -5` shows recent activity.

## Operations

### Ingest (skill: `wiki-ingest`)
1. Read the raw file fully. Images: read text first, then view referenced images separately.
2. Check `index.md` for existing pages on the same subject. **Extend, don't duplicate.**
3. Write/update the source page.
4. Update every concept/entity page the source touches (typically 3–15). Rewrite overviews; flag contradictions with a `> [!warning] Conflict` callout naming both sources.
5. Create new concept/entity pages only for things mentioned by ≥2 sources or central to this project.
6. Update `index.md`; append to `log.md`.
7. Report back: what changed, what contradicts prior knowledge, what questions the source raises.

### Query (skill: `wiki-query`)
1. Read `index.md`; pick candidate pages; read them.
2. Answer with wikilink citations to the pages used.
3. If the answer is a synthesis worth keeping (comparison, analysis, newly discovered connection), file it as a page and log it. Ask first if unsure whether it's worth keeping.

### Lint (skill: `wiki-lint`)
Check for: contradictions between pages; claims superseded by newer sources; orphan pages (no inbound links); concepts mentioned on ≥3 pages without their own page; near-duplicate pages; source pages missing from index; broken wikilinks. Fix mechanical problems directly; propose content changes before making them.

## Issues (`issues/`)

Each issue is a TaskNotes task: one note, YAML frontmatter is the machine layer, body is the human layer.

```yaml
---
tags: [task]                 # TaskNotes identifies tasks by this tag (default setting)
id: ISS-0001
title: <imperative, specific>
type: bug | feature | chore | spike
status: backlog | todo | in-progress | review | done | cancelled
priority: high | normal | low
area: <api | web | infra | docs | ...>
due:
scheduled:
projects: []                 # optional wikilinks to wiki pages or epics
contexts: []
branch:                      # set by issue-work
pr:
created: YYYY-MM-DD
completedDate:
---
```

Body headings, in order: **Context**, **Acceptance criteria** (checkboxes), **Plan** (added by `issue-refine`), **Notes** (running log while working), **Outcome** (filled on close; link any ADR).

File name: `issues/ISS-NNNN-short-slug.md`. Next ID = highest existing + 1 (scan `issues/`; never reuse). Statuses, priorities, and custom fields (`type`, `area`, `branch`, `pr`) must be configured in TaskNotes settings to show in its UI; see `README.md` → "Obsidian setup".

## Style

- Obsidian Flavored Markdown (`obsidian-markdown` skill). Wikilinks for every internal reference.
- Prose is tight; bullets for claims; tables for comparisons.
- Dates ISO `YYYY-MM-DD`. No dates in page names.
- Never silently overwrite a claim; note the change and the source.
