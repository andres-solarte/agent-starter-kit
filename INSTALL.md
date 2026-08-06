# Installing the kit

How to install this kit into a product workspace. This repo is a **template you copy**, not a linked dependency.

**Preferred path:** clone this repo, add it to the Cursor workspace, then ask the agent to install it (`/ask-install` or plain language). Details below.

## What gets installed

| Piece | Destination in the product workspace | Role |
|-------|--------------------------------------|------|
| `.cursor/rules/` | product home (workspace hub or chosen root) | Agent process rules |
| `.cursor/skills/` | product home | Shared pack (`ask-install`, `ask-requirement`, `ask-backlog`, …) |
| `agent-knowledge-template/` | copy as `agent-knowledge/` (path adjustable) | Project memory / SoT (**separate** git repo) |

Does not include stack skills (framework, testing, DB) or `speckit-*`; those are added per project.

**Naming:** all kit skills use the `ask-` prefix (folders, `name:` frontmatter, and user slash commands) to avoid colliding with other skills in the product workspace.

## Human setup (once per machine / workspace)

This kit is an external library: the agent cannot install what it cannot see.

1. **Clone** (example):
   ```bash
   git clone git@github.com:andres-solarte/agent-starter-kit.git
   ```
   Put the clone where you keep tooling, or inside the product workspace folder as a sibling of your app repos.
2. **Add the clone as a folder** in the Cursor workspace (File → Add Folder to Workspace…), same as any other repo.
3. **Ask the agent** (with this kit folder in context), for example:
   - `/ask-install`
   - “Install this kit into my working environment”
   - “Adopt agent-starter-kit in this workspace”

The agent follows **Agent contract** below (and the `/ask-install` skill).

You can still install by hand using the checklists further down; the agent path is the default.

## Order when also using ai-dev-standard

1. **ai-dev-standard first** — adopt core (and matching profiles) and create the product adoption document. Guide: `ADOPTION.md` in the `ai-dev-standard` repo.
2. **This kit after** — `/ask-install` (or manual install); link the standard from the product adoption document or from `agent-knowledge/knowledge/conventions/`.

If you only want the agent protocol, install this kit alone.

## Language configuration

| Layer | Where | Default |
|-------|-------|---------|
| Durable content (knowledge, decisions, specs the agent writes) | `agent-knowledge/config.yaml` → `locale.content` | `en` |
| Paths / identifiers | `locale.paths` | `en` |
| Chat with this user | `users/<email>/preferences.yaml` → `communication_language` | `en` if missing |

Code, commits, and technical names are English by default. Chat language is **per-user** (rule `08-user-communication`).

---

## Agent contract (MUST)

When the user asks to install/ask-install this kit into their working environment (or runs `/ask-install`):

### Preconditions

1. This kit repo is visible in the workspace (cloned + added as a folder). If not: tell the user to clone and add it; do **not** invent a silent install from the network unless they explicitly gave a URL **and** asked you to clone.
2. Identify **kit root** = directory that contains this `INSTALL.md` and `agent-knowledge-template/`.
3. Identify **product home** = where `.cursor/` and `agent-knowledge/` should live for the product (often a multi-repo workspace hub, not inside this kit folder).

### Q&A before copying (max 4 questions; skip any already known)

1. **Product home path** (absolute or workspace-relative) — required if ambiguous.
2. **Product / project name** for `00-project.mdc`.
3. **Sibling app repos** in this workspace (names/paths) — for `00-project.mdc`.
4. **`communication_language`** for this user (`en`, `es`, …) — default `en` if they decline.

Show a one-screen summary and get a short “yes” before writing files.

### Install steps (after yes)

1. **Inventory** product home: existing `.cursor/rules`, `.cursor/skills`, `.claude`, docs/memory folders.
2. **Merge `.cursor/` from kit → product home** (never delete the user’s stack rules/skills):
   - Copy rules/skills that do **not** already exist.
   - On name conflict: keep the product file; if the kit rule is process-critical (focus, communication, skill discipline, one-point-at-a-time, agent-knowledge pointer), merge missing MUST bullets into the product file or add a clearly named kit rule alongside — do **not** blindly overwrite.
   - Always ensure `out-of-scope.md` exists (create empty Open / Done sections if missing).
3. **Instantiate `agent-knowledge`:**
   - If missing: copy `agent-knowledge-template/` → `<product-home>/agent-knowledge/` (or agreed path).
   - `git init` inside `agent-knowledge/` if not already a git repo.
   - Set `config.yaml` `repo:` and keep `locale.content` / `locale.paths` (default `en`).
   - Create `users/<git-email>/` from `_template/`; fill `IDENTITY.md`; set `preferences.yaml` `communication_language`.
   - If docs already live elsewhere: do not force a full migrate; point thin adapters or ask whether to use `agent-knowledge` as SoT going forward.
4. **Fill `00-project.mdc`** placeholders (name, description stub, sibling repos, language pointers). Leave no `{{…}}` placeholders.
5. **Fix pointers** if `agent-knowledge` path ≠ `<product-home>/agent-knowledge`: update `15-agent-knowledge.mdc`, `skills/ask-agent-knowledge/SKILL.md`, and note `adapters/cursor.md`.
6. **Do not** commit or push unless the user asks.
7. **Close** in the user’s chat language: what was installed, where, how to use `/ask-requirement` and `/ask-backlog`, and that this kit folder can stay in the workspace as the upstream reference (product copies are independent).

### MUST NOT

- Overwrite product stack skills/rules without explicit ask.
- Install into the kit repo itself as if it were the product.
- Paste the full operating protocol into `.cursor/` (SoT remains `agent-knowledge/AGENTS.md`).
- Require the user to run a long manual checklist if you can perform these steps.

### Done when

- [ ] Product home has kit process rules/skills (merged)
- [ ] `agent-knowledge/` exists as its own git repo with user + `preferences.yaml`
- [ ] `00-project.mdc` has no placeholders
- [ ] Pointers to `AGENTS.md` match the real path
- [ ] User knows `/ask-requirement`, `/ask-backlog`, and `/ask-install` (re-run safe / merge)

---

## Manual install (new project)

Same outcomes as the agent contract; useful without an agent.

1. Copy `.cursor/` to product home.
2. Fill `00-project.mdc`.
3. Copy `agent-knowledge-template/` → `agent-knowledge/`, `git init`, configure `config.yaml`, create `users/<email>/`.
4. Fix path pointers if needed.
5. First use: `/ask-requirement`.

## Manual install (existing project)

1. Inventory existing `.cursor` / docs.
2. Merge (do not overwrite stack rules).
3. Instantiate or point `agent-knowledge`.
4. Fill placeholders; set `preferences.yaml`.
5. Smoke: `/ask-requirement` trivial + `/ask-backlog` → `.cursor/out-of-scope.md`.

## Post-install checklist

- [ ] `.cursor/rules/` and `.cursor/skills/` present; `00-project.mdc` without placeholders
- [ ] `agent-knowledge/` is its own git repo; user under `users/<email>/` with `preferences.yaml`
- [ ] `config.yaml` uses nested `locale.content` / `locale.paths`
- [ ] Pointers to `agent-knowledge/AGENTS.md` match the real path
- [ ] `/ask-requirement`, `/ask-backlog`, and `/ask-install` work when this kit (or the product copy) is in the workspace
- [ ] (Optional) `ai-dev-standard` adoption document linked
- [ ] Project stack skills added or listed as gaps

## Maintenance

Improvements in a consuming project are **copied by hand** back into this kit (no business content). Each product carries its own copy of `.cursor/` + `agent-knowledge/`.

## Quick verification

- [ ] Agent reads `agent-knowledge/AGENTS.md` (not a protocol only in `.cursor/`)
- [ ] Out of scope is parked; not executed “while at it”
- [ ] Commits/PRs only if the user asks
- [ ] Chat language follows `preferences.yaml`; durable docs follow `locale.content`
