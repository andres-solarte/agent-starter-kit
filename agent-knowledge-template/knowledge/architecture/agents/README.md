# agents/

Product agent roles and RACI for orchestration (**team** map).

| Path | Role |
|------|------|
| [roles.md](./roles.md) | Team roles ↔ `agent-knowledge/agents/ask-*.md` + RACI — filled by `/ask-setup-agents` |
| Root [`agents/`](../../../agents/) | Team subagent **SoT** files |
| `users/<email>/agents/` | User-only SoT (not listed in roles.md until promoted) |

Orchestrator skill: `.agents/skills/ask-orchestrate-requirement/SKILL.md`.  
Scope rule: `ask-agent-scope`. Subagent templates (kit): `templates/role-agents/`.
