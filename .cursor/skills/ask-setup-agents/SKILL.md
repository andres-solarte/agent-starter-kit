---
name: ask-setup-agents
description: >-
  Analyze the workspace stack and product/business context, confirm with the
  user, then create agent-knowledge roles (RACI) and matching ask-role-* Cursor
  skills so orchestration can delegate from day one. Use when the user says
  /ask-setup-agents, or when /ask-install runs this step after agent-knowledge
  exists.
---

# /ask-setup-agents — detect stack + create role agents

Follow **`INSTALL.md`** → **Agent contract — setup agents**.

## Goal

From **business context + technical scan** of the multi-repo workspace, define which **sub-agents / roles** this product needs, write them into agent-knowledge, and create **role skills** under the product `.cursor/skills/` so `/ask-requirement` → `ask-orchestrate-requirement` can delegate for real.

## Flow (MUST)

```text
1. Resolve kit dir, agent-knowledge dir, product .cursor/ home, sibling repos
2. Gather business signals (product name, READMEs, knowledge/product if any)
3. Scan workspace for stack/tooling signals (all sibling repos; skip kit + heavy vendor dirs)
4. Propose: user persona hint + role list + skill names + RACI sketch
5. User yes / edit list
6. Write roles.md + create/update ask-role-* skills (stubs with real MUST for this stack)
7. Point ask-project.mdc at roles; mark setup done
8. Close in chat language
```

## Scan (MUST — lightweight, no secrets)

**Exclude:** kit directory, `node_modules`, `.git`, `dist`, `build`, `.next`, coverage, agent-knowledge `users/*/work-log`.

**Business signals:** root/product README, `knowledge/product/**`, domain folder names, service names in docker-compose.

**Tech signals (examples):**

| Signal | Suggests roles |
|--------|----------------|
| Next/React/Vue/Angular UI apps | `ask-role-frontend` (+ `ask-role-design` if design-system/storybook) |
| Nest/Express/FastAPI/Rails/Spring/Go API | `ask-role-backend` |
| SQL migrations, Prisma/Drizzle/TypeORM, flyway | `ask-role-data` |
| Terraform/Pulumi/Helm/k8s/Docker Compose/CI deploy | `ask-role-devops` |
| Playwright/Cypress/Detox heavy test dirs | `ask-role-qa` |
| Multiple of the above | fullstack / split specialists |
| Little structure, scripts everywhere | note **todero/generalist** + still create the specialists that match evidence |
| Ambiguous product scope docs | `ask-role-product` |

Always include **`ask-role-tech-lead`** (orchestration companion to `ask-orchestrate-requirement`) unless the user declines.

**Persona hint (for humans, not a skill):** `frontend` | `backend` | `devops` | `fullstack` | `todero` — derived from which surfaces dominate; show in the proposal for confirmation.

## Proposal format (MUST before writing)

```text
Persona hint: …
Roles to create:
- ask-role-… — why (evidence: paths/deps)
- …
Will write:
- agent-knowledge/knowledge/architecture/agents/roles.md
- .cursor/skills/ask-role-*/SKILL.md
Edit or confirm?
```

## Write roles.md (MUST)

Path: `<agent-knowledge>/knowledge/architecture/agents/roles.md`

Include:

- Product one-liner / domain
- Persona hint (confirmed)
- Table of roles ↔ skill path ↔ primary repos/surfaces
- Default specialist order (align with `ask-orchestrate-requirement`)
- RACI sketch (Responsible / Consulted per role for typical feature)
- How Tech Lead delegates (subagents + role skills; shared pack always)

Use English for the durable file (`locale.content`); chat in user language.

## Write role skills (MUST)

Source templates live in the **kit** (not merged on install):

`{{kit-directory}}/templates/role-skills/<ask-role-name>/SKILL.md`

For each approved role:

1. Copy template → product `.cursor/skills/<ask-role-name>/SKILL.md` if missing.
2. Fill `{{…}}` frontiers with scan evidence (repos, stack notes).
3. Ensure frontmatter: `name` matches folder; `disable-model-invocation: true`.
4. MUST: shared pack (`ask-agent-skill-discipline`, `ask-git-project`, `ask-agent-knowledge`); role frontier only; done-when for this stack.

If no template exists for a custom role name the user approved, author a lean skill with the same shape (do not invent empty fluff).

Do **not** overwrite a customized existing `ask-role-*` without asking — merge missing MUSTS / frontiers only.

## Record in ask-project.mdc

Add/update:

```markdown
## Agents
- Roles: `agent-knowledge/knowledge/architecture/agents/roles.md`
- Setup: done (date)
- Update notice for /ask-setup-agents: done
```

(`Update notice: done` means `/ask-update` should **not** re-announce the skill.)

## MUST NOT

- Invent roles with no evidence and no user confirmation.
- Create dozens of vague roles — prefer a small set that matches the business + scan.
- Put role protocol only in chat — must land in files.
- Commit/push unless asked.
- Run `/ask-centralize-docs` unless the user asks.

## Close

List roles + skill paths created; persona hint; remind orchestration uses these on `/ask-requirement`.

Then run **`ask-git-project` → agent-knowledge auto close-out** (commit + push if `origin` exists) for tracked roles/docs written in this step.
