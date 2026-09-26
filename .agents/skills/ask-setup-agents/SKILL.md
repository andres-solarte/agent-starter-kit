---
name: ask-setup-agents
description: >-
  Analyze the workspace stack and product/business context, confirm with the
  user, then create agent-knowledge roles (RACI) and matching subagents under
  .cursor/agents and/or .claude/agents per recorded agent hosts. Re-run when
  surfaces change. Use for /ask-setup-agents, install, update deltas, or
  mid-requirement agent gaps.
---

# /ask-setup-agents — detect stack + create role subagents

Follow **`INSTALL.md`** → **Agent contract — setup agents**.

## Goal

From **business context + technical scan**, define **role subagents**, write `roles.md`, and create agent files under each **configured host**:

- Cursor → `<adapter-home>/.cursor/agents/ask-*.md`
- Claude → `<adapter-home>/.claude/agents/ask-*.md`
- Optionally also `.agents/agents/` as neutral copy

Also used to **fill gaps** when a **new surface** appears or a REQ touches a surface with no matching agent.

**Not skills:** process skills live in `.agents/skills/` (host dirs are symlinks). Roles are **subagents**, not `ask-role-*` skills.

## Flow (MUST)

```text
1. Resolve kit dir, agent-knowledge, adapter home, agent hosts, sibling repos
2. Inventory surfaces + existing agents (per host) + roles.md
3. Gather business + stack signals
4. Diff uncovered surfaces → candidate agents
5. Ask granularity if needed (type vs per-surface)
6. Propose → user yes / edit
7. Write roles.md + agent files to each host agents/ dir
8. Record Known surfaces + hosts in ask-project
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

- No host `agents/ask-*.md` (`.cursor` and/or `.claude` per hosts) lists it in Frontier / primary repos, **and**
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
- .cursor/agents/ask-*.md and/or .claude/agents/ask-*.md (per hosts)
Edit or confirm?
```

Do **not** create agents for uncovered surfaces without confirmation.  
Do **not** write `.cursor/agents` when hosts are Claude-only.

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

For each approved agent, for **each configured host** agents dir:

1. Copy template if missing (or author lean custom `.md`).
2. Fill frontiers with **exact** repos/paths from the scan.
3. Frontmatter: `name` = basename; strong `description`; `model: inherit` unless chosen otherwise.
4. Body: shared pack; frontier only; return summary to parent.
5. Keep Cursor and Claude copies in sync when hosts = `both` (same body).

Do **not** overwrite customized agents without asking — merge frontiers only.

## Record in ask-project.mdc

```markdown
## Kit paths
- Agent hosts: cursor | claude | both

## Agents
- Roles: `agent-knowledge/knowledge/architecture/agents/roles.md`
- Subagents: `.cursor/agents/ask-*.md` and/or `.claude/agents/ask-*.md`
- Setup: done (date)
- Update notice for /ask-setup-agents: done
- Known surfaces: `repo-a`, `repo-b`, …
```

## Legacy migration (MUST when present)

If `.agents/skills/ask-role-*/` exists: map to `.cursor/agents/ask-*.md`, migrate product MUSTS, **delete** skill folders (no stubs).

## MUST NOT

- Invent roles with no evidence and no confirmation.
- Silent-create agents on update or mid-REQ.
- Create role **skills** instead of subagents.
- Put role protocol only in chat.
- Commit/push **app/kit** unless asked (agent-knowledge auto close-out still applies).

## Close

List agents created/updated; surfaces still uncovered (if user skipped any); remind Task / `/ask-*` delegation. If new surfaces have remotes, confirm updating `agent-knowledge/WORKSPACE.md` so teammate machines stay aligned.

Then **`ask-git-project` → agent-knowledge auto close-out**.
