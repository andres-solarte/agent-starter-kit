# Agent roles (product)

Filled by `/ask-setup-agents` (or manually). Used by `ask-orchestrate-requirement`.

## Product

- **Name:** {{PRODUCT_NAME}}
- **One-liner:** {{…}}
- **Persona hint:** {{frontend|backend|devops|fullstack|todero}}

## Roles

| Role | Subagent | Primary surfaces / repos | Notes |
|------|----------|--------------------------|-------|
| Tech Lead | `.cursor/agents/ask-tech-lead.md` | orchestration | Always with shared skills pack |
| … | `.cursor/agents/ask-….md` | … | … |

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

- **Roles = Cursor subagents** under `.cursor/agents/ask-*.md` (Task tool / `/name`). Isolated context.
- **Shared skills pack** (same agent procedures, not subagents): `ask-agent-skill-discipline`, `ask-git-project`, `ask-agent-knowledge`.
- Tech Lead / `ask-orchestrate-requirement` delegates **one point** per turn to the matching subagent.
- Missing subagent for a needed role → run `/ask-setup-agents` or add the `.md` (do not improvise a fake role).
