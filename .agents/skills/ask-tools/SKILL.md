---
name: ask-tools
description: >-
  Tool inventory for agents: what MCP servers, CLIs, SDKs, services and runtimes
  the product's agents use, how to install / configure / verify each, and what is
  available on this machine. Scans all knowledge to build the inventory, asks on
  a fresh machine whether to install everything now or on demand, and installs a
  missing tool when an agent needs it. Use for /ask-tools, "what tools do we
  have", "how do I configure X", a new machine / new collaborator, or when an
  agent needs a tool that is missing.
---

# /ask-tools — inventory, install, availability

Agents must know **what they can use** before they plan, and every machine must be reproducible.

| Piece | Path | Git |
|-------|------|-----|
| **Inventory (team SoT)** | `agent-knowledge/knowledge/tooling/INVENTORY.md` | tracked — **PR only** |
| Personal tools | `users/<email>/knowledge/tooling/INVENTORY.md` (same-basename delta) | tracked — direct |
| **Machine status** | `users/<email>/tools.local.yaml` | **local** (gitignored; one per machine) |
| Install mode | `users/<email>/preferences.yaml` → `tools_install_mode: ask \| all \| on_demand` | local |
| **Availability rule (generated)** | `<adapter-home>/.cursor/rules/ask-tools-available.mdc` · `<adapter-home>/.agents/rules/ask-tools-available.md` | not in agent-knowledge |

App runtime/library versions stay in `knowledge/architecture/stack-versions.md` (rule `ask-stack-versions`); the inventory covers what **agents and developers need to work** and links there for versions.

## Commands

| Input | Action |
|-------|--------|
| `/ask-tools` or `/ask-tools list` | Inventory + status on this machine (installed · missing · declined · unknown) |
| `/ask-tools scan` | Discover tools across all knowledge → propose inventory changes (flow **Scan**) |
| `/ask-tools install all` | Install every missing tool (flow **Install all**) |
| `/ask-tools install <id>` | Install / configure one tool |
| `/ask-tools check` | Run every `Verify`; update `tools.local.yaml`; regenerate the rule |
| `/ask-tools add <tool>` | Add a tool to the inventory (PR) |
| `/ask-tools mode` | Change `tools_install_mode` |

## Inventory entry format

```markdown
### gh — GitHub CLI
- Kind: cli | mcp | sdk | service | runtime | ide-extension | other
- Purpose: one line (what agents use it for)
- Used by: all | ask-devops, ask-backend | skill:ask-git-project
- Need: required | optional
- Hosts: any | cursor | claude
- Install: macOS `brew install gh` · Linux `…` · Windows `winget install GitHub.cli`
- Configure: `gh auth login` (scopes: repo, workflow) · env: — (names only)
- MCP config: (kind mcp) server name, command/url, scope project|user, target file per host; secrets as env refs
- Verify: `gh auth status`
- Docs: <url>
- Evidence: where it was found (paths)
```

- **Secrets:** never store values. Only env var **names** and where a teammate obtains them (vault item, console page, who to ask).
- **MCP targets:** Cursor `<adapter-home>/.cursor/mcp.json` (project) or `~/.cursor/mcp.json` (user); Claude `<adapter-home>/.mcp.json` (project) or `claude mcp add --scope user`. Only configure hosts recorded in `ask-project`.
- One entry per tool; ids kebab-case and stable.

## Flow — Scan (MUST at install; on demand via `/ask-tools scan`)

Search **all** knowledge for anything agents need to work — read-only, no secret values:

1. **agent-knowledge:** `knowledge/**` (stack-versions, conventions, architecture, decisions, delivery/REQs, imported docs), `users/*/knowledge/**`, team + user `agents/**`, `WORKSPACE.md`, current user's work-log.
2. **Process:** `<adapter-home>/.agents/skills/**` and rules (CLIs / MCPs they invoke: `git`, `gh`, `docker`, cloud CLIs, …).
3. **Host config:** `<adapter-home>/.cursor/mcp.json`, `~/.cursor/mcp.json`, `<adapter-home>/.mcp.json`, Claude user MCP config (server names + commands only; env **keys** only), `.vscode/extensions.json`.
4. **Sibling repos** (rows in `WORKSPACE.md`): README / CONTRIBUTING, `Makefile`, `package.json` (`engines`, `packageManager`, scripts), `docker-compose*`, `.tool-versions` / `.nvmrc` / `.python-version`, `Brewfile`, `.devcontainer/`, CI workflows.

Then:

1. Merge findings with the current inventory (dedupe by id); classify `Need` (required if a skill / REQ flow / app boot depends on it).
2. Present a short grouped list (MCP · CLI · SDK · service · runtime) — new / changed / possibly obsolete, with evidence.
3. On confirm → write `knowledge/tooling/INVENTORY.md` on a branch + **PR** (rule `ask-knowledge-pr`); personal-only tools → user delta (direct).
4. Regenerate the availability rule.

Unknown install steps → look them up in official docs; do not guess commands.

## Flow — Fresh machine (MUST)

Triggers: `/ask-install` on a new product; `/ask-install` or `/ask-update` where `users/<email>/tools.local.yaml` is missing (new collaborator or new PC); `WORKSPACE.md` first-day steps.

1. Read the inventory (team ∪ user). Empty → run **Scan** first.
2. If `tools_install_mode` is `ask` or missing → ask once, in chat language:
   «There are N tools in the inventory (R required). Install them all now, or install each one when an agent first needs it?»
   - **all** → flow **Install all**.
   - **on_demand** → run `check` only (detect what is already present); install nothing else now.
3. Save the answer in `preferences.yaml` (`tools_install_mode`); create `tools.local.yaml`.
4. Regenerate the availability rule.

## Flow — Install all

1. Show the plan: missing tools (required first), the commands per tool for this OS, and the steps that need the user (sign-in, tokens, sudo, GUI installs).
2. One confirmation for the batch.
3. Per tool: Install → Configure → Verify. The agent runs non-interactive commands; for interactive auth or secrets, give the exact command and wait for the user. Write MCP config with env references, never literal secrets; do not commit host MCP files that contain secrets.
4. Record each result in `tools.local.yaml` (`installed` + date / `failed` + reason). Continue past failures; report them at the end.
5. Regenerate the availability rule; summarize installed · failed · needs user.

## Flow — On demand (MUST for every agent)

When a plan or step needs a tool:

1. Check the availability rule / `tools.local.yaml`. `installed` → use it.
2. `missing` / `unknown` → run its `Verify`. Passes → mark `installed`, continue.
3. Still missing → tell the user in one or two sentences: which tool, why it is needed now, what installing involves. Ask: install now | skip.
   - **Install now** → Install → Configure → Verify (as above); mark `installed`; regenerate the rule; continue the task.
   - **Skip** → mark `declined`; continue without it if possible, otherwise say what is blocked. Do not re-ask for the same tool in this conversation.
4. Tool **not in the inventory** → do the same, and propose adding it (`/ask-tools add`, PR). A REQ that introduces a tool must leave it in the inventory (also checked by `ask-retrospective`).

With `tools_install_mode: all`, a missing tool still follows this flow (it may be new since the last install).

## Machine status format (`tools.local.yaml`)

```yaml
machine: <hostname>
os: macos | linux | windows
checked: YYYY-MM-DD
tools:
  gh: { status: installed, verified: YYYY-MM-DD }
  figma-mcp: { status: declined }
  aws: { status: failed, note: "needs SSO profile" }
```

## Generate availability rule (MUST — contract)

Run after Scan, Fresh machine, Install, On-demand install, `check`, and by `/ask-install` / `/ask-update`.

Input: inventory (team ∪ user) + `tools.local.yaml` + recorded hosts.

| Output (generated — never hand-edit) | Content |
|--------------------------------------|---------|
| `<adapter-home>/.cursor/rules/ask-tools-available.mdc` (hosts incl. cursor) | Frontmatter `description: Tools available to agents on this machine and how to get missing ones` + `alwaysApply: true`; then one line per tool: `id — purpose — status here — Used by`; then the on-demand rule in two lines (check → verify → ask install now / skip, per skill `ask-tools`) |
| `<adapter-home>/.agents/rules/ask-tools-available.md` (always; Claude imports it from `CLAUDE.md`) | Same body, no frontmatter |

Header: `<!-- Generated by ask-tools from agent-knowledge/knowledge/tooling/INVENTORY.md + users/<email>/tools.local.yaml. Do not edit. -->`
Empty inventory → still generate with «No tools inventoried yet — run /ask-tools scan.»
The file is per machine; do not commit it to app/kit repos.

## MUST NOT

- Store secrets, tokens, or personal credentials in the inventory, `tools.local.yaml`, or generated rules.
- Install tools without the user's confirmation (batch or per tool).
- Guess install commands; use official docs when the inventory lacks them.
- Configure MCP for hosts not recorded in `ask-project`.
- Hand-edit the generated availability rule.
- Leave a tool used by a REQ out of the inventory.
