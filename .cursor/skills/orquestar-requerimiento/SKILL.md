---
name: orquestar-requerimiento
description: >-
  [agent-only] Tech Lead orchestration with tiering; usually started after
  /requerimiento Q&A. Delegates to role skills. Not for end-user slash use.
disable-model-invocation: true
---

# Orquestar requerimiento (Tech Lead)

**Entrada de usuario preferida:** `/requerimiento` (Q&A primero). Este skill es **agent-only** (`disable-model-invocation`): se ejecuta cuando `/requerimiento` lo encadena o un agente lo lee explícitamente.

## Shared pack reminder

Every delegated role also follows shared skills: `agent-skill-discipline` + `git-proyecto`. Role skill is **additional**, not a replacement.

## Mandatory companion skill

MUST follow `.cursor/skills/agent-skill-discipline/SKILL.md` (no improvisar; declarar gaps).

## Source of truth

1. `agent-knowledge/knowledge/architecture/agentes/roles.md` (crear si no existe) — roles, RACI, pipeline, loop engineering
2. `agent-knowledge/knowledge/delivery/PROCESS.md` — proceso de entrega
3. `agent-knowledge/knowledge/product/alcance/` + BDR/ADR en `knowledge/decisions/`
4. `agent-knowledge/knowledge/delivery/NEXT.md` — qué sigue
5. Rules: foco (`09`), docs (`01`), decisiones (`02`)
6. Spec Kit when tier = **normal** y el proyecto lo tiene instalado: núcleo specify→…→implement

**Spec Kit to invoke (keep lean, si el proyecto usa Spec Kit):** `git-feature` → `specify` → optional `clarify` → `plan` → `tasks` → `analyze` → `implement`.

This skill is the **orchestrator procedure**. It does not replace Product for BDR acceptance or human approval on sensitive flows (payments/auth/PII).

## Experience (MUST)

1. User provides a **requirement** via `/requerimiento` Q&A.
2. **Execution plan gate** (from `/requerimiento` paso 4): objective, steps, **agents/roles**, how each participates, **order**, done-when. **Before asking the user to accept:** run a **validation loop** with each involved role/subagent (their own criteria) → Tech Lead integrates feedback, resolves incoherence (re-ask roles as needed) until the plan is coherent end-to-end. If the project has domain-specific or security/compliance checklist skills, consult them here — findings are advisory unless the project defines otherwise; **high**-severity findings on personal data or payments MUST be resolved or raised before the user accepts the plan. **Ask the user only** for product/scope gaps not covered by the requirement/BDR. **No code** until user accepts the plan.
3. **Classify tier** (below); may appear *inside* the plan (not instead of it).
4. Review scope, repos, risks (Step 0).
5. Delegate in the **accepted order** (subagents and/or role skills).
6. **Loop** until the block's done-when is met: execute → verify → fix → repeat. Do not start the next roadmap block without a new accepted plan.
7. Close with the verify bar for that tier.

"Automatic" = one accepted plan; the chain runs to completion for that block. Not = agents waking with no trigger.

---

## Tiering (loop engineering — MUST)

Classify **before** coding. Default when unsure: **normal** (safer). User may override ("hazlo micro" / "full Spec Kit").

### Tier decision table

| Tier | Use when **all** true (or user forces) | Path | Skip |
|------|----------------------------------------|------|------|
| **micro** | See criteria below | Orquestar → role skill(s) → verify light → `git-proyecto` if commit asked | Full Spec Kit |
| **normal** | Default for features | `git-feature` → specify → [clarify] → plan → tasks → analyze → implement | Shortcuts that skip specify/plan/tasks |
| **ambiguous** | Scope/product unclear or needs BDR/ADR | Product / clarify / BDR draft **before** code | Implementation until resolved |

### Micro — objective criteria (ALL must hold)

1. **No new product scope** — no MVP IN/OUT change; no new BDR/ADR required.
2. **≤ 2 sibling repos** touched (e.g. one UI, or one API, or UI+copy; not schema+3 APIs+3 UIs).
3. **No new public API contract** (no new endpoint/resource shape) **or** only a trivial additive field already agreed in an existing spec.
4. **No new DB table** and no destructive migration. Additive column only if already specified in an open Spec/item.
5. **Fit in one session** — bugfix, typo, test flake, i18n string, wiring to existing primitive, doc sync, small refactor inside one module.
6. **Acceptance is obvious** — one or two checks (unit/lint/single e2e file), not a new journey.
7. **Not** auth, payments, settlements, PII, or security-sensitive behavior (those → **normal** minimum).

If any criterion fails → **normal** (or **ambiguous**).

### Normal — when to use

- User asks for a feature (via `/requerimiento`).
- New endpoint, schema change, multi-surface UI, new E2E journey.
- Anything that should leave `knowledge/delivery/specs/NNN-*`.
- Security/money/auth paths.

### Ambiguous — when to use

- Conflicts with the project's accepted scope / open question / missing BDR.
- User goal not verifiable ("mejorar UX" without acceptance).
- Run `clarify` or Product path; do not start Data/Backend.

### Announce format (MUST)

```text
Tier: micro | normal | ambiguous
Motivo: (1–2 criteria)
Camino: (núcleo Spec Kit / roles / stop for BDR)
```

---

## Step 0 — Review (before any code)

| Check | Action if fail |
|-------|----------------|
| In scope / accepted BDR? | Stop or hand to Product / open question — do not invent scope |
| Needs new BDR/ADR? | Tier **ambiguous**; draft proposal; **do not** implement until accepted (or user says proceed) |
| Which repos? | List explicitly |
| Out of scope side ideas | Park via `/backlog` / `.cursor/fuera-de-alcance.md` (rule 09) |
| Schema change? | Plan MUST include **existing-data migration** (treat current rows as production) |

Output a short **plan** before heavy work when tier is **normal** or **ambiguous** (unless user already said "ejecuta / hazlo").

---

## Sequences by tier

### Micro

```text
Role skill(s) for touched frontier only
  → Verify light (see below)
  → Close (update NEXT.md if needed; commit if asked)
```

Still name skills explicitly. Still `GAP DE SKILL` if uncovered.

### Normal

```text
Product (only if needed)
  → git-feature → specify → [clarify] → plan → tasks → analyze → implement
  → Inside implement, delegate frontiers:
       Data → Backend → Frontend → Design system? → QA E2E
  → Verify hard → Close (NEXT.md if needed; commits if asked / project rules)
```

Skip Spec Kit phases only if an existing current `knowledge/delivery/specs/NNN-*` already covers the change and tasks say so — do not invent a third path.

### Ambiguous

```text
Stop coding → Product / clarify / BDR-ADR → re-tier when resolved
```

---

## Default specialist order (normal / when micro needs several roles)

```text
Data (schema/migrations)     [skill de rol de datos, si existe]
  → Backend (una API)         [skill de rol backend, si existe]
  → Frontend (una UI)         [skill de rol frontend, si existe]
  → Design system             [si existe design system / storybook]
  → QA automation              [skill de e2e, si existe]
  → QA review / Docs / DevOps if needed
  → Close
```

**Never** start UI before API contract if new endpoints are required. **Never** start API before schema if new tables/columns are required.

### Parallelism

Only after a stable contract (e.g. two UIs). Never parallelize Data + Backend against an unfinished migration.

## Routing checklist

| Signal | First specialist |
|--------|------------------|
| Schema / migration / table / FK | Data |
| Module / endpoint / DTO | Backend |
| Page / form / i18n / routing | Frontend |
| Primitive / token / design system | Design system |
| E2E / test automation | QA automation |
| CI / Docker / stack drift | DevOps |
| Docs / knowledge sync only | Docs |
| Ambiguous product scope | Product (stop coding) |

## Delegation rules

1. One repo (or knowledge area) frontier.
2. Name **shared pack** + role **skill(s)**.
3. Pass contracts / AC.
4. Short handoff (what changed, how to verify).
5. Missing skill → `GAP DE SKILL` — do not improvise.

## Verify bar (before close)

| Tier | Minimum verify |
|------|----------------|
| **micro** | Targeted check: lint/typecheck/unit or single e2e file for the touch; **plus** smoke of touched apps (define a project rule for this, e.g. health endpoint check); no CRITICAL constitution clash |
| **normal** | `speckit-analyze` clean of CRITICAL (when Spec Kit ran) + relevant E2E if UI/API journey changed; **plus** touched apps boot and respond |
| **ambiguous** | No code close |

Tras cualquier cambio de código: verificar boot/health de las apps afectadas **antes** de declarar el bloque cerrado (definir esta regla en el proyecto, ver ejemplo en `agent-knowledge/knowledge/conventions/` si existe).

## Close

1. Cite verification run.
2. Update tracking item/progress when applicable.
3. Commits: user ask or project auto-commit rule — one commit per sibling repo; `git-proyecto`; no push unless asked.
4. Summary in the user's language: tier used, what shipped, what's left, one next step.

## MUST NOT

- Call **micro** to dodge Spec Kit on a real feature.
- Implement alone while skipping frontiers on **normal**.
- Expand scope without parking or "hazlo ahora".
- New stacks without ADR.
- Community skills overriding monorepo conventions.
- Mark done without the verify bar for that tier.
