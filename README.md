# agent-starter-kit

Reusable process engine for coding agents (Cursor, Claude Code, etc.): skill discipline, communication, focus/scope, requirement orchestration, and the **agent-knowledge** template (memory separate from the kit).

Does not include stack skills (framework, testing, DB) — those are added per project.

> **Install:** `/ask-install` (asks for directories; runs `/ask-setup-agents`).  
> **Setup agents:** `/ask-setup-agents` (stack + business → roles + `.cursor/agents/` subagents).  
> **Centralize docs (manual):** `/ask-centralize-docs` (scan → copy into agent-knowledge → recommend deleting originals).  
> **Update:** `git pull` in the kit directory + `/ask-update`.  
> **Uninstall:** `/ask-uninstall` (asks what to remove; memory kept by default).  
> Guide: **[INSTALL.md](INSTALL.md)**.

## What's here

```text
.cursor/
  rules/     — process rules (`ask-*.mdc`)
  skills/    — ask-install, ask-setup-agents, ask-centralize-docs, ask-update, …
templates/
  role-agents/ — ask-*.md subagent stubs copied into .cursor/agents/ by /ask-setup-agents
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
| `/ask-install` | First-time wire-up (asks for directories; runs setup agents) |
| `/ask-setup-agents` | Detect stack/surfaces → roles.md + Cursor subagents (also delta for new repos) |
| `/ask-centralize-docs` | Scan workspace → copy docs → recommend cleanup |
| `/ask-update` | Pull kit + safe re-merge (once: mention setup agents) |
| `/ask-uninstall` | Remove wiring (asks what to delete) |
| `/ask-question` | Ask the framework / default triage (may become a requirement) |
| `/ask-requirement` | Product work + REQ registry (`backlog` / `in_progress` / `closed`) |
| `/ask-requirement-fix` | Error on same / existing REQ (skip full re-plan) |
| `/ask-backlog` | Personal parked notes (not the REQ registry) |

## Contributing upstream

Process improvements without business/personal content → PR to this repo. Product memory stays in `agent-knowledge` only.
