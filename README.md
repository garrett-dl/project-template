# project-template

A monorepo starter that pairs application code with an embedded Obsidian vault, wired for Claude (desktop app Projects and Claude Code).

- `vault/` — Obsidian vault. `raw/` holds immutable sources, `wiki/` is a Claude-maintained knowledge base (Karpathy's [LLM Wiki](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) pattern), `issues/` is a [TaskNotes](https://tasknotes.dev) issue tracker.
- `.claude/skills/` — skills for the wiki, for issues, and for Obsidian formats (vendored from [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills)). Add `project-*` skills for your codebase.
- `CLAUDE.md` — repo-wide operating rules. `vault/CLAUDE.md` — the vault schema.
- Your code goes anywhere else (`apps/`, `packages/`, `src/`, …).

## Starting a new project from this template

1. On GitHub, mark this repo as a **template repository** and click *Use this template* (or `gh repo create my-app --template <you>/project-template --private --clone`).
2. In the new repo, keep a link to the template so you can pull improvements later:
   ```bash
   git remote add template git@github.com:<you>/project-template.git
   # later:
   git fetch template && git merge template/main
   ```
   `CLAUDE.md` is split into a template-owned top and a project-owned `## PROJECT` section to keep those merges clean.
3. Fill in `## PROJECT` in `CLAUDE.md`.
4. Add your code and any `.claude/skills/project-*/SKILL.md` files.
5. Delete or cancel `vault/issues/ISS-0001-replace-this-example-issue.md` once you have a real issue.

## Obsidian setup (once per machine)

1. **Open a vault** → choose the `vault/` folder (not the repo root).
2. Settings → Community plugins → turn off restricted mode → Browse → install **TaskNotes** → enable. (Bases core plugin is already on in `core-plugins.json`; TaskNotes v4 requires it.)
3. TaskNotes settings:
   - *Task identification*: by tag, `task` (the default).
   - *Default tasks folder*: `issues`.
   - *Statuses*: `backlog`, `todo`, `in-progress`, `review`, `done` (mark as completed), `cancelled` (mark as completed).
   - *Priorities*: `high`, `normal`, `low`.
   - *User fields*: `type` (text), `area` (text), `branch` (text), `pr` (text), `id` (text).
   - *Task creation*: template = `issues/_templates/issue.md` if you want TaskNotes' own "create task" dialog to match the schema.
   Plugin settings live in `vault/.obsidian/plugins/tasknotes/data.json`, which is committed, so step 3 only needs doing once; later clones inherit it.
4. `vault/issues/Issues.base` gives you Open / Board / Done views without TaskNotes; TaskNotes' own views live under `vault/TaskNotes/Views/`.
5. Optional: Obsidian Web Clipper, with its save folder set to `raw/articles`, for one-click source capture.

## Claude setup

**Claude desktop app (Project):** add the repo folder to the Project. Paste the "Session start" and "Operating rules" sections of `CLAUDE.md` into the Project instructions, with the line *"Read `CLAUDE.md` and the relevant `.claude/skills/<name>/SKILL.md` before starting any task."*

**Claude Code:** `cd` into the repo and run `claude`. `CLAUDE.md`, `vault/CLAUDE.md` (when working in the vault), `.claude/settings.json`, and all skills under `.claude/skills/` are picked up automatically.

**Refresh vendored Obsidian skills:** `scripts/sync-skills.sh` (optionally pass a git ref).

## Daily loop

| You say | Claude uses |
|---|---|
| "Ingest `raw/articles/foo.md`" | `wiki-ingest` |
| "What do we know about X?" | `wiki-query` |
| "Lint the wiki" | `wiki-lint` |
| "Open an issue: …" | `issue-create` |
| "Refine ISS-0007" | `issue-refine` |
| "Work on ISS-0007" | `issue-work` (+ `project-*` skills) |

Conventions (IDs, log headers, commit format) are in `CLAUDE.md`; page schemas are in `vault/CLAUDE.md`.
