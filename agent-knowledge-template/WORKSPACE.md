# Workspace setup (team)

**Clone this repo first.** This file is the source of truth for a **replicable multi-root workspace**: every teammate uses the same parent layout, the same remotes, and the same folders open in the agent host (Cursor and/or Claude Code).

Do not invent a different folder tree per machine. Change this file (PR / confirm) when the product adds or renames a repo.

## 1. Prerequisites

- Git access to every **Required** remote below
- Agent host(s) used by this product (see **Agent hosts**)
- Optional: same parent directory name on disk is nice-to-have; **relative sibling names** in the table are what must match

## 2. Clone this repo (`agent-knowledge`)

```bash
# Parent directory for the whole product workspace (create if needed)
mkdir -p <WORKSPACE_PARENT>
cd <WORKSPACE_PARENT>

git clone <AGENT_KNOWLEDGE_REMOTE_URL> <agent-knowledge-folder>
cd <agent-knowledge-folder>
```

Open **this file** next — do not open only an app repo and hope the rest appears.

Default local folder name: `agent-knowledge` (or the name recorded under **Repos**).

## 3. Clone every other repo (same parent)

All clones sit as **siblings** under `<WORKSPACE_PARENT>` (never inside this repo, never inside the kit clone):

```text
<WORKSPACE_PARENT>/
  <agent-knowledge-folder>/     ← this repo (memory + this file)
  <kit-folder>/                 ← agent-starter-kit (process; keep .git + upstream)
  <adapter-home>/               ← product hub that holds .agents/ + host adapters (may be parent itself)
  <app-repo>/                   ← application code (repeat per row)
```

| Local folder | Remote URL | Required | Role |
|--------------|------------|----------|------|
| `agent-knowledge` | `<AGENT_KNOWLEDGE_REMOTE_URL>` | yes | Product memory (this repo) |
| `agent-starter-kit` | `https://github.com/andres-solarte/agent-starter-kit.git` | yes | Process kit (updatable dependency) |
| `_TBD_adapter_or_app_` | `_TBD_` | yes | Fill at install — adapter home and/or first app |

Add one table row per sibling. Mark optional tools/docs repos as `Required: no`.

Example clone loop (adjust names/URLs to the table):

```bash
cd <WORKSPACE_PARENT>
git clone <KIT_REMOTE_URL> agent-starter-kit
git clone <APP_REMOTE_URL> <app-folder>
# …one clone per Required row…
```

## 4. Open the multi-root workspace

Open **every Required** folder (and the Optional ones you need) in one window:

| Host | How |
|------|-----|
| **Cursor** | *File → Add Folder to Workspace…* for each sibling → *Save Workspace As…* under `<WORKSPACE_PARENT>` (skeleton: `templates/workspace.code-workspace` — paths are relative to that parent; add one folder entry per Repos row) |
| **Claude Code** | Add the same folders to the project/session so agents see kit + memory + apps together |

**Agent hosts for this product:** `_TBD_cursor_claude_or_both_`

The workspace **must** include this `agent-knowledge` folder so agents can read `AGENTS.md` and write memory.

## 5. First day on a machine

| Situation | Do |
|-----------|-----|
| New product / adapters missing (no product `.agents/`) | With kit + this repo in the workspace, run **`/ask-install`** (choose dirs + hosts). Install fills this table. |
| Product already installed (teammate machine) | `git pull` in this repo and in the kit → **`/ask-update`**. Create `users/<your-email>/` from `users/_template/` if missing. |
| Only catching up on apps | `git pull` in each app row; no need to re-run install |

Kit clone: keep `.git` and upstream; never put memory inside the kit directory.

## 6. Done when (checklist)

- [ ] This repo cloned first; `WORKSPACE.md` matches the Remotes the team uses
- [ ] Every **Required** row exists as a sibling under the same parent
- [ ] Multi-root window includes agent-knowledge + kit + apps
- [ ] Product adapter home has `.agents/` and only the hosts listed above
- [ ] `git config user.email` set; `users/<email>/` exists for you
- [ ] Kit tracks upstream; `git pull` + `/ask-update` when process changes

## 7. When the layout changes

1. Update the **Repos** table (and `*.code-workspace` if you commit one).
2. Tell the team: pull this repo, clone the new remote, add the folder to the saved workspace.
3. If a new app surface appears → `/ask-setup-agents` (delta) so roles stay aligned.

## Related

- Memory protocol: [AGENTS.md](./AGENTS.md)
- Human map: [INDEX.md](./INDEX.md)
- Kit install/update contracts: kit root `INSTALL.md`
- Git norms: [knowledge/conventions/git.md](./knowledge/conventions/git.md)
