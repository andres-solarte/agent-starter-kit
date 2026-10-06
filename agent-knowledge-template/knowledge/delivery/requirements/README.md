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
| `closed` | Every acceptance criterion `met` with evidence |

## Acceptance criteria (MUST)

Every REQ (including micro) has **at least one** acceptance criterion. They define both **when it is done** and **what is in scope**.

### Writing them

- Ids `AC-1`, `AC-2`, … — never renumber; a dropped criterion stays with status `dropped`.
- Each one is **observable and verifiable** by someone other than the maker: user-visible behavior or checkable outcome (prefer *Given / When / Then*), not an implementation step («use library X» is not a criterion).
- Each one says **how it is verified** (e2e, test, API call, manual check, metric).
- Drafted during `/ask-requirement` Q&A and **confirmed by the user** with the summary, before registration.
- More than ~7 criteria, or criteria with independent outcomes that could ship separately → suggest **splitting** into several REQs (link with `Depends on` if ordered).

### Using them

| Moment | Rule |
|--------|------|
| Execution plan | Each block lists the `AC-*` it covers; every criterion is covered by some block |
| Block close | All its `AC-*` are `met` with evidence (checker ≠ maker, e.g. QA) |
| REQ close | All criteria `met` (or `dropped` with user confirmation) → `closed` |
| Fix | An error is a fix on this REQ only if it makes an existing criterion fail (or regresses something this REQ touched) |
| Change | Adding / editing / dropping a criterion needs user confirmation + status-log line |

Statuses per criterion: `pending` · `met` · `failed` · `dropped`.

### Scope test

Before doing any new piece of work under a REQ, ask: **is it needed to make an `AC-*` pass?**

- **Yes** → in scope.
- **No** → out of scope: tell the user which criteria it falls outside of, and park it (`/ask-backlog`, `Ticket: candidate`) or open a separate REQ. Only add it to this REQ if the user explicitly chooses to amend the criteria.

## Lifecycle (owned by `/ask-requirement` + `/ask-requirement-fix`)

1. **Register** — after requirement summary + acceptance criteria confirmed (step 3) → create file + INDEX row → `backlog`.
2. **Start** — user accepts execution plan (step 4) → `in_progress`; update `NEXT.md`.
3. **Fix (optional)** — user reports an error on this REQ → `/ask-requirement-fix` (same file; no full re-plan). May reopen a `closed` REQ if the user chooses.
4. **Close** — every acceptance criterion met (step 6, no remaining blocks) → `/ask-retrospective` (follow-ups + retro + update existing knowledge) → `closed`; update INDEX + `NEXT.md`.

Personal parked notes stay in `users/<email>/session-backlog.md` (`/ask-backlog`). They do **not** auto-move here.

## Ids

- Format: `REQ-NNN` (zero-padded, next free number in INDEX).
- File: `REQ-NNN-short-kebab-slug.md`.
