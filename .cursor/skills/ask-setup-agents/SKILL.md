---
name: ask-setup-agents
description: >-
  Analyze the workspace stack and product/business context, confirm with the
  user, then create agent-knowledge roles (RACI) and matching Cursor subagents
  under .cursor/agents/ so orchestration can delegate from day one. Use when
  the user says /ask-setup-agents, or when /ask-install runs this step after
  agent-knowledge exists.
---

# /ask-setup-agents — detect stack + create role subagents

Follow **`INSTALL.md`** → **Agent contract — setup agents**.

## Goal

From **business context + technical scan** of the multi-repo workspace, define which **role subagents** this product needs, write them into agent-knowledge, and create **Cursor subagents** under the product `.cursor/agents/` so `/ask-requirement` → `ask-orchestrate-requirement` can **Task-delegate** for real (isolated context).

**Not skills:** do **not** create `ask-role-*` under `.cursor/skills/`. Process skills (`ask-git-project`, etc.) stay skills; roles are **subagents**.

## Flow (MUST)

```text
1. Resolve kit dir, agent-knowledge dir, product .cursor/ home, sibling repos
2. Gather business signals (product name, READMEs, knowledge/product if any)
3. Scan workspace for stack/tooling signals (all sibling repos; skip kit + heavy vendor dirs)
4. Propose: user persona hint + role list + subagent names + RACI sketch
5. User yes / edit list
6. Write roles.md + create/update .cursor/agents/ask-*.md (fill frontiers)
7. Migrate away legacy ask-role-* skills if present (see below)
8. Point ask-project.mdc at roles; mark setup done
9. Close in chat language + agent-knowledge auto close-out
```

## Scan (MUST — lightweight, no secrets)

**Exclude:** kit directory, `node_modules`, `.git`, `dist`, `build`, `.next`, coverage, agent-knowledge `users/*/work-log`.

**Business signals:** root/product README, `knowledge/product/**`, domain folder names, service names in docker-compose.

**Tech signals (examples):**

| Signal | Suggests subagents |
|--------|-------------------|
| Next/React/Vue/Angular UI apps | `ask-frontend` (+ `ask-design` if design-system/storybook) |
| Nest/Express/FastAPI/Rails/Spring/Go API | `ask-backend` |
| SQL migrations, Prisma/Drizzle/TypeORM, flyway | `ask-data` |
| Terraform/Pulumi/Helm/k8s/Docker Compose/CI deploy | `ask-devops` |
| Playwright/Cypress/Detox heavy test dirs | `ask-qa` |
| Multiple of the above | fullstack / split specialists |
| Little structure, scripts everywhere | note **todero/generalist** + still create specialists that match evidence |
| Ambiguous product scope docs | `ask-product` |

Always include **`ask-tech-lead`** (orchestration companion to `ask-orchestrate-requirement`) unless the user declines.

**Persona hint (for humans):** `frontend` | `backend` | `devops` | `fullstack` | `todero` — show in the proposal for confirmation.

## Proposal format (MUST before writing)

```text
Persona hint: …
Subagents to create:
- ask-… — why (evidence: paths/deps)
- …
Will write:
- agent-knowledge/knowledge/architecture/agents/roles.md
- .cursor/agents/ask-*.md
Edit or confirm?
```

Do **not** list `.cursor/skills/ask-role-*` in the proposal.

## Write roles.md (MUST)

Path: `<agent-knowledge>/knowledge/architecture/agents/roles.md`

Include:

- Product one-liner / domain
- Persona hint (confirmed)
- Table of roles ↔ **subagent file** (`.cursor/agents/ask-….md`) ↔ primary repos/surfaces
- Default specialist order (align with `ask-orchestrate-requirement`)
- RACI sketch
- How Tech Lead delegates: **Task / subagents** + shared **skills** pack always

Use English for the durable file (`locale.content`); chat in user language.

## Write role subagents (MUST)

Source templates live in the **kit** (not merged on install):

`{{kit-directory}}/templates/role-agents/<ask-name>.md`

For each approved role:

1. Copy template → product `.cursor/agents/<ask-name>.md` if missing (product `.cursor/` home).
2. Fill `{{…}}` frontiers with scan evidence (repos, stack notes).
3. Ensure frontmatter: `name` matches file basename; strong `description` (when to delegate); `model: inherit` unless the user chose otherwise.
4. Body MUST: shared pack skills; role frontier only; return summary to parent.

If no template exists for a custom name the user approved, author a lean subagent `.md` with the same shape.

Do **not** overwrite a customized existing subagent without asking — merge missing frontiers only.

## Legacy migration (MUST when present)

If product `.cursor/skills/ask-role-*/` exists from an older kit:

1. Ensure matching `.cursor/agents/ask-*.md` exist (map `ask-role-frontend` → `ask-frontend`, etc.).
2. After subagents are in place, **delete** the legacy `ask-role-*` skill folders (migrate content into the subagent body if it has product-specific MUSTS not yet in the agent file).
3. Do not leave pointer stubs.

## Record in ask-project.mdc

```markdown
## Agents
- Roles: `agent-knowledge/knowledge/architecture/agents/roles.md`
- Subagents: `.cursor/agents/ask-*.md`
- Setup: done (date)
- Update notice for /ask-setup-agents: done
```

## MUST NOT

- Invent roles with no evidence and no user confirmation.
- Create dozens of vague roles — prefer a small set that matches the business + scan.
- Create role **skills** (`ask-role-*`) instead of subagents.
- Put role protocol only in chat — must land in files.
- Commit/push **app/kit** unless asked (agent-knowledge auto close-out still applies).
- Run `/ask-centralize-docs` unless the user asks.

## Close

List subagents + paths created; persona hint; remind orchestration delegates via Task / `/ask-frontend` etc. on `/ask-requirement`.

Then run **`ask-git-project` → agent-knowledge auto close-out**.
