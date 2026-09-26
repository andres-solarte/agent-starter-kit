# agent-starter-kit

Reusable process engine for coding agents (**Cursor** and **Claude Code**): skill discipline, communication, focus/scope, requirement orchestration, and the **agent-knowledge** template (memory separate from the kit).

Does not include stack skills (framework, testing, DB) — those are added per project.

> **Install:** `/ask-install` (asks for directories + **agent hosts**: cursor / claude / both).  
> **Setup agents:** `/ask-setup-agents` (surfaces → roles + host `agents/`).  
> **Centralize docs (manual):** `/ask-centralize-docs`.  
> **Update:** `git pull` in the kit + `/ask-update`.  
> **Uninstall:** `/ask-uninstall`.  
> Guide: **[INSTALL.md](INSTALL.md)**.

## What's here

```text
.agents/
  skills/    — canonical ask-* skills (SoT)
  rules/     — plain rules for Claude (+ sync from .cursor/rules)
.cursor/
  skills → ../.agents/skills
  rules/     — Cursor .mdc rules
.claude/
  skills → ../.agents/skills
  rules  → ../.agents/rules
templates/role-agents/   — subagent stubs for /ask-setup-agents
agent-knowledge-template/
INSTALL.md
CLAUDE.md                — Claude Code entry for this kit repo
```

Claude-only product installs receive **`.agents/` + `.claude/`** only — **not** `.cursor/`.

## Layout after install

| Piece | Updates via |
|-------|-------------|
| Kit clone | `git pull` + `/ask-update` |
| Product `.agents/` + host adapters | Merged from kit per recorded hosts |
| `agent-knowledge/` | Product’s own remote; not replaced by kit updates |
| Team multi-root | `agent-knowledge/WORKSPACE.md` — clone memory first, then siblings |

## Language

- Default English for code, commits, paths, durable docs.
- `agent-knowledge/config.yaml` → `locale.content` / `locale.paths`.
- Per-user chat: `users/<email>/preferences.yaml` → `communication_language`.

## Commands

| Slash | For |
|-------|-----|
| `/ask-install` | Wire-up (dirs + hosts; runs setup agents) |
| `/ask-setup-agents` | Surfaces → roles + subagents (full or delta) |
| `/ask-centralize-docs` | Scan workspace → copy docs → recommend cleanup |
| `/ask-update` | Pull kit + re-merge selected hosts |
| `/ask-uninstall` | Remove wiring |
| `/ask-question` | Triage (may become requirement or fix) |
| `/ask-requirement` | Product work + REQ registry |
| `/ask-requirement-fix` | Error on same / existing REQ |
| `/ask-backlog` | Personal parked notes |

## Contributing upstream

Process improvements without business/personal content → PR to this repo. Product memory stays in `agent-knowledge` only.
