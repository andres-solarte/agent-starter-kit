---
name: ask-retrospective
description: >-
  Close-out of a fully executed REQ (every acceptance criterion met): propose
  follow-up tickets, run a short retrospective, and fold learnings into the
  existing agent-knowledge docs (decisions, conventions, architecture, role
  agents…), marking critical ones as MUST blocks that are materialized where
  agents always load them. Invoked by ask-requirement step 6; also
  /ask-retrospective REQ-NNN. Owns the "Materialize MUSTs" contract used by
  install/update/setup-agents.
---

# /ask-retrospective — follow-ups + retro + knowledge update

Runs when a REQ is **fully executed**: every `AC-*` is `met` (or `dropped` with user OK). Goal: the next ticket does not repeat this ticket's mistakes — by **improving the existing knowledge**, not by keeping a separate lessons list.

The REQ is reported to the user as **closed only after** this skill finishes (`ask-requirement` step 6).

Normative home for where learnings go and the MUST block format: agent-knowledge operating contract §7–§8 (`knowledge/architecture/agent-knowledge-operating-contract.md`).

## Flow (MUST)

```text
1. Gather evidence (no new exploration of the codebase)
2. Follow-up tickets → propose; create on user confirm
3. Retrospective → write in the REQ file
4. Learnings → route each to the doc that owns the topic (or an automated check)
5. Edit those docs (add / modify / supersede); mark critical statements as MUST blocks
6. Materialize MUSTs into hosts
7. Report to the user (≤ 8 lines)
```

## 1. Evidence

Use only what is already recorded: REQ status log + acceptance-criteria table (`failed` → `met` transitions), `/ask-requirement-fix` entries (root causes), plan changes / re-plans, reopened blocks, backlog items with `Related: REQ-NNN`, today's work-log, and corrections the user made during the conversation. Do **not** re-read full transcripts.

## 2. Follow-up tickets

Candidates (only if they really exist):

- Criteria `dropped` or deferred, and items parked with `Related: REQ-NNN`
- Workarounds / tech debt / TODOs introduced by this REQ
- Rollout, migration cleanup, monitoring, docs the change requires
- Automation that would enforce a learning (step 4, destination 1)

Present them as a short list (one line each, with suggested dependency). On user confirm → `BL-NNN` items (`Ticket: candidate`, `Related: REQ-NNN`, `Depends on` when ordered) via `ask-backlog`; or the user starts `/ask-requirement` for one in a **new conversation**. Record ids in the REQ `## Follow-ups`. None → write «None».

Never create items or REQs silently.

## 3. Retrospective (in the REQ file)

Short and factual. Section `## Retrospective` in `REQ-NNN-*.md`:

```markdown
## Retrospective

- **Went well:** 1–3 bullets
- **Rework / problems:** each = what happened → root cause (e.g. AC-2 failed twice: API contract assumed, not checked with backend)
- **Knowledge updated:** doc paths changed (+ MUST blocks added/edited), follow-up ids for automation, or «none»
- **Stats:** fixes N · re-plans N · AC failed→met N
```

If nothing went wrong: two lines («No rework.» + «No knowledge changes.»). **Do not invent learnings.** Decisions taken during the REQ that are not yet recorded still count (rule `ask-decisions`).

## 4. Route each learning (MUST — strongest first)

1. **Automated check** (test, lint rule, CI gate, type) when the mistake is mechanically detectable → follow-up ticket. Cannot be skipped by any agent.
2. **The doc that owns the topic** (operating contract §7): decision → BDR/ADR (new, or supersede the old one); convention → `conventions/`; architecture / domain / product / design → its doc; how a role works → role agent SoT (`ask-agent-scope`); process → `PROCESS.md` or kit skill gap; tool introduced or set up differently → `knowledge/tooling/INVENTORY.md` (skill `ask-tools`).

Read the target doc first. If it already says it → nothing to add (maybe the problem was it being skipped → make it a MUST block). If it says something wrong or incomplete → **modify** it (no contradictory appendix). If no doc owns the topic → create one where it belongs and link it from the nearest index.

## 5. Edit the docs

- **Critical?** If forgetting it would repeat the mistake → add / update a **MUST block** next to the statement (format in operating contract §8). Existing block for the same thing → add this REQ to `Source`, sharpen the wording. Three or more sources → propose automation (destination 1).
- **Scope** — ask once for the batch, in chat language: «Should these knowledge changes apply to the **team** (PR) or **only you**?»
  - **Team** → edit `knowledge/**` (and team agents) on a branch + PR (rule `ask-knowledge-pr`; same PR as the REQ close is fine). To apply immediately for this user, copy new MUST blocks into the user delta with `· Pending: <PR URL>`.
  - **User** → same-basename delta under `users/<email>/knowledge/…` (+ `DELTAS.md`); personal agent overrides per `ask-agent-scope`.
- Budget (operating contract §8): over budget → merge blocks or move to automation.

## 6. Materialize MUSTs (MUST — contract)

Also run by `/ask-install`, `/ask-update`, and `/ask-setup-agents` after materializing role agents.

**Collect** every MUST block (`> **MUST (agents)** …`) from team `knowledge/**/*.md` ∪ current user `users/<email>/knowledge/**/*.md`. Skip `knowledge/archive/**` and docs with `status: superseded`. Drop user `Pending: <PR>` copies whose team PR is merged.

| Output (generated — never hand-edit) | Content |
|--------------------------------------|---------|
| `<adapter-home>/.cursor/rules/ask-knowledge-musts.mdc` (hosts incl. cursor) | Frontmatter `description: Critical product knowledge — apply before planning or changing code` + `alwaysApply: true`; then each `Applies to: all` block as **one line + link to its doc**; then a one-line count of role blocks per role |
| `<adapter-home>/.agents/rules/ask-knowledge-musts.md` (always; Claude loads it via `CLAUDE.md` import) | Same body, no frontmatter |
| Each host agent mirror `.cursor/agents/ask-<role>.md` / `.claude/agents/ask-<role>.md` | After copying the SoT agent, append `## Knowledge MUSTs` with that role's blocks (one line + link each) |

Header of generated files: `<!-- Generated from agent-knowledge MUST blocks by ask-retrospective. Edit the source docs, not this file. -->`

No blocks → still write the rule with «No knowledge MUSTs yet.» (wiring stays visible).

## 7. Report to the user

≤ 8 lines in chat language: REQ id `closed`; follow-ups created (ids) or none; docs updated (paths, 1–3) and MUST blocks added; PR URL if team changes; next ready item and the new-conversation line (rule `ask-one-item-per-conversation`).

## Git

- REQ file and team `knowledge/**` / `agents/**` edits → **PR**.
- User deltas, user agents, backlog items → direct (`ask-git-project` auto close-out).
- Generated host files: not in agent-knowledge; do not commit app/kit repos unless asked.

## MUST NOT

- Close a REQ without running this skill (unless the user explicitly skips the retro — record «Retro skipped by user» in the REQ).
- Invent learnings, follow-ups, or blame; be factual.
- Keep learnings in a separate lessons list, or only in the work-log, chat, or `MEMORY.md`.
- Append a statement that contradicts the doc instead of correcting it.
- Hand-edit generated `ask-knowledge-musts` files or the `## Knowledge MUSTs` block of host mirrors.
- Apply knowledge changes to the team without the user's choice.
