---
name: ask-install
description: >-
  Install this agent-starter-kit into the product workspace: merge .cursor
  rules/skills, instantiate agent-knowledge, fill placeholders and per-user
  prefs. Use when the user says /ask-install, "install this kit", "adopt
  agent-starter-kit", or wants to wire the kit into their working environment.
---

# /ask-install — install kit into product workspace (user)

Single entry to **install** this kit into the product environment. Follow **`INSTALL.md` at the kit repository root** — especially **Agent contract**.

This skill lives in the **kit** repo. After install, a copy also exists under the product’s `.cursor/skills/ask-install/` so re-runs (merge / repair) stay available.

## When to use

- User cloned this repo and added it to the Cursor workspace.
- User asks to adopt/install the kit into “this workspace” / “my working environment”.
- User runs `/ask-install`.

## Flow (MUST)

```text
1. Resolve kit root (folder with INSTALL.md + agent-knowledge-template/)
2. Resolve product home (where .cursor/ and agent-knowledge/ should live)
3. Q&A (max 4) + short summary → user yes
4. Merge .cursor/ ; instantiate agent-knowledge ; fill 00-project + prefs
5. Close: paths + how to use /ask-requirement and /ask-backlog
```

Do **not** start copying before the user’s yes on the summary.

## Q&A (blocking)

Ask only what is unknown:

| Ask | Default if skipped |
|-----|--------------------|
| Product home path | Fail — must be unambiguous |
| Project name | Folder name of product home |
| Sibling repos in workspace | Empty list |
| `communication_language` | `en` |

## Merge policy (MUST)

- Never install *into* the kit repo as the product.
- Never overwrite product stack rules/skills without explicit ask.
- Copy missing kit files; on conflict keep product and merge critical process MUSTS if absent.
- SoT for protocol remains `agent-knowledge/AGENTS.md` after instantiate.

## Source of truth

1. This skill  
2. Kit root `INSTALL.md` → **Agent contract**  
3. After install: product `agent-knowledge/AGENTS.md`

## MUST NOT

- Long manual dump to the user instead of performing the install.
- Commit/push unless asked.
- Adopt `ai-dev-standard` in this skill (mention only; separate doc).

## Close (user chat language)

2–4 sentences: what was installed and where; `/ask-requirement` for work; `/ask-backlog` to park; optional “you can keep this kit folder in the workspace as upstream.”
