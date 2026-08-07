# Agent roles (product)

Filled by `/ask-setup-agents` (or manually). Used by `ask-orchestrate-requirement`.

## Product

- **Name:** {{PRODUCT_NAME}}
- **One-liner:** {{…}}
- **Persona hint:** {{frontend|backend|devops|fullstack|todero}}

## Roles

| Role | Skill | Primary surfaces / repos | Notes |
|------|-------|--------------------------|-------|
| Tech Lead | `ask-role-tech-lead` | orchestration | Always with shared pack |
| … | `ask-role-…` | … | … |

## Default specialist order

```text
Data → Backend → Frontend → Design system? → QA → DevOps (as needed)
```

Adjust to this product after setup.

## RACI (typical feature)

| Concern | R | C | I |
|---------|---|---|---|
| Scope / MVP | Product | Tech Lead | … |
| Schema | Data | Backend | … |
| API contract | Backend | Frontend, Data | … |
| UI | Frontend | Design, Backend | … |
| E2E | QA | Frontend, Backend | … |
| Deploy / env | DevOps | Tech Lead | … |

## Delegation

- Shared pack on every role: `ask-agent-skill-discipline`, `ask-git-project`, `ask-agent-knowledge`.
- Tech Lead / `ask-orchestrate-requirement` assigns **role skills** + scoped subagents (one point at a time).
- Missing role skill → `SKILL GAP` (do not improvise).
