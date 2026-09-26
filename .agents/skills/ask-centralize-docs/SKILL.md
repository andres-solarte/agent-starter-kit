---
name: ask-centralize-docs
description: >-
  With user authorization, scan the whole multi-repo workspace for documentation,
  copy it into agent-knowledge, then recommend deleting the originals outside
  agent-knowledge. Use when the user says /ask-centralize-docs, after
  /ask-install offers doc migration, or "centralize documentation".
---

# /ask-centralize-docs — scan, copy, recommend cleanup (user)

Follow **`INSTALL.md`** → **Agent contract — centralize docs**.

Also invoked as a **gated step** at the end of `/ask-install` (only after the user authorizes a workspace scan).

## Goal

1. **Ask permission** to scan the entire Cursor workspace (all sibling folders).
2. **Inventory** documentation candidates.
3. On user **yes** to the plan: **copy** into `agent-knowledge/knowledge/` (never silent move).
4. **Recommend** deleting (or stubbing) originals that now live in agent-knowledge; delete **only** with explicit confirmation.

## Flow (MUST)

```text
1. Resolve agent-knowledge dir + workspace roots
2. Ask: authorize full-workspace doc scan? (no → stop cleanly)
3. Scan → present inventory + proposed destinations
4. User yes to copy set → copy + write import map
5. Recommend cleanup of originals → delete/stub only what user confirms
6. Close: what was copied; what remains outside; open cleanup items
```

## Authorize scan (MUST)

Before any recursive search, ask clearly in the user’s chat language.  
No scan without **yes**. Skipping is OK (install can finish without this step).

## Scan scope (MUST)

- **Include:** every folder root in the multi-root workspace (sibling repos).
- **Exclude:**
  - the **kit** directory (`INSTALL.md` + `agent-knowledge-template/`)
  - the **agent-knowledge** directory itself
  - `.git/`, `node_modules/`, `dist/`, `build/`, `.next/`, `coverage/`, vendor caches, binary assets folders if obvious
- **Candidates (documentation):**
  - `README*`, `CONTRIBUTING*`, `ARCHITECTURE*`, `DESIGN*`, `ADR*`, `CHANGELOG*` (optional — ask if changelogs should be included)
  - `docs/**`, `documentation/**`, `doc/**`
  - `**/adr/**`, `**/adrs/**`, `**/architecture/**/*.md` when clearly docs
  - Other standalone `*.md` / `*.mdx` at repo roots or under `docs/` — list them; user can deselect
- Prefer text docs; skip huge generated files and license-only trees unless user asks.

## Inventory format (MUST show before copy)

```text
Found N doc files across M repos:
- <source-path> → knowledge/<proposed-relpath>
…
Exclude any? Include changelogs? (yes to proceed with listed set)
```

Proposed layout under agent-knowledge (adjust to fit existing folders):

| Source kind | Default destination |
|-------------|---------------------|
| Product/README overview | `knowledge/product/` |
| Architecture / ADR | `knowledge/architecture/` or `knowledge/decisions/architecture/` |
| Domain | `knowledge/domain/` |
| Design | `knowledge/design/` |
| Process / delivery | `knowledge/delivery/` |
| Unclear | `knowledge/imported/<repo-name>/…` (preserve relative path) |

On conflict with an existing knowledge file: **keep existing**; copy new as `…/imported/…` or ask.

## Copy (MUST)

1. Copy approved files only (create dirs as needed).
2. Write/update `knowledge/imported/IMPORT-MAP.md` (or `knowledge/conventions/doc-import-map.md`) with: date, source path, destination path, status `copied`.
3. Do **not** delete originals in this step.
4. No commit/push unless asked.

## Recommend cleanup (MUST)

After copy, list originals that are now centralized and **recommend**:

- Delete the original, **or**
- Replace with a short stub pointing to the agent-knowledge path.

Ask which paths to clean. Defaults: **keep originals** until the user picks deletions/stubs.  
Never mass-delete without an explicit approved list.

When deleting/stubbing: update IMPORT-MAP status to `original_removed` or `stubbed`.

## MUST NOT

- Scan without authorization.
- Move/delete originals as part of the copy step.
- Import secrets (`.env`, keys) or treat them as docs.
- Overwrite existing SoT knowledge without asking.
- Touch the kit’s own README/docs as product docs to import.

## Close

Counts copied; path to IMPORT-MAP; which originals still outside; remind `/ask-question` can locate centralized docs later.
