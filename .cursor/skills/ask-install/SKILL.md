---
name: ask-install
description: >-
  Install agent-starter-kit as an updatable dependency: ask where the kit and
  agent-knowledge directories should live, merge .cursor into the chosen product
  home, instantiate agent-knowledge as a NEW git repo. Use when the user says
  /ask-install, "install this kit", or wants to wire the kit into their workspace.
---

# /ask-install — install kit (updatable dependency)

Follow **`INSTALL.md` at the kit root** → **Agent contract — install**.

## Model (MUST)

| Path (user-chosen) | Action |
|--------------------|--------|
| **Kit directory** | Clone or use existing kit; keep `.git` + upstream. |
| **agent-knowledge directory** | Copy template → **new** `git init` (outside kit). |
| **Product `.cursor/` home** | Merge kit rules/skills (default: parent of agent-knowledge). |

Global knowledge → `…/knowledge/`. Per-user → `…/users/<email>/` under the chosen agent-knowledge directory.

## Flow (MUST)

```text
1. Q&A: kit dir + agent-knowledge dir (+ .cursor home if needed)
2. Summary of paths → yes
3. Ensure kit; merge .cursor/; create agent-knowledge; fill prefs
4. Record paths for /ask-update; close
```

## Q&A (MUST — directories first)

| Ask | Default if skipped |
|-----|--------------------|
| **Kit directory** | Fail — must choose (or confirm existing kit path in workspace) |
| **agent-knowledge directory** | Fail — must choose (must not be inside kit dir) |
| **Product `.cursor/` home** | Parent of agent-knowledge directory |
| Project name | `.cursor/` home folder name |
| Sibling repos | Empty |
| `communication_language` | `en` |

Do **not** assume `./agent-knowledge` or “next to the kit” without asking.

## Merge policy

- Do not use the kit directory as the product `.cursor/` home.
- Do not overwrite product stack skills/rules without explicit ask.
- Do not delete kit `.git`.

## MUST NOT

- Long manual instead of performing install.
- Commit/push unless asked.
- Wipe an existing agent-knowledge with data — ask first.

## Close

Echo the three directories; `/ask-requirement`, `/ask-backlog`, `/ask-update`.
