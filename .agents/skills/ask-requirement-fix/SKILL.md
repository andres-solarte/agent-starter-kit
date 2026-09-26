---
name: ask-requirement-fix
description: >-
  Fix errors reported against an existing requirement without re-running full
  /ask-requirement Q&A and plan gates. Use when the user reports a failure,
  stacktrace, regression, or "doesn't work" on recent work, or says
  /ask-requirement-fix. Prefer over ask-requirement when a REQ is in_progress
  or the user chooses to reopen a past REQ.
---

# /ask-requirement-fix — correct error on an existing REQ (user)

Focused fix loop for problems that belong to work **already planned**.  
**Does not** replace `/ask-requirement` for new scope.

## When this skill applies (MUST)

Use when the user message is about a **defect / failure / regression** tied to recent or named product work, e.g.:

- Error, exception, stacktrace, failing test, “no funciona”, “rompió…”, “sigue fallando…”
- Screenshot/log of a failure after a REQ was delivered or mid-execution
- Explicit `/ask-requirement-fix`

**Do not** use for: new features, scope expansion, unrelated bugs with no REQ link → those go to `/ask-requirement` (or ask which path).

## Visible announcement (MUST — first lines)

In the user’s chat language, before any fix work:

```text
I'm treating this as a fix on the same requirement (REQ-NNN) — not a new requirement.
I'll focus on the error; I won't re-run the full requirement Q&A/plan.
```

If the REQ id is not yet known, announce the **fix intent** first, then resolve which REQ (below), then name the id in the next user-visible line.

Silent handoff is forbidden.

## Resolve target REQ (MUST)

1. Read `knowledge/delivery/requirements/INDEX.md` + `knowledge/delivery/NEXT.md`.
2. If there is exactly one **`in_progress`** REQ (or NEXT Active matches one) → **use it**.
3. If **no** `in_progress`:
   - Ask once: reopen a **past** REQ (list recent `closed` / `backlog` candidates) **or** create a **new** REQ via `/ask-requirement` for this correction.
   - Reopen → set that REQ to `in_progress`, append status log (“reopened for fix”), update NEXT.
   - New REQ → hand off to `ask-requirement` (full gates) with a one-line note that the user chose a new requirement for the fix.
4. If several `in_progress` → ask which REQ id.

## Flow (MUST)

```text
1. Announce fix-on-same-REQ
2. Resolve REQ (above)
3. Capture error (symptom, how to reproduce, expected vs actual) — 0–2 short questions if needed
4. Fix loop: diagnose → patch (role subagents as needed) → verify the failure is gone
5. Close: note on REQ file + work-log + agent-knowledge close-out (user direct; REQ/`knowledge/**` via PR)
```

### MUST NOT re-run

- Full requirement Q&A / summary confirm / new REQ mint (unless user chose “new REQ”)
- Full block execution-plan gate + subagent plan-validation round
- Re-tiering as if greenfield (default: micro fix on known frontier)

### MAY

- One clarifying question if the error report is empty
- Delegate to `.cursor/agents/ask-*` for the touched frontier
- Park unrelated “while at it” via `/ask-backlog`

## Capture error

Prefer evidence already in the message (log, path, steps). If missing, ask at most **2** blockers: reproduce steps + expected outcome.

## Execute

1. Stay inside the REQ’s stated surfaces / done-when unless the user expands scope (then park or escalate to `/ask-requirement`).
2. Prefer the smallest change that clears the reported failure.
3. Verify: reproduce the failure path or the project’s light check for that surface.

## Close

1. Append to the REQ file: status log line + optional Blocks note (“fix: …”).
2. Keep status **`in_progress`** if the original done-when is still open; **`closed`** only if the whole REQ done-when is now met (same rules as `/ask-requirement` step 6).
3. Update `NEXT.md` if needed.
4. Agent-knowledge close-out (`ask-agent-knowledge` + `ask-git-project`): user paths direct; REQ updates under `knowledge/**` → **PR** (`ask-knowledge-pr`).
5. 2–4 sentences to the user: REQ id, what failed, what changed, how verified.

## MUST NOT

- Treat every bug as a brand-new requirement by default.
- Skip the visible announcement.
- Expand product scope under the guise of a “fix”.
- Commit/push app/kit repos unless the user asks (agent-knowledge: user direct / general via PR).

## Relation

| Skill | Role |
|-------|------|
| `ask-question` | Triage → this skill when error-on-existing-work |
| `ask-requirement` | New work / user chose new REQ for the fix |
| `ask-orchestrate-requirement` | Optional for multi-frontier fixes; no full plan gate |
| `ask-backlog` | Park unrelated ideas |
