# role-agents/

Canonical stubs for product **role subagents**. Not merged wholesale on install.

`/ask-setup-agents` copies **approved** roles into **agent-knowledge SoT** (team `agents/` or user `users/<email>/agents/`) after asking **user-only vs team**, then **materializes** into `.cursor/agents/` and/or `.claude/agents/` (per install hosts).

These are **subagents** (isolated context) — **not** skills. Process skills live under `.agents/skills/`.

| Template file | `name` | Typical when |
|---------------|--------|----------------|
| `ask-tech-lead.md` | `ask-tech-lead` | Always (unless declined) |
| `ask-frontend.md` | `ask-frontend` | Web UI apps |
| `ask-mobile.md` | `ask-mobile` | Mobile apps (RN/Flutter/native) |
| `ask-backend.md` | `ask-backend` | API services |
| `ask-data.md` | `ask-data` | Migrations / ORM / SQL |
| `ask-devops.md` | `ask-devops` | CI, containers, IaC |
| `ask-qa.md` | `ask-qa` | E2E / test harness |
| `ask-product.md` | `ask-product` | Scope / BDR heavy |
| `ask-design.md` | `ask-design` | Design system / Storybook |
