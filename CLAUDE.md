# CLAUDE.md

<!-- ===================== TEMPLATE-OWNED (merge-safe) =====================
     Everything above the PROJECT marker comes from the template repo.
     Keep edits here generic so `git merge template/main` stays clean.
     Project-specific instructions go in the PROJECT section at the bottom.
     ======================================================================= -->

## What this repo is

A monorepo with two halves that share one git history:

| Path        | Owner  | Purpose |
|-------------|--------|---------|
| `vault/`    | Claude writes, human reads | Obsidian vault: research wiki (`raw/` → `wiki/`) and issue tracker (`issues/`). |
| everything else | human + Claude | Application source code, config, scripts. |

`vault/CLAUDE.md` is the **schema** for the vault (page types, frontmatter, ingest/query/lint rules). Read it before touching anything under `vault/`. This file stays short and points elsewhere.

## Skills (`.claude/skills/`)

Use the skill whose description matches the task. If skills are not auto-loaded in the current client, read `.claude/skills/<name>/SKILL.md` first, then do the task.

| Skill | Use when |
|-------|----------|
| `wiki-ingest` | A new source lands in `vault/raw/` and needs compiling into the wiki. |
| `wiki-query` | Answering a question from the wiki; filing good answers back as pages. |
| `wiki-lint` | Periodic health check: contradictions, orphans, stale claims, gaps. |
| `issue-create` | Capturing a bug/feature/chore/spike as a TaskNotes issue. |
| `issue-refine` | Turning a rough issue into one with context, acceptance criteria, and a plan. |
| `issue-work` | Picking up an issue, implementing it, closing the loop. |
| `obsidian-markdown` | Any `.md` under `vault/` (wikilinks, callouts, properties). |
| `obsidian-bases` | `.base` views, including TaskNotes views and custom issue boards. |
| `obsidian-cli` | Vault operations via the Obsidian CLI (needs Obsidian running). |
| `json-canvas` | `.canvas` diagrams in the vault. |
| `defuddle` | Clipping a web page into `vault/raw/articles/`. |
| `knap` | Batch-generating notes from templates + structured data. |
| `project-*` | Project-specific conventions (see PROJECT section). |

`obsidian-*`, `json-canvas`, `defuddle`, `knap` are vendored from kepano/obsidian-skills (MIT). Refresh with `scripts/sync-skills.sh`; don't hand-edit them.

## Operating rules

1. **`vault/raw/` is immutable.** Read it; never modify or delete files there. Add new sources by copying in, not editing.
2. **Every wiki write updates `vault/wiki/index.md` and appends to `vault/wiki/log.md`.** No exceptions; the index is how you find things next session.
3. **Issues are the unit of work.** Non-trivial code changes start from an issue in `vault/issues/` (create one with `issue-create` if it doesn't exist). Reference the issue ID in commit messages: `feat(api): add rate limiting (ISS-0042)`.
4. **Decisions get a page.** When a design decision is made while working an issue, record it in `vault/wiki/decisions/` and link it from the issue.
5. **Check the index before creating a wiki page.** Extend an existing page rather than making a near-duplicate.
6. **Obsidian-flavored Markdown everywhere under `vault/`.** `[[wikilinks]]`, YAML frontmatter, callouts. Follow `obsidian-markdown`.
7. **Don't touch `vault/.obsidian/workspace*.json`** or other per-machine Obsidian state; it's gitignored for a reason.

## Session start

1. Skim `vault/wiki/index.md` and the last ~5 entries of `vault/wiki/log.md` (`grep "^## \[" vault/wiki/log.md | tail -5`).
2. If asked to work on code, list open issues: notes in `vault/issues/` whose `status` is not `done`/`cancelled`.
3. Then proceed.

## Conventions

- Issue IDs: `ISS-NNNN` (zero-padded, sequential). File name `vault/issues/ISS-NNNN-short-slug.md`. Next ID = highest existing + 1.
- Wiki page names: Title Case, descriptive, no dates in the name (dates go in frontmatter).
- Log entries: `## [YYYY-MM-DD] <op> | <subject>` where `<op>` is `ingest`, `query`, `lint`, `issue`, or `decision`.
- Commits: Conventional Commits, scope = package or area, issue ID in parentheses at the end.

<!-- ===================== PROJECT-OWNED (edit freely) ===================== -->

## PROJECT

<!-- Fill in after forking. Suggested headings: -->

### Overview
<!-- One paragraph: what this project is, who it's for. -->

### Stack & layout
<!-- e.g. apps/api (NestJS), apps/web (Next.js + TanStack Query), packages/shared -->

### Commands
<!-- install / dev / test / lint / build — the exact commands Claude should run. -->

### Project skills
<!-- List `.claude/skills/project-*` here with one line each. -->

### Gotchas
<!-- Things that bit you. Keep it current. -->
