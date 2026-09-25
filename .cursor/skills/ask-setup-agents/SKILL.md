---
name: ask-setup-agents
description: >-
  Analyze the workspace stack and product/business context, confirm with the
  user, then create agent-knowledge roles (RACI) and matching Cursor subagents
  under .cursor/agents/. Re-run when surfaces change: proposes agents for new
  repos/apps (asks type vs per-surface granularity). Use for /ask-setup-agents,
  /ask-install after agent-knowledge exists, /ask-update when new repos appear,
  or mid-requirement when a surface has no agent.
---

# /ask-setup-agents — detect stack + create role subagents

Follow **`INSTALL.md`** → **Agent contract — setup agents**.

## Goal

From **business context + technical scan** of the multi-repo workspace, define which **role subagents** this product needs, write them into agent-knowledge, and create **Cursor subagents** under the product `.cursor/agents/` so orchestration can **Task-delegate** for real.

Also used to **fill gaps** when a **new surface** (repo/app) appears or a REQ touches a surface with no matching agent.

**Not skills:** do **not** create `ask-role-*` under `.cursor/skills/`. Process skills stay skills; roles are **subagents**.

## Flow (MUST)

```text
1. Resolve kit dir, agent-knowledge dir, product .cursor/ home, sibling repos
2. Inventory surfaces (repos/apps) + existing .cursor/agents/ask-*.md + roles.md
3. Gather business + stack signals (skip kit + heavy vendor dirs)
4. Diff: surfaces without coverage → candidate agents
5. Ask granularity if >1 surface shares a specialty (type vs per-surface)
6. Propose: persona hint + create/update list + RACI sketch
7. User yes / edit
8. Write roles.md + .cursor/agents/ask-*.md; record Known surfaces in ask-project.mdc
9. Legacy ask-role-* skill migration if needed
10. Close + agent-knowledge auto close-out
```

### Modes

| Mode | When | Scope |
|------|------|--------|
| **Full** | Install / explicit `/ask-setup-agents` / user asks full refresh | All surfaces |
| **Delta** | `/ask-update` found new repos; mid-REQ agent gap | Only uncovered / new surfaces (still confirm) |

## Scan (MUST — lightweight, no secrets)

**Exclude:** kit directory, `node_modules`, `.git`, `dist`, `build`, `.next`, coverage, agent-knowledge `users/*/work-log`.

**Surface inventory:** each sibling app/service repo (or package) with evidence of a deliverable (app, API, mobile, worker, etc.). Record path + kind (web-ui, api, mobile, data, infra, …).

**Business signals:** root/product README, `knowledge/product/**`, domain folder names, docker-compose services.

**Tech signals (examples):**

| Signal | Suggests specialty |
|--------|-------------------|
| Next/React/Vue/Angular UI | frontend |
| Nest/Express/FastAPI/Rails/Spring/Go API | backend |
| React Native / Flutter / Swift / Kotlin / Expo | mobile |
| SQL migrations, Prisma/Drizzle/TypeORM | data |
| Terraform/Pulumi/Helm/k8s/Docker/CI deploy | devops |
| Playwright/Cypress/Detox heavy tests | qa |
| Design system / Storybook / tokens | design |
| Ambiguous product scope docs | product |

Always prefer including **`ask-tech-lead`** unless declined.

**Persona hint:** `frontend` | `backend` | `devops` | `fullstack` | `mobile` | `todero` — show for confirmation.

## Coverage gap (MUST)

A surface is **uncovered** when:

- No `.cursor/agents/ask-*.md` lists it in Frontier / primary repos, **and**
- `roles.md` has no row mapping that surface to a subagent

For each uncovered surface, propose a specialist whose **nature and scope** match the surface (mobile app → mobile specialist, not a generic frontend web agent unless the user merges them).

## Granularity (MUST ask when relevant)

When **two or more** surfaces share a specialty (e.g. two mobile apps, or three Nest APIs):

Ask once (chat language):

```text
For these surfaces (…): prefer
(A) one agent per type (e.g. ask-mobile covering all mobile repos), or
(B) one agent per surface/repo (e.g. ask-buyer-mobile, ask-driver-mobile)?
```

Do not assume A or B. Record the choice in `roles.md` Notes.

If only one surface per specialty → default to type-named agent (`ask-mobile`, `ask-frontend`, …) unless the user wants a surface-specific name.

## Proposal format (MUST before writing)

```text
Mode: full | delta
Persona hint: …
Surfaces found:
- path — kind — covered by ask-… | UNCOVERED
Granularity: A (type) | B (per surface) | n/a
Subagents to create/update:
- ask-… — why (evidence) — frontiers: …
Will write:
- agent-knowledge/knowledge/architecture/agents/roles.md
- .cursor/agents/ask-*.md
Edit or confirm?
```

Do **not** list `.cursor/skills/ask-role-*` in the proposal.  
Do **not** create agents for uncovered surfaces without confirmation.

## Write roles.md (MUST)

Path: `<agent-knowledge>/knowledge/architecture/agents/roles.md`

Include:

- Product one-liner / domain
- Persona hint + granularity choice
- **Surfaces** table: path ↔ kind ↔ subagent
- Roles ↔ subagent file ↔ primary repos
- Default specialist order
- RACI sketch
- Delegation: Task / subagents + shared skills pack

English for durable file; chat in user language.

## Write role subagents (MUST)

Templates: `{{kit-directory}}/templates/role-agents/<ask-name>.md`

For each approved agent:

1. Copy template if missing (or author lean custom `.md` for surface-specific names).
2. Fill frontiers with **exact** repos/paths from the scan.
3. Frontmatter: `name` = basename; strong `description`; `model: inherit` unless chosen otherwise.
4. Body: shared pack; frontier only; return summary to parent.

Do **not** overwrite customized agents without asking — merge frontiers only.

## Record in ask-project.mdc

```markdown
## Agents
- Roles: `agent-knowledge/knowledge/architecture/agents/roles.md`
- Subagents: `.cursor/agents/ask-*.md`
- Setup: done (date)
- Update notice for /ask-setup-agents: done
- Known surfaces: `repo-a`, `repo-b`, …   # workspace-relative paths; for /ask-update delta
```

## Legacy migration (MUST when present)

If `.cursor/skills/ask-role-*/` exists: map to `.cursor/agents/ask-*.md`, migrate product MUSTS, **delete** skill folders (no stubs).

## MUST NOT

- Invent roles with no evidence and no confirmation.
- Silent-create agents on update or mid-REQ.
- Create role **skills** instead of subagents.
- Put role protocol only in chat.
- Commit/push **app/kit** unless asked (agent-knowledge auto close-out still applies).

## Close

List agents created/updated; surfaces still uncovered (if user skipped any); remind Task / `/ask-*` delegation.

Then **`ask-git-project` → agent-knowledge auto close-out**.
