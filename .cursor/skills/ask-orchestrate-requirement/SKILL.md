---
name: ask-orchestrate-requirement
description: >-
  [agent-only] Tech Lead orchestration with tiering; usually started after
  /ask-requirement Q&A. Delegates to role subagents under .cursor/agents/.
  Not for end-user slash use.
disable-model-invocation: true
---

# Orchestrate requirement (Tech Lead)

**Preferred user entry:** `/ask-requirement` (Q&A first). This skill is **agent-only** (`disable-model-invocation`): it runs when `/ask-requirement` chains to it or an agent reads it explicitly.

## Shared pack reminder

Every delegated role also follows shared skills: `ask-agent-skill-discipline` + `ask-git-project` + `ask-agent-knowledge`. The **role subagent** (`.cursor/agents/ask-*.md`) is the specialist context; shared skills are not a replacement for it.

## Mandatory companion skill

MUST follow `.cursor/skills/ask-agent-skill-discipline/SKILL.md` (do not improvise; declare gaps).

## Source of truth

1. `agent-knowledge/knowledge/architecture/agents/roles.md` (create via `/ask-setup-agents` if missing) — roles, RACI, pipeline; product subagents under `.cursor/agents/ask-*.md`
2. `agent-knowledge/knowledge/delivery/PROCESS.md` — delivery process
3. `agent-knowledge/knowledge/product/scope/` + BDR/ADR in `knowledge/decisions/`
4. `agent-knowledge/knowledge/delivery/NEXT.md` — what follows
5. Rules: focus (`09`), docs (`01`), decisions (`02`)
6. Spec Kit when tier = **normal** and the project has it installed: specify→…→implement core

**Spec Kit to invoke (keep lean, if the project uses Spec Kit):** `git-feature` → `specify` → optional `clarify` → `plan` → `tasks` → `analyze` → `implement`.

This skill is the **orchestrator procedure**. It does not replace Product for BDR acceptance or human approval on sensitive flows (payments/auth/PII).

## Experience (MUST)

1. User provides a **requirement** via `/ask-requirement` Q&A.
2. **Execution plan gate** (from `/ask-requirement` step 4): objective, steps, **agents/roles**, how each participates, **order**, done-when. **Before asking the user to accept:** run a **validation loop** with each involved role/subagent (their own criteria) → Tech Lead integrates feedback, resolves incoherence (re-ask roles as needed) until the plan is coherent end-to-end. If the project has domain-specific or security/compliance checklist skills, consult them here — findings are advisory unless the project defines otherwise; **high**-severity findings on personal data or payments MUST be resolved or raised before the user accepts the plan. **Ask the user only** for product/scope gaps not covered by the requirement/BDR. **No code** until user accepts the plan.
3. **Classify tier** (below); may appear *inside* the plan (not instead of it).
4. Review scope, repos, risks (Step 0).
5. Delegate in the **accepted order** via **Task / role subagents** (and stack skills / Spec Kit as needed).
6. **Loop** until the block's done-when is met: execute → verify → fix → repeat. Do not start the next roadmap block without a new accepted plan.
7. Close with the verify bar for that tier.

"Automatic" = one accepted plan; the chain runs to completion for that block. Not = agents waking with no trigger.

---

## Tiering (loop engineering — MUST)

Classify **before** coding. Default when unsure: **normal** (safer). User may override ("make it micro" / "full Spec Kit").

### Tier decision table

| Tier | Use when **all** true (or user forces) | Path | Skip |
|------|----------------------------------------|------|------|
| **micro** | See criteria below | Orchestrate → role subagent(s) → verify light → agent-knowledge auto close-out | Full Spec Kit |
| **normal** | Default for features | `git-feature` → specify → [clarify] → plan → tasks → analyze → implement | Shortcuts that skip specify/plan/tasks |
| **ambiguous** | Scope/product unclear or needs BDR/ADR | Product / clarify / BDR draft **before** code | Implementation until resolved |

### Micro — objective criteria (ALL must hold)

1. **No new product scope** — no MVP IN/OUT change; no new BDR/ADR required.
2. **≤ 2 sibling repos** touched (e.g. one UI, or one API, or UI+copy; not schema+3 APIs+3 UIs).
3. **No new public API contract** (no new endpoint/resource shape) **or** only a trivial additive field already agreed in an existing spec.
4. **No new DB table** and no destructive migration. Additive column only if already specified in an open Spec/item.
5. **Fit in one session** — bug fix, typo, test flake, i18n string, wiring to existing primitive, doc sync, small refactor inside one module.
6. **Acceptance is obvious** — one or two checks (unit/lint/single e2e file), not a new journey.
7. **Not** auth, payments, settlements, PII, or security-sensitive behavior (those → **normal** minimum).

If any criterion fails → **normal** (or **ambiguous**).

### Normal — when to use

- User asks for a feature (via `/ask-requirement`).
- New endpoint, schema change, multi-surface UI, new E2E journey.
- Anything that should leave `knowledge/delivery/specs/NNN-*`.
- Security/money/auth paths.

### Ambiguous — when to use

- Conflicts with the project's accepted scope / open question / missing BDR.
- User goal not verifiable ("improve UX" without acceptance).
- Run `clarify` or Product path; do not start Data/Backend.

### Announce format (MUST)

```text
Tier: micro | normal | ambiguous
Reason: (1–2 criteria)
Path: (Spec Kit core / roles / stop for BDR)
```

---

## Step 0 — Review (before any code)

| Check | Action if fail |
|-------|----------------|
| In scope / accepted BDR? | Stop or hand to Product / open question — do not invent scope |
| Needs new BDR/ADR? | Tier **ambiguous**; draft proposal; **do not** implement until accepted (or user says proceed) |
| Which repos? | List explicitly |
| Out of scope side ideas | Park via `/ask-backlog` → `users/<email>/session-backlog.md` (rule `ask-focus-scope`) |
| Schema change? | Plan MUST include **existing-data migration** (treat current rows as production) |

Output a short **plan** before heavy work when tier is **normal** or **ambiguous** (unless user already said "execute / do it").

---

## Sequences by tier

### Micro

```text
Role skill(s) for touched frontier only
  → Verify light (see below)
  → Close (NEXT.md if needed; agent-knowledge auto commit/push per ask-git-project;
           app/kit commits only if user asked)
```

Still name skills explicitly. Still `SKILL GAP` if uncovered.

### Normal

```text
Product (only if needed)
  → git-feature → specify → [clarify] → plan → tasks → analyze → implement
  → Inside implement, delegate frontiers:
       Data → Backend → Frontend → Design system? → QA E2E
  → Verify hard → Close (NEXT.md if needed; agent-knowledge auto commit/push;
                         app/kit commits only if user asked)
```

Skip Spec Kit phases only if an existing current `knowledge/delivery/specs/NNN-*` already covers the change and tasks say so — do not invent a third path.

### Ambiguous

```text
Stop coding → Product / clarify / BDR-ADR → re-tier when resolved
```

---

## Default specialist order (normal / when micro needs several roles)

```text
Data (schema/migrations)     [ask-data subagent, if any]
  → Backend (one API)         [ask-backend]
  → Frontend (one UI)         [ask-frontend]
  → Design system             [ask-design if present]
  → QA automation              [ask-qa / e2e stack skill]
  → QA review / Docs / DevOps if needed [ask-devops]
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
5. Missing skill → `SKILL GAP` — do not improvise.

## Verify bar (before close)

| Tier | Minimum verify |
|------|----------------|
| **micro** | Targeted check: lint/typecheck/unit or single e2e file for the touch; **plus** smoke of touched apps (define a project rule for this, e.g. health endpoint check); no CRITICAL constitution clash |
| **normal** | `speckit-analyze` clean of CRITICAL (when Spec Kit ran) + relevant E2E if UI/API journey changed; **plus** touched apps boot and respond |
| **ambiguous** | No code close |

After any code change: verify boot/health of affected apps **before** declaring the block closed (define this rule in the project; see example in `agent-knowledge/knowledge/conventions/` if present).

## Close

1. Cite verification run.
2. Update tracking item/progress when applicable.
3. Commits: user ask or project auto-commit rule — one commit per sibling repo; `ask-git-project`; no push unless asked.
4. Summary in the user's language: tier used, what shipped, what's left, one next step.

## MUST NOT

- Call **micro** to dodge Spec Kit on a real feature.
- Implement alone while skipping frontiers on **normal**.
- Expand scope without parking or "do it now".
- New stacks without ADR.
- Community skills overriding monorepo conventions.
- Mark done without the verify bar for that tier.
