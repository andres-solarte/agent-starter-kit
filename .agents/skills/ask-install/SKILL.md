---
name: ask-install
description: >-
  Install agent-starter-kit as an updatable dependency: choose agent hosts
  (Cursor and/or Claude Code), kit and agent-knowledge directories, merge only
  the matching adapters (.cursor and/or .claude) plus neutral .agents/ SoT,
  instantiate agent-knowledge, then run /ask-setup-agents. Never install
  .cursor into Claude-only products.
---

# /ask-install — install kit (updatable dependency)

Follow **`INSTALL.md` at the kit root** → **Agent contract — install**.

## Model (MUST)

| Path (user-chosen) | Action |
|--------------------|--------|
| **Kit directory** | Clone or use existing kit; keep `.git` + upstream. |
| **agent-knowledge directory** | Copy template → **new** `git init` (outside kit). |
| **Product adapter home** | Receives `.agents/` SoT + host adapters (default: parent of agent-knowledge). |
| **Agent hosts** | `cursor` \| `claude` \| `both` — **only** these adapters are created. |

| Host | What gets created under adapter home |
|------|--------------------------------------|
| `cursor` | `.agents/` + `.cursor/rules` + `.cursor/skills`→`.agents/skills` + `.cursor/agents` |
| `claude` | `.agents/` + `.claude/rules`→`.agents/rules` + `.claude/skills`→`.agents/skills` + `.claude/agents` + `CLAUDE.md` |
| `both` | Both columns |

**Claude-only MUST NOT create `.cursor/`.** Cursor-only MUST NOT create `.claude/` (optional exception: user asks for both later via update).

## Flow (MUST)

```text
1. Q&A: kit dir + agent-knowledge dir + adapter home + hosts + sibling remotes
2. Summary of paths + hosts → yes
3. Ensure kit; copy/merge .agents/; wire selected host adapters only
4. Create agent-knowledge; fill prefs + session-backlog; record hosts in ask-project
5. Fill WORKSPACE.md (remotes table + hosts; replace _TBD_ for known pieces)
6. Run /ask-setup-agents (writes role agents to host agent dirs)
7. Close — do NOT prompt for doc scan; point team at WORKSPACE.md
```

## Q&A (MUST)

| Ask | Default if skipped |
|-----|--------------------|
| **Kit directory** | Fail — must choose |
| **agent-knowledge directory** | Fail — must choose (not inside kit) |
| **Product adapter home** | Parent of agent-knowledge |
| **Agent hosts** (`cursor` / `claude` / `both`) | Fail — must choose |
| Project name | Adapter home folder name |
| Sibling repos (local folder + remote URL each) | Empty table rows only if none yet — still write kit + agent-knowledge rows in `WORKSPACE.md` |
| `communication_language` | `en` |

## Wire adapters (MUST)

From **kit directory**:

1. Merge kit `.agents/skills` + `.agents/rules` (+ `.agents/agents` stub) → `<adapter-home>/.agents/` (safe merge; no blind overwrite of customized skills).
2. **If hosts include cursor:**
   - Merge kit `.cursor/rules` → `<adapter-home>/.cursor/rules/`
   - Ensure `<adapter-home>/.cursor/skills` is a symlink (or copy fallback) to `../.agents/skills`
   - Ensure `<adapter-home>/.cursor/agents/` exists (role agents later)
3. **If hosts include claude:**
   - Ensure `<adapter-home>/.claude/skills` → `../.agents/skills`
   - Ensure `<adapter-home>/.claude/rules` → `../.agents/rules`
   - Ensure `<adapter-home>/.claude/agents/` exists
   - Write/update `<adapter-home>/CLAUDE.md` thin pointer (skills/rules under `.claude/`, memory in agent-knowledge)
4. **If hosts = claude only:** do **not** create `<adapter-home>/.cursor/`
5. **If hosts = cursor only:** do **not** create `<adapter-home>/.claude/` unless user asked

**Symlink failure (e.g. Windows without privilege):** copy `.agents/skills` into the host skills path and note in close that SoT sync is copy-based (prefer re-running update after enabling symlinks).

Record in product `ask-project.mdc` (under adapter home `.cursor/rules` and/or mirror into `.agents/rules/ask-project.md`):

```markdown
## Kit paths
- Kit directory: …
- agent-knowledge directory: …
- Product adapter home: …
- Agent hosts: cursor | claude | both
```

Ensure rule **`ask-agent-scope`** is merged into `.agents/rules/` and into `.cursor/rules/` when hosts include cursor.

## WORKSPACE.md (MUST)

After agent-knowledge exists, edit its root **`WORKSPACE.md`** so teammates can replicate the machine:

1. Set **Agent hosts** to the chosen value.
2. Fill the **Repos** table: this repo’s remote (if `origin` exists or user gave URL), kit folder + remote, adapter home / apps from sibling answers.
3. Replace every `_TBD_` that is known; leave a clear `_TBD_` only for unknowns.
4. Optionally copy `templates/workspace.code-workspace` notes into close (Cursor parent multi-root).

## Setup agents (MUST)

After agent-knowledge exists, run `ask-setup-agents` (from `.agents/skills/…`). Role agents go to each selected host’s `agents/` dir (and optionally `.agents/agents/` as SoT).

## Doc centralization

Do not prompt for doc scan. Merge `ask-centralize-docs` skill via `.agents/`. Mention `/ask-centralize-docs` once in close if useful.

## MUST NOT

- Merge kit `.cursor/` into a Claude-only product.
- Use the kit directory as product adapter home.
- Delete kit `.git`.
- Commit/push app/kit unless asked.
- Wipe existing agent-knowledge with data without asking.
- Leave `WORKSPACE.md` as the untouched template when kit/AK/hosts are already known.

## Close

Echo kit / agent-knowledge / adapter home / **hosts**; confirm `.cursor` absent if Claude-only; roles created or skipped; tell the team to onboard via **`agent-knowledge/WORKSPACE.md`**; `/ask-requirement`, `/ask-update`.
