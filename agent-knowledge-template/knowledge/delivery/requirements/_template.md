---
id: REQ-NNN
title: "{{short title}}"
status: backlog
created: YYYY-MM-DD
updated: YYYY-MM-DD
opened_by: "{{user email}}"
depends_on: []
source: "{{BL-NNN or —}}"
---

# REQ-NNN — {{short title}}

## Summary

- **What:** …
- **Done when:** every acceptance criterion below is `met` with evidence
- **Surfaces/repos:** …
- **Out of scope:** …

## Acceptance criteria

Confirmed with the user before registration. Changes only with user confirmation (log them in the status log). Anything not covered by a criterion is **out of scope** → separate item / ticket. Contract: [README.md](./README.md#acceptance-criteria-must).

| ID | Criterion (observable) | Verified by | Status | Evidence |
|----|------------------------|-------------|--------|----------|
| AC-1 | Given …, when …, then … | e2e / test / manual check | pending | — |

## Dependencies

- **Depends on:** — (REQ-NNN / BL-NNN; unmet ones block plan acceptance unless the user decides otherwise)
- **Blocks:** —

## Resume

Updated at every block close or pause (rule `ask-one-item-per-conversation`). Resume in a new conversation with `/ask-requirement resume REQ-NNN`.

- **Where it stopped:** —
- **Next step:** —
- **Paths / branch / PR:** —

## Status log

| When | Status | Note |
|------|--------|------|
| YYYY-MM-DD | backlog | Registered after summary confirm |

## Links

- NEXT pointer: `knowledge/delivery/NEXT.md`
- Related decisions / docs: …

## Blocks

| Block | AC covered | Plan accepted | Closed | Notes |
|-------|------------|---------------|--------|-------|
| 1 | AC-1 | — | — | … |

## Follow-ups

Filled by `/ask-retrospective` when every criterion is met. BL / REQ ids, or «None».

## Retrospective

Filled by `/ask-retrospective` before the REQ is reported closed.

- **Went well:** —
- **Rework / problems:** — (what happened → root cause)
- **Knowledge updated:** — (doc paths + MUST blocks, follow-up ids for automation, or «none»)
- **Stats:** fixes 0 · re-plans 0 · AC failed→met 0
