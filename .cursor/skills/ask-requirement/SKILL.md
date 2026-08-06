---
name: ask-requirement
description: >-
  Single user entry for requesting product work: describe the requirement,
  clarify in Q&A, then the orchestrator assigns and implements. Use when the
  user says /ask-requirement, wants a feature or fix, starts with a product
  request, or when ask-question triages the turn as product work (rule 16).
---

# /ask-requirement — single entry (user)

You speak **only** with this skill once it is active (user typed `/ask-requirement` **or** `ask-question` handed off under rule `16`). Other skills (Spec Kit, role skills, `ask-orchestrate-requirement`, etc.) are **for agents**: the orchestrator reads and invokes them; you do not choose them.

## Flow (MUST)

```text
1. Capture requirement
2. Q&A (clarify gaps)  ← no code yet
3. Confirm summary + acceptance criteria
4. Block execution plan  ← NEW GATE (required)
5. Execute in loop mode until the block is fully resolved
6. Deliver / close (or move to the next block with a new plan)
```

If work is split into **several blocks**: **each block** repeats steps 4→5→6. Do not chain the next block without an accepted plan.

## Step 1 — Capture

Take the user's text (`$ARGUMENTS` or the message). If empty, ask in one sentence: «What do you need?»

If this turn started via **`ask-question` handoff** (rule `16`) and the announcement was already shown, continue from Q&A. If somehow entered without announcement, open with the same two-line requirement notice (chat language) before questions.

Do not invent scope. Apply focus (rule `09`): park "while we're at it…" with skill **`ask-backlog`** (`.cursor/skills/ask-backlog/SKILL.md`).

When starting Q&A, prefer a short cue that this phase is **requirement clarification** (not documentation/coding yet), so it does not feel like an open-ended FAQ.

## Step 2 — Q&A (clarification session)

**Before writing code or touching repos**, reduce ambiguity.

### Rules

- At most **5** high-value (blocking) questions.
- Prefer **one question per turn** (or a short block of 2–3 if independent).
- Clear language; no internal jargon unless the user already uses it.
- If already clear (obvious fix, typo micro-change), say «No blockers» and go to step 3 with 0 questions.
- If a business/architecture decision is needed / it conflicts with agreed scope → say so; do not implement until OK or a documented decision.

### What to ask (prioritize blockers)

1. Observable outcome / "done" criterion
2. Surface (which repo/app/module)
3. OUT of scope (what not to do)
4. Data or migrations — yes/no?
5. Risk (auth, payments, PII)
6. Is there already an open spec or ticket?

Do not ask implementation details (library, file names) unless they change the contract.

### Question format

Brief context (1 line) + question + options if helpful (A/B/C) + "or something else".

## Step 3 — Confirm requirement / block scope

When no blockers remain, show:

```text
Summary:
- What: …
- Done when: …
- Surfaces/repos: …
- Out of scope: …
```

Ask for confirmation: «Shall we move to the execution plan?»
(If the user already said «do it / go ahead» on the summary, still go through **step 4** — the agent plan — except for an agreed trivial micro.)

## Step 4 — Execution plan (GATE — MUST)

**Before writing code**, present a plan in plain language. The user must **accept it** («yes / ok / go ahead with the plan»).

### Validation with subagents (MUST — before asking for acceptance)

Before showing the plan to the user for the «yes»:

1. Identify the **roles the plan will involve**.
2. **Consult each one** (subagent / role skill) with the draft plan and requirement context.
3. Each role reviews with **its own criteria** (data: migration/backfill; backend: contracts/auth; frontend: surfaces/i18n; QA: how to verify; product: IN/OUT scope).
4. The **Tech Lead** takes the feedback, **cross-checks** findings, and **resolves incoherence** (re-consulting affected roles if needed).
5. **Loop** that pattern (consult → integrate → re-validate conflicts) until the plan is **coherent end-to-end**.
6. Only then present the **adjusted** plan and ask for acceptance.

**When to ask the user (in this phase):** only if something **not covered** by the requirement appears (business decision, new scope, trade-off product did not resolve). Do not escalate to the user technical contradictions between roles that the Tech Lead can close with them.

Listing roles in the plan text without having consulted them is not enough. If a role does not apply to the block, omit it and say so in one sentence.

Narrow exception (typo micro / one string): no subagent round needed; name who touches what in one sentence.

### Minimum plan content

1. **What we will do in this block** (observable outcome).
2. **How** (short steps, no jargon).
3. **Who participates** (roles/agents): plain name + what each does — **already validated** in the previous loop.
4. **Order** (sequence; what runs in parallel if applicable).
5. **How we know it finished** ("block resolved" criterion).
6. **What is out** of this block.
7. **If there is a data/DB change:** how **existing data** migrates (NULL/default/backfill). Treat current data as production.
8. **Loop findings** (optional, brief): 1–3 bullets of what roles contributed if the plan changed.

Suggested format to the user:

```text
Block plan:
- Goal: …
- Steps: 1) … 2) … 3) …
- Who (validated):
  - … → …
  - … → …
- Order: …
- Done when: …
- Out: …
Do you accept the plan?
```

**Forbidden:** start implementation, migrations, or Spec Kit `implement` without that «yes» to the plan.
**Forbidden:** ask for plan acceptance without having run subagent validation (except micro exception).

## Step 5 — Execute in loop until resolved

After the plan is accepted, follow `.cursor/skills/ask-orchestrate-requirement/SKILL.md` in **loop mode**:

1. Execute the next plan step (delegate to the relevant role).
2. Verify that step.
3. If it fails or is incomplete → fix and repeat (same block).
4. Do not declare the block closed until the «Done when» criterion is met.
5. Do not jump to the **next roadmap block** without a **new plan** (return to step 4).

Cursor `/loop` heartbeat is optional (re-check queue/drift); the "loop" here is the **execute → verify → fix** cycle until the requirement/block closes.

## Step 6 — Close (to the user)

2–4 sentences: what was done, what remains, one next step. No loose internal codes.

If there are more pre-agreed blocks: «Block N done. Next: block N+1 — shall I prepare the plan?»

## MUST NOT (toward the user)

- Ask them to run internal skills (`/speckit-*`, `/ask-orchestrate-*`, etc.).
- Show a menu of internal skills.
- Start code in step 2 or **without an accepted plan** (step 4).
- Skip Q&A when there are real blockers.
- Mark a half-finished block as closed.

## Internal references (agents)

- Orchestration: `ask-orchestrate-requirement`
- Discipline: `ask-agent-skill-discipline` + rule `12`
- Git: `ask-git-project`
- Roles / RACI / loop: project doc in `agent-knowledge/knowledge/architecture/agents/` (create if missing)
