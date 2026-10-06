---
name: ask-requirement
description: >-
  Single user entry for requesting product work: describe the requirement,
  clarify in Q&A, then the orchestrator assigns and implements. Use when the
  user says /ask-requirement, wants a feature or fix, starts with a product
  request, or when ask-question triages the turn as product work (rule 16).
---

# /ask-requirement — single entry (user)

You speak **only** with this skill once it is active (user typed `/ask-requirement` **or** `ask-question` handed off under the route rule). Other skills (`ask-orchestrate-requirement`, etc.) and **role subagents** (`.cursor/agents/`) are **for agents**: the orchestrator reads and invokes them; you do not choose them.

## Flow (MUST)

```text
1. Capture requirement
2. Q&A (clarify gaps)  ← no code yet
3. Confirm summary + acceptance criteria (AC-*) → REGISTER REQ (backlog)
4. Block execution plan  ← GATE → on accept: status in_progress
5. Execute in loop mode until the block is fully resolved
6. Deliver / close (or next block with a new plan) → when every AC is met: follow-ups + retrospective (ask-retrospective) → close REQ
```

If work is split into **several blocks**: **each block** repeats steps 4→5→6. Do not chain the next block without an accepted plan.

## Requirement registry (MUST)

SoT: `agent-knowledge/knowledge/delivery/requirements/` (`INDEX.md` + `REQ-NNN-slug.md`). See that folder’s README — including the **acceptance criteria contract** (writing, scope test, close). Every REQ has ≥ 1 `AC-*`; no REQ without them.

| Moment | Action |
|--------|--------|
| After step 3 confirm | Allocate next `REQ-NNN`, create file from `_template.md`, INDEX row, status **`backlog`** |
| User accepts step 4 plan | Status → **`in_progress`**; set `NEXT.md` Active requirement |
| Step 6 — more blocks remain | Keep **`in_progress`**; update Blocks table + NEXT next step |
| Step 6 — whole requirement done | Status → **`closed`**; INDEX + NEXT (Last closed) |

Do **not** auto-create registry rows from `/ask-backlog` (personal notes only). When the user promotes a `BL-NNN` item, register the REQ and set the item’s `Ticket: REQ-NNN` (and `Source: BL-NNN` in the REQ).  
Resuming an existing REQ (`/ask-requirement resume REQ-NNN`, or ask which id / use `NEXT.md` Active): read its **Resume** section and continue from there — do not mint a duplicate id or re-run Q&A already recorded.

**One REQ per conversation** (rule `ask-one-item-per-conversation`): at each block close or pause, rewrite the REQ’s **Resume** section and suggest continuing in a new conversation with `/ask-requirement resume REQ-NNN`. Record `Depends on` (other REQs / `BL-NNN`) when found during Q&A or planning; flag unmet dependencies before plan acceptance.

## Step 1 — Capture

Take the user's text (`$ARGUMENTS` or the message). If empty, ask in one sentence: «What do you need?»

If this turn started via **`ask-question` handoff** (rule `16`) and the announcement was already shown, continue from Q&A. If somehow entered without announcement, open with the same two-line requirement notice (chat language) before questions.

Do **not** invent scope. Apply focus (rule `ask-focus-scope`): park "while we're at it…" with skill **`ask-backlog`**.

If the user is reporting a **failure on work already under an `in_progress` REQ** (or explicitly wants a fix-on-same-REQ), hand off to **`ask-requirement-fix`** instead of continuing this skill’s full gates.

## Step 2 — Q&A (clarification session)

**Before writing code or touching repos**, reduce ambiguity.

### Rules

- At most **5** high-value (blocking) questions.
- Prefer **one question per turn** (or a short block of 2–3 if independent).
- Clear language; no internal jargon unless the user already uses it.
- If already clear (obvious fix, typo micro-change), say «No blockers» and go to step 3 with 0 questions.
- If a business/architecture decision is needed / it conflicts with agreed scope → say so; do not implement until OK or a documented decision.

### What to ask (prioritize blockers)

1. Observable outcome → **acceptance criteria** (what the user will see / check; how it is verified)
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
- Surfaces/repos: …
- Out of scope: …
Acceptance criteria (done = all met):
- AC-1: Given …, when …, then … (verified by …)
- AC-2: …
```

Acceptance criteria rules (MUST): observable, verifiable, not implementation steps; ≥ 1 even for micro; > ~7 or independent outcomes → propose splitting into several REQs. Anything the user mentions that no criterion covers goes to **Out of scope** (park / separate ticket) unless they ask to add a criterion.

Ask for confirmation of the summary **and the criteria**: «Are these acceptance criteria right? Shall we move to the execution plan?»
(If the user already said «do it / go ahead» on the summary, still go through **step 4** — the agent plan — except for an agreed trivial micro.)

**On confirm (MUST):** register the requirement (`backlog`) before presenting the execution plan. Tell the user the id once (e.g. `REQ-003`).

## Step 4 — Execution plan (GATE — MUST)

**Before writing code**, present a plan in plain language. The user must **accept it** («yes / ok / go ahead with the plan»).

### Validation with subagents (MUST — before asking for acceptance)

Before showing the plan to the user for the «yes»:

1. Identify the **roles / surfaces** the plan will involve. If a surface has **no** matching subagent → follow `ask-orchestrate-requirement` → **Agent gap (surfaces)** (offer `/ask-setup-agents` delta; ask type vs per-surface). Do not accept a plan that invents coverage.
2. **Consult each one** (role subagent under `.cursor/agents/`) with the draft plan and requirement context.
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
5. **Acceptance criteria covered** by this block (`AC-*` ids) and how each is verified. Every REQ criterion must be covered by some block.
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
- Covers: AC-1, AC-2 (verified by …)
- Out: …
Do you accept the plan?
```

**Forbidden:** start implementation or migrations without that «yes» to the plan.
**Forbidden:** ask for plan acceptance without having run subagent validation (except micro exception).

**On plan accept (MUST):** set the REQ status to **`in_progress`**, append status log, update `NEXT.md` Active requirement.

## Step 5 — Execute in loop until resolved

After the plan is accepted, follow `.agents/skills/ask-orchestrate-requirement/SKILL.md` in **loop mode**:

1. Execute the next plan step (delegate to the relevant role).
2. Verify that step.
3. If it fails or is incomplete → fix and repeat (same block).
4. Do not declare the block closed until each of its `AC-*` is `met` with evidence (checker ≠ maker). Update the criteria table (status + evidence) as they pass.
5. **Scope test** on anything new that comes up: not needed for an `AC-*` → out of scope → park (`/ask-backlog`, ticket candidate) or separate REQ; tell the user which criteria it falls outside of.
6. Do not jump to the **next roadmap block** without a **new plan** (return to step 4).

Cursor `/loop` heartbeat is optional (re-check queue/drift); the "loop" here is the **execute → verify → fix** cycle until the requirement/block closes.

## Step 6 — Close (to the user)

Before or with the user-facing close:

1. Update the **REQ** file: acceptance-criteria table (status + evidence), Blocks table, INDEX `AC met`; if **every** criterion is `met` (or `dropped` with user OK) → run **`ask-retrospective`** (follow-up tickets + retrospective + update existing knowledge + materialize MUSTs), then status **`closed`** + INDEX; else keep **`in_progress`** and note the pending criteria / next block. Update `NEXT.md`. (These live under `knowledge/**` → persist via **PR**, rule `ask-knowledge-pr`.)
2. Run **agent-knowledge close-out** (`ask-agent-knowledge` → `AGENTS.md`): work-log (+ deltas if needed) — **direct** OK for user paths.
3. Run **`ask-git-project`**: user-scoped → commit/push default branch; REQ / `NEXT.md` / other `knowledge/**` → **branch + PR** (do not push registry to default branch). Return PR URL when opened.

Then 2–4 sentences to the user: REQ id + status, which criteria are met / pending, what was done, one next step. No loose internal codes. Mention the knowledge PR URL when registry changes went through a PR; mention push/remote only if user-path push failed or there is no remote.

If there are more pre-agreed blocks: «Block N done. Next: block N+1 — shall I prepare the plan?» (REQ stays `in_progress`.)

## MUST NOT (toward the user)

- Ask them to run internal skills (`/ask-orchestrate-*`, etc.).
- Show a menu of internal skills.
- Start code in step 2 or **without an accepted plan** (step 4).
- Skip Q&A when there are real blockers.
- Mark a half-finished block as closed.
- Mark the REQ `closed` while blocks remain or any criterion is `pending` / `failed`.
- Register a REQ without acceptance criteria, or change criteria without user confirmation.
- Report a REQ `closed` without the follow-ups + retrospective (`ask-retrospective`), unless the user explicitly skips it.
- Absorb work no criterion covers (scope creep) without the user choosing to amend the criteria.
- Skip registry create/update (no silent work without a REQ id).

## Internal references (agents)

- Orchestration: `ask-orchestrate-requirement`
- Discipline: `ask-agent-skill-discipline`
- Git: `ask-git-project`
- Registry: `agent-knowledge/knowledge/delivery/requirements/`
- Fixes on same REQ: `ask-requirement-fix`
- Close-out (follow-ups, retro, knowledge update): `ask-retrospective`
- Roles / RACI / loop: `agent-knowledge/knowledge/architecture/agents/` (create if missing)
