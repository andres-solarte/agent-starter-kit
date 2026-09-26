# Installing the kit

How to wire this kit into a product workspace as an **updatable dependency** (git clone with upstream), while product memory lives in a **separate** `agent-knowledge` repo.

**Preferred path:** clone this repo, add it to your workspace (Cursor and/or Claude Code), then `/ask-install`. Later: `/ask-update` after pulling new kit versions.

## Mental model

```text
workspace/
  <kit-directory>/              ← keep .git + upstream
  <agent-knowledge-dir>/        ← NEW product git repo (memory)
  <adapter-home>/
    .agents/skills|rules/       ← tool-neutral SoT (copied from kit)
    .cursor/…                   ← ONLY if host includes cursor
    .claude/…                   ← ONLY if host includes claude
  repo-api/ …
```

| Piece | Role | Git |
|-------|------|-----|
| **Kit directory** | Process engine (`.agents/` SoT + host adapters for kit dev) | Keep `.git`; upstream. **Do not** `rm -rf .git`. |
| **Product adapter home** | Receives `.agents/` + selected host dirs | Hub/product repo as you prefer |
| **Agent hosts** | `cursor` \| `claude` \| `both` | Recorded at install |
| **agent-knowledge** | Global + per-user memory | **New** repo; product remote |

**Claude-only products must not get a `.cursor/` tree.** Cursor-only products need not get `.claude/`.

Skills SoT: `.agents/skills/`. Host folders `.cursor/skills` and `.claude/skills` are **symlinks** (copy fallback if symlinks fail).

**Naming:** kit skills/rules use `ask-` prefix.

**Migrations:** relocate then **delete** old paths (no stubs).

## What `/ask-install` does

1. Leaves the **kit clone** intact.
2. Asks **agent hosts** (`cursor` / `claude` / `both`).
3. Merges kit **`.agents/`** into adapter home; wires **only** selected host adapters.
4. Instantiates **agent-knowledge** as a new git repo; prefs + session-backlog.
5. Runs **`/ask-setup-agents`** → `roles.md` + host `agents/ask-*.md`.
6. Does not prompt for doc scan (`/ask-centralize-docs` is manual).

## What `/ask-setup-agents` does

1. Scans surfaces + stack/business signals.
2. Proposes roles; asks type vs per-surface when needed.
3. Writes `roles.md` + subagents under each configured host’s `agents/` dir.
4. Migrates legacy `ask-role-*` skills if present.

## What `/ask-centralize-docs` does

1. Authorize scan of workspace siblings → copy into agent-knowledge → recommend cleanup.
2. Does not run without authorization.

## What `/ask-update` does

1. Pull kit; re-merge `.agents/` + refresh **only** recorded host adapters.
2. Claude-only: offer to remove leftover kit-sourced `.cursor/` if present.
3. Surface delta → offer setup-agents delta; once-only setup notice if pending.
4. No automatic doc scan.

## Human setup (once)

1. Clone/place the kit; add folders to the workspace.
2. `/ask-install` — kit dir, agent-knowledge dir, adapter home, **hosts**.
3. Later: `git pull` in kit + `/ask-update`.

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
| 1 | **Kit directory** | Empty/missing → clone; existing kit root → use. Never `rm -rf .git`. |
| 2 | **agent-knowledge directory** | Outside kit. Missing → copy template + `git init`. Existing data → do not wipe. |
| 3 | **Product adapter home** | Default: **parent of agent-knowledge**. Not the kit directory. |
| 4 | **Agent hosts** — `cursor` / `claude` / `both` | **Required.** Claude-only → no `.cursor/`. |
| 5 | Product / project name | Default: adapter home folder name |
| 6 | Sibling app repos | Default: empty |
| 7 | `communication_language` | Default: `en` |

Cap: ask **1–4** first (blocking). Summary of paths + hosts → user **yes** before writing.

### Install steps (after yes)

1. Ensure kit at kit directory (`INSTALL.md`, `.agents/`, template); keep `.git` + upstream.
2. Merge kit `.agents/` → `<adapter-home>/.agents/` (safe merge).
3. Wire **only** selected hosts (symlinks skills/rules → `.agents/…`; Cursor also merges `.cursor/rules/*.mdc`). Write thin `CLAUDE.md` when Claude is selected.
4. Record kit / agent-knowledge / adapter home / **Agent hosts** in `ask-project` (Cursor `.mdc` and refresh `.agents/rules/ask-project.md` when regenerating rules).
5. Instantiate agent-knowledge; prefs; `session-backlog.md`. Migrate legacy out-of-scope → backlog; delete legacy (no stubs).
6. Ensure `ask-question`, `ask-setup-agents`, `ask-centralize-docs` present under `.agents/skills`. No doc-scan prompt.
7. Run `/ask-setup-agents` → `roles.md` + agents into each host `agents/` dir. Decline → leave setup notice pending.
8. No app/kit commit unless asked (agent-knowledge auto close-out still applies).
9. Close: paths + **hosts**; confirm no `.cursor/` if Claude-only; next slashes.

### MUST NOT

- Assume paths without asking.
- `rm -rf` kit `.git`.
- Put memory inside the kit clone.
- Use kit directory as adapter home.
- Create `.cursor/` when hosts are Claude-only.
- Merge all `templates/role-agents/` without confirmation.

### Done when

- [ ] Kit has upstream git
- [ ] agent-knowledge is its own repo with prefs
- [ ] `.agents/` present; host adapters match chosen hosts only
- [ ] Claude-only has **no** product `.cursor/`
- [ ] Paths + hosts recorded
- [ ] Setup-agents done or skipped

---

## Agent contract — update (`/ask-update`) (MUST)

### Preconditions

1. Resolve kit directory, adapter home, **agent hosts** (or ask).
2. Optionally confirm agent-knowledge directory (do not overwrite).
3. User ran `/ask-update`.

### Steps

1. Kit: `git status`; warn if dirty; `git pull`.
2. Re-merge `.agents/`; refresh **only** recorded host adapters (same policy as install).
3. Claude-only with leftover kit-sourced `.cursor/` → offer delete after explicit yes.
4. agent-knowledge: missing template files / backlog migrate / requirements folder; delete Spec Kit placeholders if empty; no content wipe.
5. No doc-scan prompt. Once-only setup-agents notice if pending. New surfaces → offer setup-agents delta.
6. Summarize (hosts + what merged).

### MUST NOT

- Reset agent-knowledge from template.
- Force-push.
- Add `.cursor/` to Claude-only products.
- Silent-create subagents for new repos.
- Assume default paths/hosts if install recorded different ones.

---

## Agent contract — setup agents (`/ask-setup-agents`) (MUST)

### Preconditions

1. Kit directory, agent-knowledge directory, and product `.cursor/` home are known (install record or ask).
2. User ran `/ask-setup-agents`, or `/ask-install` reached this step, or `/ask-update` offered setup / found new surfaces, or a mid-REQ **agent gap** was accepted.

### Steps

1. Inventory **surfaces** (sibling repos/apps) + existing agents/`roles.md` (full or **delta** mode).
2. Lightweight stack/business scan (exclude kit, vendor/build dirs).
3. For uncovered surfaces: propose specialists matching nature/scope. If several share a specialty → **ask** type vs per-surface granularity.
4. Propose persona hint + create/update list → user **yes** / edit.
5. Write/update `roles.md` (include Surfaces table) + copy/fill `.cursor/agents/ask-*.md` from `templates/role-agents/` (or lean custom). Prefer `ask-tech-lead` unless declined.
6. If legacy `.agents/skills/ask-role-*/` exists: migrate MUSTS, then **delete** those folders (no stubs).
7. Update `ask-project.mdc` Agents section including **Known surfaces**.
8. Agent-knowledge auto close-out (commit/push). No app/kit commit unless asked.

### MUST NOT

- Invent roles with no evidence and no confirmation.
- Silent-create agents on update or mid-REQ.
- Create `ask-role-*` **skills** instead of `.cursor/agents/` subagents.
- Overwrite customized subagents without asking.
- Dump every template role without a confirmed list.

### Done when

- [ ] `roles.md` reflects confirmed roles + surfaces
- [ ] Matching `.cursor/agents/ask-*.md` subagents exist for approved list
- [ ] Legacy `ask-role-*` skills removed if they were present
- [ ] `ask-project.mdc` Agents + Known surfaces updated

---

## Agent contract — centralize docs (`/ask-centralize-docs`) (MUST)

### Preconditions

1. `agent-knowledge` directory exists (after install or already present).
2. User ran `/ask-centralize-docs` explicitly.

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
- [ ] Product `.cursor/agents/ask-*.md` role subagents present (or setup skipped)
- [ ] `agent-knowledge/` is a **separate** git repo (own remote when you add it)
- [ ] User `preferences.yaml` set
- [ ] `/ask-requirement`, `/ask-requirement-fix`, `/ask-backlog`, `/ask-question`, `/ask-install`, `/ask-update`, `/ask-uninstall`, `/ask-centralize-docs`, `/ask-setup-agents` known
- [ ] `knowledge/architecture/agents/roles.md` filled (or setup explicitly skipped)
- [ ] `knowledge/delivery/requirements/` present (INDEX + template) for REQ traceability

## Contributing back to the kit

Process improvements without business/personal content can be proposed upstream (PR to the canonical kit). Product memory stays in `agent-knowledge` only.

## Quick verification

- [ ] Agent reads `agent-knowledge/AGENTS.md` for memory protocol
- [ ] Kit updates do not wipe `agent-knowledge`
- [ ] Chat language from `preferences.yaml`; durable docs from `locale.content`
