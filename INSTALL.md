# Installing the kit

How to wire this kit into a product workspace as an **updatable dependency** (git clone with upstream), while product memory lives in a **separate** `agent-knowledge` repo.

**Preferred path:** clone this repo, add it to the Cursor workspace, then `/ask-install`. Later: `/ask-update` after pulling new kit versions.

## Mental model

```text
workspace/
  <kit-directory>/           ← user-chosen (keep .git + origin upstream)
  <agent-knowledge-dir>/     ← user-chosen (NEW product git repo)
  <cursor-home>/.cursor/     ← user-chosen (default: parent of agent-knowledge)
  repo-api/ …
```

| Piece | Role | Git |
|-------|------|-----|
| **Kit directory** | Canonical process engine | Keep `.git`; upstream kit remote. **Do not** `rm -rf .git`. Path chosen at `/ask-install`. |
| **Product `.cursor/` home** | Merged rules/skills + overlays | Your hub/product repo or as you prefer |
| **agent-knowledge directory** | Global + per-user memory | **New** repo at the path chosen at install; product remote — not the kit remote. |

Does not include stack skills (framework, testing, DB) or `speckit-*`; those are added per project under product `.cursor/skills/` with the `ask-` prefix when user-facing.

**Naming:** all kit **skills** and **rules** use an `ask-` segment in their names (skills: `ask-*`; rules: `ask-*.mdc`) to avoid colliding with other Cursor rules/skills in the product workspace.

## What `/ask-install` does

1. Leaves the **kit clone** intact (updatable dependency).
2. Merges kit `.cursor/rules` + `.cursor/skills` into **product home** (safe merge).
3. Instantiates **`agent-knowledge/`** as a **new** git repository (own history/remote).
4. Fills product placeholders and per-user `preferences.yaml`.
5. **Offers** a full-workspace documentation scan (user must authorize) → `/ask-centralize-docs`: copy into agent-knowledge, then **recommend** deleting originals.

## What `/ask-centralize-docs` does

1. Asks permission to scan **all** workspace sibling folders.
2. Lists documentation candidates and proposed `knowledge/` destinations.
3. **Copies** approved files into agent-knowledge; writes `knowledge/imported/IMPORT-MAP.md`.
4. **Recommends** removing or stubbing originals; deletes only with explicit confirmation.

Does **not** run without authorization. Does **not** delete originals during the copy step.

## What `/ask-update` does

1. `git fetch` / `git pull` in the **kit clone** (or report if dirty/conflicts).
2. Re-merges kit `.cursor/` → product home **without** overwriting product overlays or stack skills (brings new skills such as `ask-centralize-docs`).
3. Does **not** reset or replace `agent-knowledge/` content (memory stays put). Optionally copies **new** template files that are missing only (never overwrite existing knowledge files).
4. **Offers** the same gated documentation scan as install (`/ask-centralize-docs`) so already-installed workspaces can opt in without reinstalling. Never scans without asking.

## Human setup (once)

1. **Clone or place the kit** where you want it (or let `/ask-install` clone into a path you choose).
2. **Add folders** to the Cursor workspace as needed.
3. Run **`/ask-install`** — it **asks** for kit directory, agent-knowledge directory, and product `.cursor/` home.
4. Later: `git pull` in the kit directory + **`/ask-update`**.

## Order when also using ai-dev-standard

1. **ai-dev-standard first** — `ADOPTION.md` in that repo.
2. **This kit after** — `/ask-install`; link the standard from `agent-knowledge` or product docs.

## Language configuration

| Layer | Where | Default |
|-------|-------|---------|
| Durable agent-written content | `agent-knowledge/config.yaml` → `locale.content` | `en` |
| Paths / identifiers | `locale.paths` | `en` |
| Chat with this user | `users/<email>/preferences.yaml` → `communication_language` | `en` if missing |

---

## Agent contract — install (`/ask-install`) (MUST)

### Preconditions

1. User will choose **directories** for the kit clone and for `agent-knowledge` (see Q&A). Do not assume paths.
2. Only clone the kit yourself if the user gave a URL **or** confirmed the default upstream and a target directory.
3. Kit must retain its `.git` and upstream `origin` (dependency). Never delete kit `.git` during install.
4. `agent-knowledge` must **not** be created inside the kit clone directory.

### Q&A (MUST ask directories unless already answered in this session)

Ask for directories (prefer one question per turn, or a short block of independent paths):

| # | Ask | Notes |
|---|-----|--------|
| 1 | **Kit directory** — absolute or workspace-relative path where the `agent-starter-kit` clone should live (or already lives) | If the folder is empty/missing: clone upstream there. If it already is a kit root (`INSTALL.md` present): use it. Never `rm -rf .git` on that clone. |
| 2 | **agent-knowledge directory** — path where the product memory repo should live | Must be outside the kit directory. If missing: copy `agent-knowledge-template/` here and `git init`. If it already exists with data: do not wipe; ask before any merge. |
| 3 | **Product `.cursor/` home** — directory that should receive the merged `.cursor/rules` and `.cursor/skills` | Default if skipped: **parent directory of agent-knowledge**. Must not be the kit directory itself. |
| 4 | Product / project name (for `ask-project.mdc`) | Default: name of product `.cursor/` home folder |
| 5 | Sibling app repos in the workspace | Default: empty |
| 6 | `communication_language` | Default: `en` |

Cap: if too many unknowns, ask paths **1–3 first** (blocking), then the rest. Summary of all chosen paths → user **yes** before writing.

### Install steps (after yes)

1. **Ensure kit at kit directory:** clone if needed; verify `INSTALL.md` + `agent-knowledge-template/`; keep `.git` + upstream.
2. Inventory product `.cursor/` home.
3. Merge kit `.cursor/` → product `.cursor/` home (safe merge; no blind overwrite). Record **kit directory** and **agent-knowledge directory** in `ask-project.mdc` (or `ask-kit-paths.mdc`) for `/ask-update`. **Always install/update** rule `ask-route-via-ask-question.mdc` and skill `ask-question` (process-critical — default triage). Do **not** keep the session backlog under `.cursor/` (SoT is agent-knowledge).
4. Instantiate **agent-knowledge** at the chosen path (new git repo; product remote later; user + prefs). Ensure `users/<email>/session-backlog.md` exists (per-user session backlog for `/ask-backlog`).
5. Fill `ask-project.mdc`; fix pointers so they resolve to the chosen agent-knowledge path (update `ask-agent-knowledge.mdc` / `ask-agent-knowledge` skill as needed). Migrate Open items from legacy `.cursor/out-of-scope.md` or `knowledge/delivery/out-of-scope.md` into the user’s `session-backlog.md`.
6. **Documentation centralization (gated):** ask whether to scan the **entire multi-repo workspace** for docs. If **no**, skip. If **yes**, run `.cursor/skills/ask-centralize-docs/SKILL.md` (copy into agent-knowledge → recommend cleanup of originals). Always install/update the `ask-centralize-docs` skill with the kit merge.
7. No commit/push unless asked.
8. Close: echo the three paths (kit / agent-knowledge / `.cursor` home); note whether docs were centralized; `/ask-requirement`, `/ask-backlog`, `/ask-update`, `/ask-centralize-docs`.

### MUST NOT

- Assume `./agent-knowledge` or “next to the kit” without asking.
- `rm -rf` the kit’s `.git` or re-init the kit as the product remote.
- Put global/per-user memory inside the kit clone.
- Overwrite product stack rules/skills without explicit ask.
- Use the kit directory as the product `.cursor/` home.

### Done when

- [ ] User-confirmed kit directory has upstream git
- [ ] User-confirmed agent-knowledge directory is its own git repo with prefs
- [ ] User-confirmed product `.cursor/` home has merged rules/skills
- [ ] Paths recorded for `/ask-update`
- [ ] User was offered workspace doc scan (`/ask-centralize-docs`); if accepted, IMPORT-MAP updated and cleanup recommended

---

## Agent contract — update (`/ask-update`) (MUST)

### Preconditions

1. Resolve **kit directory** and **product `.cursor/` home** (from recorded install paths, or ask).
2. Optionally confirm **agent-knowledge directory** (only to avoid touching it — do not overwrite).
3. User asked to update / ran `/ask-update`.

### Steps

1. In **kit directory**: `git status`. If dirty, warn and ask before pull.
2. `git pull` (or fetch + merge/rebase per user preference; default pull).
3. Re-merge kit `.cursor/rules` + `skills` → product `.cursor/` home with the **same merge policy as install**. Ensure `ask-route-via-ask-question.mdc`, `ask-question`, and `ask-centralize-docs` are present. If legacy kit rule filenames remain (`00-project.mdc`, `00-ask-project.mdc`, `16-route-via-ask-question.mdc`, `16-ask-route-via-ask-question.mdc`, etc.), add current `ask-*.mdc` names and remove those obsolete kit-sourced files (keep product-only rules).
4. Never delete or overwrite files under the agent-knowledge directory except creating **missing** empty template stubs with user OK. Ensure `users/<email>/session-backlog.md` exists; migrate Open items from legacy `.cursor/out-of-scope.md` or `knowledge/delivery/out-of-scope.md` into it.
5. **Documentation centralization (gated):** offer a full-workspace doc scan for installs that never ran it (or want a refresh). If **yes**, run `ask-centralize-docs` (authorize scan → copy → recommend cleanup). If **no**, skip; user can run `/ask-centralize-docs` later. Do **not** scan on every update without asking.
6. Summarize what changed in the user’s chat language (kit revision, merged skills/rules, whether doc scan ran).

### MUST NOT

- Reset agent-knowledge from template.
- Force-push kit or product repos.
- Overwrite `ask-project.mdc` or product stack skills.
- Assume default paths if install recorded different ones.

---

## Agent contract — centralize docs (`/ask-centralize-docs`) (MUST)

### Preconditions

1. `agent-knowledge` directory exists (after install or already present).
2. User ran `/ask-centralize-docs` **or** accepted the scan offer at the end of `/ask-install`.

### Authorize (MUST)

Ask permission to scan **all workspace sibling folders** for documentation. No recursive scan without **yes**.

### Scan

- Include every multi-root workspace folder.
- Exclude: kit directory, agent-knowledge directory, `.git`, `node_modules`, build/cache dirs.
- Candidate docs: README*, CONTRIBUTING*, ARCHITECTURE*, DESIGN*, docs/**, ADR trees, other root/docs markdown (user may deselect; ask before including CHANGELOG*).

### Copy then recommend delete

1. Show inventory `source → knowledge/…` → user yes to the set.
2. **Copy** only (write `knowledge/imported/IMPORT-MAP.md`). Do not delete originals here.
3. List originals now duplicated and **recommend** delete or stub with pointer to agent-knowledge.
4. Delete/stub **only** paths the user confirms (default: keep originals).

### MUST NOT

- Scan or delete without authorization.
- Move instead of copy on the first step.
- Import secrets or overwrite existing knowledge SoT without asking.

### Done when

- [ ] IMPORT-MAP reflects copies
- [ ] User saw cleanup recommendations
- [ ] Any deletions/stubs match an explicit approved list

---

## Agent contract — uninstall (`/ask-uninstall`) (MUST)

### Preconditions

1. Resolve **kit directory**, **agent-knowledge directory**, and **product `.cursor/` home** (recorded paths or ask).
2. User asked to uninstall / ran `/ask-uninstall`.

### Q&A (MUST — independent choices)

| Piece | Ask | Safe default |
|-------|-----|--------------|
| Kit directory | Keep clone or **delete** that directory? | Keep |
| agent-knowledge directory | Keep or **delete**? | Keep — if delete, require explicit confirmation (repeat path or phrase “delete agent-knowledge”) |
| Product `.cursor/` | (a) keep all (b) remove kit-sourced `ask-*` skills + known kit process rules only (c) remove entire `.cursor/` | (b) |
| Per-user session backlog (`users/<email>/session-backlog.md`) | Keep with agent-knowledge or delete with it | Follows agent-knowledge choice |

Show exact paths to delete → user **yes** to that list.

### Steps (after yes)

1. Remove only approved files under product `.cursor/` (kit-sourced). Do not remove product stack skills unless named in the approved list.
2. Delete agent-knowledge directory only if approved.
3. Delete kit directory only if approved.
4. Do not touch other workspace app repos.
5. No commit/push unless asked.

### MUST NOT

- Assume “uninstall everything” without per-piece answers.
- Delete memory or kit clone on a vague “uninstall”.
- Force-push or rewrite git history as part of uninstall.

### Done when

- [ ] Approved removals done; declined pieces intact
- [ ] User knows what remains and that `/ask-install` can wire again

---

## Manual install / update / uninstall / centralize

Same outcomes as the contracts. Uninstall = reverse chosen pieces only. Centralize = `/ask-centralize-docs` contract.

## Post-install checklist

- [ ] Kit clone tracks upstream; `.git` present
- [ ] Product `.cursor/` has `ask-*` skills; `ask-project.mdc` filled
- [ ] `agent-knowledge/` is a **separate** git repo (own remote when you add it)
- [ ] User `preferences.yaml` set
- [ ] `/ask-requirement`, `/ask-backlog`, `/ask-question`, `/ask-install`, `/ask-update`, `/ask-uninstall`, `/ask-centralize-docs` known

## Contributing back to the kit

Process improvements without business/personal content can be proposed upstream (PR to the canonical kit). Product memory stays in `agent-knowledge` only.

## Quick verification

- [ ] Agent reads `agent-knowledge/AGENTS.md` for memory protocol
- [ ] Kit updates do not wipe `agent-knowledge`
- [ ] Chat language from `preferences.yaml`; durable docs from `locale.content`
