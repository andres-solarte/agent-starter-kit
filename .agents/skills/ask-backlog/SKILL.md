---
name: ask-backlog
description: >-
  Park ideas, bugs, or requests for later without interrupting work in progress,
  and track them across conversations (ids, status, dependencies, ticket link,
  resume notes). Writes to the current user's agent-knowledge session-backlog.md
  (committable). Use when the user says /ask-backlog, "note this", "later",
  "while we're at it", wants to save something for later, asks what is next,
  or wants to resume a backlog item in a new conversation.
---

# /ask-backlog — park, track, resume (user)

**Fast** door so ideas are not lost, plus the tracking that lets the user resume **one item per conversation** (rule `ask-one-item-per-conversation`). Parking **does not** execute the work. **Does not** replace `/ask-requirement`.

Personal only: does **not** create or update `knowledge/delivery/requirements/` (formal REQ registry). An item may **link** to a REQ (`Ticket`) once the user promotes it via `/ask-requirement`.

**Living list (SoT):** `<agent-knowledge>/users/<email>/session-backlog.md`  
Resolve email via `git config user.email` (lowercase, keep `@`). Create from `users/_template/session-backlog.md` if missing.

Do **not** write under `.cursor/` or under global `knowledge/delivery/`.  
(If the project has a formal product backlog, move items there only when the user confirms promoting an item.)

## Flow — park (MUST)

```text
1. Capture the text (idea / bug / "later…")
2. Resolve agent-knowledge + user email; ensure users/<email>/session-backlog.md exists
3. Allocate next BL-NNN; write the item under ## Open
4. Dependency + ticket check (below) — quick, from what is already known; no deep planning
5. Acknowledge in ONE sentence (id + dependency/ticket hint only if found)
6. Return to current focus
```

**Migrate once if needed:**
- Legacy `.cursor/out-of-scope.md` or `knowledge/delivery/out-of-scope.md` → this user’s `session-backlog.md`, then **delete** those legacy files. Do **not** leave pointer stubs.
- Legacy plain bullets (`- YYYY-MM-DD — …`) in `session-backlog.md` → convert to `BL-NNN` items the next time the file is written.

## Commands

| Input | Action |
|-------|--------|
| `/ask-backlog` + text | Park that text |
| `/ask-backlog` with no text | Ask in one sentence: «What should we note?» |
| `/ask-backlog list` or «show me the backlog» | List **In progress** + **Open**, grouped: ready · blocked (with blocker) · in progress. Short; do not clear |
| `/ask-backlog next` / «what's next?» | Suggest **one** ready item (no unmet dependencies; prefer items that unblock others) + the resume line |
| `/ask-backlog resume BL-NNN` | Start / continue that item **in this conversation** (flow below) |
| `/ask-backlog done …` / «we already did X» | Move item to **Done / discarded** if clear; unblock dependents |
| `/ask-backlog link BL-NNN REQ-NNN` (or external key) | Set `Ticket` |

Synonyms: «note this», «later», «while we're at it», «for later», «not now but…», «let's continue with…», «where were we?».

## Item format

```markdown
### BL-007 — short summary in plain language
- Status: open
- Added: YYYY-MM-DD · Updated: YYYY-MM-DD
- Depends on: BL-003 (or —)
- Related: —
- Ticket: candidate
- Resume: —
```

- Ids: `BL-NNN`, zero-padded, next free number across all sections. Never reuse ids.
- Statuses: `open` · `in_progress` · `blocked` · `done` · `discarded`.
- Sections: **In progress** (`in_progress`, `blocked`) · **Open** · **Done / discarded**. Move the item when its status changes.
- Keep each line short; `Resume` is 1–3 lines, not a transcript.

## Dependency check (MUST on park, resume, and close)

Compare against **In progress** / **Open** items and `requirements/INDEX.md`:

| Finding | Write |
|---------|-------|
| The item needs another one done first | `Depends on: <id>` on the item |
| Another item needs this one first | `Depends on: <this id>` on that item |
| Same area, possible conflict, no order | `Related: <id>` on both |
| A dependency is not `done`/`closed` | Item status `blocked` only when it is `in_progress` and cannot advance |

If unsure, do not invent a dependency — note `Related` or leave `—`.

## Ticket check (MUST on park and resume)

- **Candidate for ticket** (`Ticket: candidate`): product work needing team traceability — new feature, multi-surface change, data/API contract, auth/payments, or more than one conversation of work.
- On **resume** of a candidate → suggest `/ask-requirement` to register it as `REQ-NNN` (Q&A defines its acceptance criteria); on confirm, set `Ticket: REQ-NNN`. Never create a REQ silently.
- Items parked because they fell **outside a REQ’s acceptance criteria** → `Ticket: candidate` + `Related: REQ-NNN`.
- External tracker (Jira, Linear, GitHub Issues…) only if the user mentions it: store the key/URL in `Ticket`.
- Trivial / personal notes → `Ticket: —`.

## Flow — resume (MUST)

```text
1. Read the item (+ Resume note, Depends on, Ticket) and its latest conversation log (`conversations/INDEX.md`)
2. Unmet dependencies → tell the user; offer: tackle dependency first | proceed anyway
3. Ticket candidate → suggest /ask-requirement (REQ work continues under that skill)
4. Status → in_progress (move to ## In progress); Updated date
5. One sentence: «This conversation: BL-NNN — …» + where it stopped (from Resume)
6. Work the item (product work → ask-requirement / ask-requirement-fix gates as usual)
```

## Flow — close or pause (MUST)

Before the final message about the item:

1. Status → `done` (move to **Done / discarded**) or keep `in_progress` / `blocked`.
2. Rewrite **Resume**: where it stopped, next concrete step, paths / branch / PR.
3. Unblock dependents: items whose `Depends on` is now fully `done`/`closed` → if `blocked`, set back to `open` / `in_progress`.
4. Tell the user the next **ready** item and suggest a **new conversation** with the line: `/ask-backlog resume BL-NNN`.

## Communication (MUST)

- Park: **one sentence** + continue focus.
- No long confirmation, skill menu, or implementing the parked item.
- Context-window rationale for one item per conversation: once per conversation (rule `ask-one-item-per-conversation`).

## Git (MUST)

`session-backlog.md` is **tracked**. After writing it, run **`ask-git-project` → agent-knowledge auto close-out** (commit + push if `origin` exists). Do not wait for the user to ask. App/kit repos unchanged.

## MUST NOT

- Append only under `.cursor/` or global `knowledge/delivery/out-of-scope.md`.
- Execute or deeply plan the parked item.
- Clear the list without being asked.
- Reuse or renumber ids.
- End a conversation with an `in_progress` item and no **Resume** note.

## Relation

| Piece | Role |
|-------|------|
| Rule `ask-focus-scope` | Same park policy |
| Rule `ask-one-item-per-conversation` | One item per conversation; handoff + resume |
| `/ask-requirement` | Do a parked item as a formal ticket (`REQ-NNN`) |
| `ask-git-project` | Auto commit/push agent-knowledge after park |

## For the user

1. Mid work: `/ask-backlog that we can also…`
2. Later, in a **new conversation**: `/ask-backlog next` or `/ask-backlog resume BL-NNN`.
