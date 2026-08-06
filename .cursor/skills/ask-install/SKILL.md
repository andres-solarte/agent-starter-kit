---
name: ask-install
description: >-
  Install agent-starter-kit as an updatable dependency: keep kit git/upstream,
  merge .cursor into product home, instantiate agent-knowledge as a NEW product
  git repo. Use when the user says /ask-install, "install this kit", or wants
  to wire the kit into their working environment.
---

# /ask-install — install kit (updatable dependency)

Follow **`INSTALL.md` at the kit root** → **Agent contract — install**.

## Model (MUST)

| Path | Action |
|------|--------|
| Kit clone | Keep `.git` + upstream `origin`. Never re-init as product remote. |
| Product `.cursor/` | Merge kit rules/skills (safe merge). |
| `agent-knowledge/` | Copy template → **new** `git init` (product memory remote later). |

Global knowledge → `agent-knowledge/knowledge/`. Per-user → `agent-knowledge/users/<email>/`.

## Flow (MUST)

```text
1. Resolve kit root + product home
2. Q&A (max 4) + summary → yes
3. Merge .cursor/; instantiate agent-knowledge as new git repo; fill 00-project + prefs
4. Close: paths + /ask-requirement, /ask-backlog, later /ask-update
```

## Q&A

| Ask | Default if skipped |
|-----|--------------------|
| Product home path | Fail if ambiguous |
| Project name | Product home folder name |
| Sibling repos | Empty |
| `communication_language` | `en` |

## Merge policy

- Do not install into the kit folder as product home.
- Do not overwrite product stack skills/rules without explicit ask.
- Do not delete kit `.git`.

## MUST NOT

- Long manual instead of performing install.
- Commit/push unless asked.
- Reset or replace an existing `agent-knowledge` with personal data — ask first.

## Close

Where kit / product `.cursor` / `agent-knowledge` live; how to `/ask-update`.
