# agents/ — user-only role subagents

Personal role subagents for **this user only** (`users/<email>/agents/ask-*.md`).

- Tracked in agent-knowledge (roaming across your machines via `git pull`) — **direct** commit/push OK.
- **Not** team SoT — do not list in global `roles.md` unless **promoted** (user confirms team scope + **PR** into `agents/`).
- Materialized into host `.cursor/agents/` / `.claude/agents/` on this machine together with team agents.

Before create/modify: ask user-only vs team (rule `ask-agent-scope` / `/ask-setup-agents`).
