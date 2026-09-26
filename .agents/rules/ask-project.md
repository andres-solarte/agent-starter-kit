# {{PROJECT_NAME}}

{{Short description of the product and its current scope (MVP, modules, etc.)}}. Code in {{sibling repos, if multi-repo}}.

## Language (technical)

- Code, commits, technical names, and **URL paths**: **English by default**
- Durable agent-written knowledge/docs follow `agent-knowledge/config.yaml` → `locale.content` (default `en`)
- Paths and identifiers: `locale.paths` (always `en`)
- Chat language with the user is **per-user**, not project-wide — see rule `ask-user-communication` and `users/<email>/preferences.yaml`

## Documentation

→ SoT: `agent-knowledge/` (`AGENTS.md`, `knowledge/`)
→ Process: `knowledge/delivery/PROCESS.md` · what's next: `knowledge/delivery/NEXT.md`
→ Requirements: `knowledge/delivery/requirements/` (`INDEX.md` + `REQ-NNN-*.md`)

No commits or PRs of **app/kit** repos unless the user explicitly asks (agent-knowledge auto close-out still applies).

## Kit paths

- Kit directory: {{KIT_DIR}}
- agent-knowledge directory: {{AGENT_KNOWLEDGE_DIR}}
- Product adapter home: {{ADAPTER_HOME}}
- Agent hosts: {{cursor|claude|both}}

## Agents

- Roles: `agent-knowledge/knowledge/architecture/agents/roles.md`
- Team SoT: `agent-knowledge/agents/ask-*.md`
- User SoT: `agent-knowledge/users/<email>/agents/ask-*.md`
- Host mirrors: `.cursor/agents/` and/or `.claude/agents/` (materialized; not SoT)
- Skills SoT: `.agents/skills/`
- Scope: always ask user-only vs team on create/modify (`ask-agent-scope`)
- Setup: {{pending|done}} ({{date if done}})
- Update notice for /ask-setup-agents: {{pending|done}}
- Known surfaces: {{comma-separated workspace-relative repo paths from last setup scan}}
