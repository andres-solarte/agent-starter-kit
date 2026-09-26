---
name: ask-setup-agents
description: >-
  Analyze the workspace stack and product/business context, confirm with the
  user, then create agent-knowledge roles (RACI) and role subagents with
  mandatory user-vs-team scope. SoT lives in agent-knowledge (team:
  agents/ask-*.md; user: users/<email>/agents/). Materialize into host
  .cursor/agents and/or .claude/agents. Re-run when surfaces change.
---

# /ask-setup-agents — detect stack + create role subagents

Follow **`INSTALL.md`** → **Agent contract — setup agents**.  
Scope rule: **`ask-agent-scope`** (MUST ask user-only vs team on every create/modify).

## Goal

From **business context + technical scan**, define **role subagents**, write team `roles.md` when scope is team, write SoT files under agent-knowledge, and **materialize** into configured hosts:

| Scope | SoT (agent-knowledge, tracked) | `roles.md` |
|-------|--------------------------------|------------|
| **Team** | `agents/ask-*.md` | Update |
| **User** | `users/<email>/agents/ask-*.md` | Do not list as team |

Runtime mirrors (per hosts):

- Cursor → `<adapter-home>/.cursor/agents/ask-*.md`
- Claude → `<adapter-home>/.claude/agents/ask-*.md`

**Not skills:** process skills live in `.agents/skills/`. Roles are **subagents**.

## Flow (MUST)

```text
1. Resolve kit dir, agent-knowledge, adapter home, agent hosts, sibling repos, user email
2. Inventory surfaces + existing SoT (team agents/ + users/<email>/agents/) + roles.md + host mirrors
3. Gather business + stack signals
4. Diff uncovered surfaces → candidate agents
5. Ask granularity if needed (type vs per-surface)
6. Propose list → for each create/modify (or batch): MUST ask scope A user-only | B team
7. User yes / edit
8. Write SoT under the chosen layer; update roles.md only for team; materialize hosts
9. Record Known surfaces + hosts + SoT paths in ask-project
10. Legacy ask-role-* skill migration if needed
11. Close + agent-knowledge auto close-out
```

### Modes

| Mode | When | Scope |
|------|------|--------|
| **Full** | Install / explicit `/ask-setup-agents` / user asks full refresh | All surfaces |
| **Delta** | `/ask-update` found new repos; mid-REQ agent gap | Only uncovered / new surfaces (still confirm) |

## Scope question (MUST)

Before writing **any** new or changed agent file, ask in the user’s chat language:

```text
Is this agent (A) user-only (you), or (B) team (everyone)?
```

For a **batch**, you may ask once:

```text
Scope for these agents?
(A) all user-only  (B) all team  (C) ask per agent
```

Never default to team. Never write SoT until scope is answered.

**Promote:** user-only → team only when they choose B for an agent that lived under `users/<email>/agents/` (see rule `ask-agent-scope`).

**Edit of team agent + answer A:** ask personal override vs change team SoT — do not silent-fork.

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

Always prefer including **`ask-tech-lead`** unless declined (still ask scope).

**Persona hint:** `frontend` | `backend` | `devops` | `fullstack` | `mobile` | `todero` — show for confirmation.

## Coverage gap (MUST)

A surface is **uncovered** when:

- No **team** SoT `agents/ask-*.md` (and no user agent the current user relies on) lists it in Frontier / primary repos, **and**
- `roles.md` has no row mapping that surface to a **team** subagent

For each uncovered surface, propose a specialist whose **nature and scope** match the surface.

## Granularity (MUST ask when relevant)

When **two or more** surfaces share a specialty (e.g. two mobile apps, or three Nest APIs):

Ask once (chat language):

```text
For these surfaces (…): prefer
(A) one agent per type (e.g. ask-mobile covering all mobile repos), or
(B) one agent per surface/repo (e.g. ask-buyer-mobile, ask-driver-mobile)?
```

Do not assume A or B. Record the choice in `roles.md` Notes (team agents only).

If only one surface per specialty → default to type-named agent (`ask-mobile`, `ask-frontend`, …) unless the user wants a surface-specific name.

## Proposal format (MUST before writing)

```text
Mode: full | delta
Persona hint: …
Surfaces found:
- path — kind — covered by ask-… | UNCOVERED
Granularity: A (type) | B (per surface) | n/a
Subagents to create/update:
- ask-… — why — frontiers: … — scope: TBD (ask A/B)
Will write SoT:
- team → agent-knowledge/agents/ask-*.md (+ roles.md)
- user → agent-knowledge/users/<email>/agents/ask-*.md
Then materialize → host agents/ dirs
Edit or confirm?
```

Do **not** create agents without confirmation + scope.  
Do **not** write `.cursor/agents` when hosts are Claude-only.

## Write roles.md (MUST for team scope)

Path: `<agent-knowledge>/knowledge/architecture/agents/roles.md`

Include only **team** agents:

- Product one-liner / domain
- Persona hint + granularity choice
- **Surfaces** table: path ↔ kind ↔ team subagent SoT path
- Roles ↔ `agents/ask-….md` ↔ primary repos
- Default specialist order, RACI, delegation notes

English for durable file; chat in user language.

## Write SoT + materialize (MUST)

Templates: `{{kit-directory}}/templates/role-agents/<ask-name>.md`

For each approved agent:

1. Resolve scope (A/B already answered).
2. Write/update file under the SoT path for that scope.
3. Frontmatter: `name` = basename; strong `description`; `model: inherit` unless chosen otherwise; optional `scope: team|user`.
4. Body: shared pack; frontier only; return summary to parent.
5. If **team**: update `roles.md`. If **user**: do not add to team `roles.md`.
6. **Materialize:** copy team `agents/ask-*.md` ∪ current `users/<email>/agents/ask-*.md` into each configured host `agents/` dir (overwrite mirrors that match SoT basenames; do not delete unknown host-only files without asking).

Do **not** overwrite customized SoT without asking — merge frontiers only.

## Record in ask-project.mdc

```markdown
## Kit paths
- Agent hosts: cursor | claude | both

## Agents
- Roles: `agent-knowledge/knowledge/architecture/agents/roles.md`
- Team SoT: `agent-knowledge/agents/ask-*.md`
- User SoT: `agent-knowledge/users/<email>/agents/ask-*.md`
- Host mirrors: `.cursor/agents/` and/or `.claude/agents/` (materialized)
- Setup: done (date)
- Update notice for /ask-setup-agents: done
- Known surfaces: `repo-a`, `repo-b`, …
```

## Legacy migration (MUST when present)

If `.agents/skills/ask-role-*/` exists: map into SoT + host mirrors, migrate product MUSTS, **delete** skill folders (no stubs).

If host mirrors exist but `agent-knowledge/agents/` is empty: offer to **import** host `ask-*.md` into team SoT (confirm) so the team can share them.

## MUST NOT

- Invent roles with no evidence and no confirmation.
- Silent-create agents on update or mid-REQ.
- Skip the user-vs-team scope question.
- Create role **skills** instead of subagents.
- Treat adapter-home host dirs as the only copy (SoT must be agent-knowledge).
- Commit/push **app/kit** unless asked (agent-knowledge auto close-out still applies).

## Close

List agents created/updated with **scope**; surfaces still uncovered; remind Task / `/ask-*` delegation. If new surfaces have remotes, confirm updating `WORKSPACE.md`.

Then **`ask-git-project`**: user-scoped paths → direct close-out; team SoT (`agents/`, `roles.md` under `knowledge/`) → **branch + PR** (rule `ask-knowledge-pr`). Do not push team agents to the default branch.
