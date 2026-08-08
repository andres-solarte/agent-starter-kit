---
id: delivery-process
type: guide
status: active
scope: delivery
tags: [delivery, process, loop-engineering]
updated: YYYY-MM-DD
---

# PROCESS — delivery (own process)

Living source of **how** we deliver. If the project documents this decision as an ADR, link it here.
What to resume: [NEXT.md](./NEXT.md).

## Entry

| Who | What |
|-----|------|
| Human | `/ask-requirement` (work now + registry) · `/ask-backlog` (personal notes only → `users/<email>/session-backlog.md`) |
| Agents | `ask-orchestrate-requirement` + `.cursor/agents/ask-*` subagents (agent-only) |

Do not offer internal skill menus to the user.

## Paths (SoT)

| What | Path |
|------|------|
| Requirement registry | `knowledge/delivery/requirements/` (`INDEX.md` + `REQ-NNN-slug.md`) |
| What's next | `knowledge/delivery/NEXT.md` |

## Requirement registry (MUST)

- Formal work is tracked as `REQ-NNN` with status `backlog` | `in_progress` | `closed`.
- Owned by `/ask-requirement` (create on summary confirm; `in_progress` on plan accept; `closed` when the whole requirement finishes).
- Personal `/ask-backlog` notes do **not** auto-enter this registry.
- Detail: [requirements/README.md](./requirements/README.md).

## Tiers

| Tier | When | Path |
|------|------|------|
| **micro** | Orchestrator criteria (few repos, no new scope/API/table, no auth/payments, …) | Role subagents + verify light |
| **normal** | Default features | Accepted plan → specialist order → verify hard |
| **ambiguous** | Missing product / BDR | Product / clarify — **no code** until resolved |

## Loop engineering (summary)

1. Block execution plan + role validation → user accepts.
2. Execute per tier (Task / `.cursor/agents/ask-*`).
3. Verify bar: maker ≠ checker (E2E / smoke / typecheck per tier and project).
4. Close: work-log; update requirement registry + `NEXT.md`; agent-knowledge auto commit/push (`ask-git-project`).

Role detail: project doc at `knowledge/architecture/agents/roles.md` (create if missing).
