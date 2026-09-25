# role-agents/

Canonical stubs for product **Cursor subagents** (`.cursor/agents/*.md`). Not merged wholesale on install.

`/ask-setup-agents` copies **approved** roles into the product `.cursor/agents/` and fills frontiers from the workspace scan.

These are **subagents** (isolated context, Task / `/name` delegation) — **not** skills. Process skills stay under `.cursor/skills/` (`ask-git-project`, `ask-requirement`, etc.).

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
