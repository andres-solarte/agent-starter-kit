---
id: delivery-process
type: guide
status: active
scope: delivery
tags: [delivery, process, spec-kit, loop-engineering]
updated: YYYY-MM-DD
---

# PROCESS — delivery (own process)

Living source of **how** we deliver. If the project documents this decision as an ADR, link it here.
What to resume: [NEXT.md](./NEXT.md).

## Entry

| Who | What |
|-----|------|
| Human | `/ask-requirement` (work now) · `/ask-backlog` (parked → `users/<email>/session-backlog.md`) |
| Agents | `ask-orchestrate-requirement` + role skills (agent-only) |

Do not offer a Spec Kit skill menu to the user.

## Paths (SoT)

| What | Path |
|------|------|
| Specs (global) | `knowledge/delivery/specs/NNN-slug/` |
| Templates + constitution | `knowledge/delivery/specify/` |
| Runtime markers (symlinks, if using Spec Kit) | `agent-knowledge/.specify` → `knowledge/delivery/specify` · `agent-knowledge/specs` → `knowledge/delivery/specs` |
| What's next | `knowledge/delivery/NEXT.md` |

## Tiers

| Tier | When | Path |
|------|------|------|
| **micro** | Orchestrator criteria (few repos, no new scope/API/table, no auth/payments, …) | Roles + verify light — **no** Spec Kit |
| **normal** | Default features | Spec Kit core (below) |
| **ambiguous** | Missing product / BDR | Product / clarify — **no code** until resolved |

## Spec Kit core (normal tier, if the project installed it)

Order:

1. `speckit-git-feature` (if branch applies)
2. `speckit-specify`
3. `speckit-clarify` (only if the spec is ambiguous)
4. `speckit-plan`
5. `speckit-tasks`
6. `speckit-analyze` (gate)
7. `speckit-implement`

Bash scripts (if used): run from `agent-knowledge/` (finds `.specify`).

## Loop engineering (summary)

1. Block execution plan + role validation → user accepts.
2. Execute per tier.
3. Verify bar: maker ≠ checker (analyze / E2E / smoke per tier).
4. Close: work-log; update `NEXT.md` if focus changed; commits only if asked / project rules.

Role detail: project doc at `knowledge/architecture/agents/roles.md` (create if missing).
