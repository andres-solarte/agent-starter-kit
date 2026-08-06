---
id: decisions-index
type: guide
status: active
scope: global
tags: [decisions, bdr, adr]
updated: YYYY-MM-DD
---

# Decision records

Central index of **business** (BDR) and **architecture** (ADR) decisions.

Business → [business/](./business/) · Architecture → [architecture/](./architecture/)

## Business (BDR)

| ID | Status | Title |
|----|--------|-------|
| — | — | — |

## Architecture (ADR)

| ID | Status | Title |
|----|--------|-------|
| — | — | — |

---

## BDR template (business)

File: `business/BDR-NNNN-short-title.md` (full template: `templates/decision-business.md`)

```markdown
# BDR NNNN: Title

**Status:** proposed | accepted | deprecated
**Date:** YYYY-MM-DD

## Context

What business or product problem are we solving?

## Decision

What did we choose?

## Consequences

Impact on users, operations, scope, or monetization.

## Alternatives considered

| Alternative | Why not |
|-------------|---------|
```

## ADR template (architecture)

File: `architecture/ADR-NNNN-short-title.md` (full template: `templates/decision-architecture.md`)

```markdown
# ADR NNNN: Title

**Status:** proposed | accepted | deprecated
**Date:** YYYY-MM-DD

## Context

Technical constraints and requirements that motivate the decision.

## Options evaluated

| Option | Pros | Cons |
|--------|------|------|

## Decision

What did we choose?

## Consequences

Impact on development, operations, cost, and future evolution.
```

## Conventions

- Independent numbering per type (BDR and ADR each from 0001)
- One file per decision; clear title and date
- Link related decisions with relative Markdown links, not wikilinks
- When accepting a decision, update affected docs (`mvp.md`, `overview.md`, etc.)
- When adopting or changing technology → update `knowledge/architecture/stack-versions.md` with verified version and date
