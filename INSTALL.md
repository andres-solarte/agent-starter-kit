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

**Naming:** all kit skills use the `ask-` prefix to avoid colliding with other skills.

## What `/ask-install` does

1. Leaves the **kit clone** intact (updatable dependency).
2. Merges kit `.cursor/rules` + `.cursor/skills` into **product home** (safe merge).
3. Instantiates **`agent-knowledge/`** as a **new** git repository (own history/remote).
4. Fills product placeholders and per-user `preferences.yaml`.

## What `/ask-update` does

1. `git fetch` / `git pull` in the **kit clone** (or report if dirty/conflicts).
2. Re-merges kit `.cursor/` → product home **without** overwriting product overlays or stack skills.
3. Does **not** reset or replace `agent-knowledge/` content (memory stays put). Optionally copies **new** template files that are missing only (never overwrite existing knowledge files).

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
| 4 | Product / project name (for `00-project.mdc`) | Default: name of product `.cursor/` home folder |
| 5 | Sibling app repos in the workspace | Default: empty |
| 6 | `communication_language` | Default: `en` |

Cap: if too many unknowns, ask paths **1–3 first** (blocking), then the rest. Summary of all chosen paths → user **yes** before writing.

### Install steps (after yes)

1. **Ensure kit at kit directory:** clone if needed; verify `INSTALL.md` + `agent-knowledge-template/`; keep `.git` + upstream.
2. Inventory product `.cursor/` home.
3. Merge kit `.cursor/` → product `.cursor/` home (safe merge; no blind overwrite). Ensure `out-of-scope.md` exists. Record **kit directory** and **agent-knowledge directory** in `00-project.mdc` (or `ask-kit-paths.mdc`) for `/ask-update`. **Always install/update** rule `16-route-via-ask-question.mdc` and skill `ask-question` (process-critical — default triage).
4. Instantiate **agent-knowledge** at the chosen path (new git repo; product remote later; user + prefs).
5. Fill `00-project.mdc`; fix pointers so they resolve to the chosen agent-knowledge path (update `15-agent-knowledge.mdc` / `ask-agent-knowledge` skill as needed).
6. No commit/push unless asked.
7. Close: echo the three paths (kit / agent-knowledge / `.cursor` home); `/ask-requirement`, `/ask-backlog`, `/ask-update`.

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

---

## Agent contract — update (`/ask-update`) (MUST)

### Preconditions

1. Resolve **kit directory** and **product `.cursor/` home** (from recorded install paths, or ask).
2. Optionally confirm **agent-knowledge directory** (only to avoid touching it — do not overwrite).
3. User asked to update / ran `/ask-update`.

### Steps

1. In **kit directory**: `git status`. If dirty, warn and ask before pull.
2. `git pull` (or fetch + merge/rebase per user preference; default pull).
3. Re-merge kit `.cursor/rules` + `skills` → product `.cursor/` home with the **same merge policy as install**. Ensure `16-route-via-ask-question.mdc` and `ask-question` are present.
4. Never delete or overwrite files under the agent-knowledge directory except creating **missing** empty template stubs with user OK.
5. Summarize what changed in the user’s chat language.

### MUST NOT

- Reset agent-knowledge from template.
- Force-push kit or product repos.
- Overwrite `00-project.mdc` or product stack skills.
- Assume default paths if install recorded different ones.

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
| `out-of-scope.md` | Keep or delete? | Keep |

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

## Manual install / update / uninstall

Same outcomes as the contracts. Uninstall = reverse the chosen pieces only (see uninstall contract).

## Post-install checklist

- [ ] Kit clone tracks upstream; `.git` present
- [ ] Product `.cursor/` has `ask-*` skills; `00-project.mdc` filled
- [ ] `agent-knowledge/` is a **separate** git repo (own remote when you add it)
- [ ] User `preferences.yaml` set
- [ ] `/ask-requirement`, `/ask-backlog`, `/ask-question`, `/ask-install`, `/ask-update`, `/ask-uninstall` known

## Contributing back to the kit

Process improvements without business/personal content can be proposed upstream (PR to the canonical kit). Product memory stays in `agent-knowledge` only.

## Quick verification

- [ ] Agent reads `agent-knowledge/AGENTS.md` for memory protocol
- [ ] Kit updates do not wipe `agent-knowledge`
- [ ] Chat language from `preferences.yaml`; durable docs from `locale.content`
