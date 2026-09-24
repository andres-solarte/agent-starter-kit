# requirements/

Formal **requirement registry** for this product (traceability). Not the personal session backlog.

| Path | Role |
|------|------|
| [INDEX.md](./INDEX.md) | Status board — all REQ ids |
| [_template.md](./_template.md) | Copy for new `REQ-NNN-slug.md` |
| `REQ-NNN-slug.md` | One file per requirement |

## Statuses (MUST)

| Status | Meaning |
|--------|---------|
| `backlog` | Registered; not executing yet (Q&A / waiting for plan) |
| `in_progress` | Plan accepted; loop active (or paused mid-requirement) |
| `closed` | Done-when met for the whole requirement |

## Lifecycle (owned by `/ask-requirement` + `/ask-requirement-fix`)

1. **Register** — after requirement summary confirmed (step 3) → create file + INDEX row → `backlog`.
2. **Start** — user accepts execution plan (step 4) → `in_progress`; update `NEXT.md`.
3. **Fix (optional)** — user reports an error on this REQ → `/ask-requirement-fix` (same file; no full re-plan). May reopen a `closed` REQ if the user chooses.
4. **Close** — whole requirement done (step 6, no remaining blocks) → `closed`; update INDEX + `NEXT.md`.

Personal parked notes stay in `users/<email>/session-backlog.md` (`/ask-backlog`). They do **not** auto-move here.

## Ids

- Format: `REQ-NNN` (zero-padded, next free number in INDEX).
- File: `REQ-NNN-short-kebab-slug.md`.
