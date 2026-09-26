# agents/ — team role subagents (SoT)

**Team-scoped** role subagents for this product. Tracked in git with agent-knowledge. Changes to this directory land via **pull request** (rule `ask-knowledge-pr`), not direct push to the default branch.

| Path | Scope |
|------|--------|
| `agents/ask-*.md` (this directory) | **Team** — listed in `knowledge/architecture/agents/roles.md` |
| `users/<email>/agents/ask-*.md` | **User-only** — personal; not team SoT |

Hosts (`.cursor/agents/`, `.claude/agents/`) are **runtime mirrors**. Do not treat the adapter-home copies as the source of truth.

Created/updated by `/ask-setup-agents`. **Always** ask user-only vs team before write (rule `ask-agent-scope`).

Templates: kit `templates/role-agents/`.
