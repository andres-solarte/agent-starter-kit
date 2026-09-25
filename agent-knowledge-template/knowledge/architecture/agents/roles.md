# Agent roles (product)

Filled by `/ask-setup-agents` (or manually). Used by `ask-orchestrate-requirement`.

## Product

- **Name:** {{PRODUCT_NAME}}
- **One-liner:** {{…}}
- **Persona hint:** {{frontend|backend|mobile|devops|fullstack|todero}}
- **Granularity:** {{type | per-surface}} (when multiple surfaces share a specialty)

## Surfaces

| Path | Kind | Subagent | Notes |
|------|------|----------|-------|
| … | web-ui / api / mobile / data / infra / … | `.cursor/agents/ask-….md` | … |

## Roles

| Role | Subagent | Primary surfaces / repos | Notes |
|------|----------|--------------------------|-------|
| Tech Lead | `.cursor/agents/ask-tech-lead.md` | orchestration | Always with shared skills pack |
| … | `.cursor/agents/ask-….md` | … | … |

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

- **Roles = Cursor subagents** under `.cursor/agents/ask-*.md` (Task tool / `/name`). Isolated context.
- **Shared skills pack** (same agent procedures, not subagents): `ask-agent-skill-discipline`, `ask-git-project`, `ask-agent-knowledge`.
- Tech Lead / `ask-orchestrate-requirement` delegates **one point** per turn to the matching subagent.
- **Uncovered surface** (new repo/app with no agent) → `/ask-setup-agents` delta (ask type vs per-surface); do not improvise a fake role.
