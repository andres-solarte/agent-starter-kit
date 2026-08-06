# Installing the kit

How to wire this kit into a product workspace as an **updatable dependency** (git clone with upstream), while product memory lives in a **separate** `agent-knowledge` repo.

**Preferred path:** clone this repo, add it to the Cursor workspace, then `/ask-install`. Later: `/ask-update` after pulling new kit versions.

## Mental model

```text
workspace/
  agent-starter-kit/     ← this repo (keep .git + origin upstream; git pull to update)
  agent-knowledge/       ← NEW product git repo (own remote; global + per-user memory)
  .cursor/               ← product overlay + merged copy of kit rules/skills
  repo-api/ …
```

| Piece | Role | Git |
|-------|------|-----|
| **Kit clone** | Canonical process engine (rules/skills templates, INSTALL, updates) | Keep `.git`; `origin` = upstream kit (e.g. `andres-solarte/agent-starter-kit`). **Do not** `rm -rf .git` on the kit. |
| **Product `.cursor/`** | Working copy of kit process rules/skills + product overlays (`00-project.mdc`, stack skills, `out-of-scope.md`) | Usually part of a hub/product repo, or untracked — your choice |
| **`agent-knowledge/`** | Global knowledge (`knowledge/`) + per-user (`users/<email>/`) | **New** repo: copy from `agent-knowledge-template/`, `git init`, add **product** remote. Not the kit remote. |

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

1. **Clone the kit** (keep as dependency):
   ```bash
   git clone git@github.com:andres-solarte/agent-starter-kit.git
   ```
2. **Add the clone as a folder** in the Cursor workspace.
3. Run **`/ask-install`** (or: “install this kit into my working environment”).
4. When the kit releases changes: in the kit folder `git pull`, then **`/ask-update`**.

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

1. Kit repo visible in the workspace (cloned + added). If not: ask user to clone/add; only clone yourself if they gave a URL and asked.
2. **Kit root** = directory with this `INSTALL.md` and `agent-knowledge-template/`.
3. **Product home** = where product `.cursor/` and `agent-knowledge/` live (not inside the kit folder).
4. Kit must retain its `.git` and upstream `origin` (dependency). Never delete kit `.git` during install.

### Q&A (max 4; skip known)

1. Product home path — required if ambiguous.
2. Product / project name for `00-project.mdc`.
3. Sibling app repos.
4. `communication_language` — default `en`.

Summary → user **yes** before writing.

### Install steps (after yes)

1. Inventory product home (`.cursor`, docs/memory).
2. Merge kit `.cursor/` → product home:
   - Copy missing rules/skills.
   - On conflict: keep product; merge missing critical MUSTS if needed — no blind overwrite.
   - Ensure `out-of-scope.md` exists.
   - Record kit root path in `00-project.mdc` or a short `ask-kit-source.mdc` note so `/ask-update` can find upstream.
3. Instantiate `agent-knowledge`:
   - If missing: copy `agent-knowledge-template/` → `<product-home>/agent-knowledge/`.
   - Ensure it is a **new** git repo (`git init` if no `.git`). **Do not** keep the kit’s git history inside `agent-knowledge`.
   - Tell the user they should add a **product** remote when ready (`git remote add origin …`) — do not push unless asked.
   - Configure `config.yaml`; create `users/<git-email>/` + `IDENTITY.md` + `preferences.yaml`.
4. Fill `00-project.mdc` (no `{{…}}` left). Include sibling repos + pointer that process upstream is the kit clone.
5. Fix path pointers if `agent-knowledge` is not at the default relative path.
6. No commit/push unless asked.
7. Close: where kit / `.cursor` / `agent-knowledge` live; `/ask-requirement`, `/ask-backlog`; later `/ask-update`.

### MUST NOT

- `rm -rf` the kit’s `.git` or re-init the kit as the product remote.
- Put global/per-user memory inside the kit clone.
- Overwrite product stack rules/skills without explicit ask.
- Install into the kit folder as product home.

### Done when

- [ ] Kit clone still has upstream git
- [ ] Product `.cursor/` merged
- [ ] `agent-knowledge/` is its own git repo with user prefs
- [ ] User knows `/ask-update` for kit upgrades

---

## Agent contract — update (`/ask-update`) (MUST)

### Preconditions

1. Kit root and product home known (from prior install or Q&A).
2. User asked to update / ran `/ask-update`.

### Steps

1. In **kit root**: `git status`. If dirty with local hacks, warn and ask before pull.
2. `git pull` (or fetch + merge/rebase per user preference; default pull).
3. Re-merge kit `.cursor/rules` + `skills` → product home with the **same merge policy as install**.
4. Never delete or overwrite files under `agent-knowledge/knowledge/` or `users/` except creating **missing** empty template stubs if the upstream template added new optional dirs (ask first if unsure).
5. Summarize what changed (new skills/rules) in the user’s chat language.

### MUST NOT

- Reset `agent-knowledge` from template.
- Force-push kit or product repos.
- Overwrite `00-project.mdc` or product stack skills.

---

## Manual install / update

Same outcomes as the contracts. Update = `git pull` in kit + re-copy/merge `.cursor/` skills/rules into product home.

## Post-install checklist

- [ ] Kit clone tracks upstream; `.git` present
- [ ] Product `.cursor/` has `ask-*` skills; `00-project.mdc` filled
- [ ] `agent-knowledge/` is a **separate** git repo (own remote when you add it)
- [ ] User `preferences.yaml` set
- [ ] `/ask-requirement`, `/ask-backlog`, `/ask-install`, `/ask-update` known

## Contributing back to the kit

Process improvements without business/personal content can be proposed upstream (PR to the canonical kit). Product memory stays in `agent-knowledge` only.

## Quick verification

- [ ] Agent reads `agent-knowledge/AGENTS.md` for memory protocol
- [ ] Kit updates do not wipe `agent-knowledge`
- [ ] Chat language from `preferences.yaml`; durable docs from `locale.content`
