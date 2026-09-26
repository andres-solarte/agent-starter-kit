# Agent roles (product)

Filled by `/ask-setup-agents` (or manually). Used by `ask-orchestrate-requirement`.

**Team agents only** in this file. User-only agents live under `users/<email>/agents/` and are not listed here until promoted (rule `ask-agent-scope`).

## Product

- **Name:** {{PRODUCT_NAME}}
- **One-liner:** {{…}}
- **Persona hint:** {{frontend|backend|mobile|devops|fullstack|todero}}
- **Granularity:** {{type | per-surface}} (when multiple surfaces share a specialty)

## Surfaces

| Path | Kind | Team subagent (SoT) | Notes |
|------|------|---------------------|-------|
| … | web-ui / api / mobile / data / infra / … | `agents/ask-….md` | … |

## Roles

| Role | Subagent SoT | Primary surfaces / repos | Notes |
|------|--------------|--------------------------|-------|
| Tech Lead | `agents/ask-tech-lead.md` | orchestration | Materialized to host `agents/` |
| … | `agents/ask-….md` | … | … |

## Default specialist order

```text
Data → Backend → Frontend → Mobile? → Design system? → QA → DevOps (as needed)
```

Adjust to this product after setup.

## RACI (typical feature)

| Concern | R | C | I |
|---------|---|---|---|
| Scope / MVP | Product | Tech Lead | … |
| Schema | Data | Backend | … |
| API contract | Backend | Frontend, Mobile, Data | … |
| Web UI | Frontend | Design, Backend | … |
| Mobile UI | Mobile | Backend, Design | … |
| E2E | QA | Frontend, Mobile, Backend | … |
| Deploy / env | DevOps | Tech Lead | … |

## Delegation

- **Team SoT** = `agent-knowledge/agents/ask-*.md` (git). **User SoT** = `users/<email>/agents/ask-*.md`.
- **Host mirrors** = `.cursor/agents/` and/or `.claude/agents/` (materialized; may be outside git).
- Create/modify → **always** ask user-only vs team (`ask-agent-scope`).
- **Shared skills pack:** `ask-agent-skill-discipline`, `ask-git-project`, `ask-agent-knowledge`.
- Tech Lead / `ask-orchestrate-requirement` delegates **one point** per turn to the matching subagent.
- **Uncovered surface** → `/ask-setup-agents` delta (granularity + scope); do not improvise a fake role.
