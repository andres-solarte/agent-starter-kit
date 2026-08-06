# agent-starter-kit

Reusable process engine for coding agents (Cursor, Claude Code, etc.): skill discipline, communication, focus/scope, requirement orchestration, and the **agent-knowledge** template (memory separate from the kit).

Does not include stack skills or `speckit-*` — those are added per project.

> **Install:** clone this repo (keep git/upstream), add it to the workspace, then `/ask-install`.  
> **Update later:** `git pull` in the kit + `/ask-update`.  
> Guide: **[INSTALL.md](INSTALL.md)**.

## What's here

```text
.cursor/
  rules/     — process rules
  skills/    — ask-install, ask-update, ask-requirement, ask-backlog, …
agent-knowledge-template/
  — skeleton for a NEW product git repo (global + per-user memory)
INSTALL.md   — dependency install + update contracts
```

## Layout after install

| Piece | Updates via |
|-------|-------------|
| Kit clone in workspace | `git pull` + `/ask-update` |
| Product `.cursor/` | Merged from kit; overlays stay local |
| `agent-knowledge/` | Product’s own remote; not replaced by kit updates |

## Language

- Default English for code, commits, paths, durable docs.
- `agent-knowledge/config.yaml` → `locale.content` / `locale.paths`.
- Per-user chat: `users/<email>/preferences.yaml` → `communication_language`.

## Commands

| Slash | For |
|-------|-----|
| `/ask-install` | First-time wire-up |
| `/ask-update` | Pull kit + safe re-merge |
| `/ask-requirement` | Product work |
| `/ask-backlog` | Park ideas |

## Contributing upstream

Process improvements without business/personal content → PR to this repo. Product memory stays in `agent-knowledge` only.
