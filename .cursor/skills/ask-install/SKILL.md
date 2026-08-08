---
name: ask-install
description: >-
  Install agent-starter-kit as an updatable dependency: ask where the kit and
  agent-knowledge directories should live, merge .cursor into the chosen product
  home, instantiate agent-knowledge as a NEW git repo, then run
  /ask-setup-agents. Doc scan is separate (/ask-centralize-docs). Use when the
  user says /ask-install, "install this kit", or wants to wire the kit into
  their workspace.
---

# /ask-install — install kit (updatable dependency)

Follow **`INSTALL.md` at the kit root** → **Agent contract — install**.

## Model (MUST)

| Path (user-chosen) | Action |
|--------------------|--------|
| **Kit directory** | Clone or use existing kit; keep `.git` + upstream. |
| **agent-knowledge directory** | Copy template → **new** `git init` (outside kit). |
| **Product `.cursor/` home** | Merge kit rules/skills (default: parent of agent-knowledge). |

Global knowledge → `…/knowledge/`. Per-user → `…/users/<email>/`.

## Flow (MUST)

```text
1. Q&A: kit dir + agent-knowledge dir (+ .cursor home if needed)
2. Summary of paths → yes
3. Ensure kit; merge .cursor/; create agent-knowledge; fill prefs + session-backlog
4. Run /ask-setup-agents (scan → propose roles → write roles.md + .cursor/agents/ask-*.md)
5. Record paths; close — do NOT prompt for doc scan
```

## Q&A (MUST — directories first)

| Ask | Default if skipped |
|-----|--------------------|
| **Kit directory** | Fail — must choose |
| **agent-knowledge directory** | Fail — must choose (not inside kit) |
| **Product `.cursor/` home** | Parent of agent-knowledge |
| Project name | `.cursor/` home folder name |
| Sibling repos | Empty |
| `communication_language` | `en` |

## Setup agents (MUST)

After agent-knowledge exists and paths are recorded, **run** `.cursor/skills/ask-setup-agents/SKILL.md` in the same install session (user confirmation of the role proposal still required). Do not skip unless the user explicitly declines (“skip agent setup”); if skipped, leave `Update notice for /ask-setup-agents: pending` in `ask-project.mdc`.

## Doc centralization

**Do not** prompt for a workspace doc scan during install. Mention `/ask-centralize-docs` once in the close if useful. Always merge the `ask-centralize-docs` skill so it is available.

## Merge policy

- Do not use the kit directory as the product `.cursor/` home.
- Do not overwrite product stack skills/rules without explicit ask.
- Do not delete kit `.git`.
- Always merge skills `ask-centralize-docs` and `ask-setup-agents` with the kit.
- Do **not** merge `templates/role-agents/` into product `.cursor/agents/` wholesale — `/ask-setup-agents` copies only approved subagents.

## MUST NOT

- Long manual instead of performing install.
- Commit/push unless asked.
- Start a doc scan unless the user explicitly runs `/ask-centralize-docs`.
- Wipe an existing agent-knowledge with data — ask first.

## Close

Echo the three directories; roles created (or skipped); optional one line that docs scan is `/ask-centralize-docs`; `/ask-requirement`, `/ask-update`.
