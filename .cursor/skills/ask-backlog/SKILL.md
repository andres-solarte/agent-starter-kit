---
name: ask-backlog
description: >-
  Park ideas, bugs, or requests for later without interrupting work in progress.
  Writes to the current user's agent-knowledge session-backlog.md (committable).
  Use when the user says /ask-backlog, "note this", "later", "while we're at it",
  or wants to save something for later while staying on the current task.
---

# /ask-backlog — park for later (user)

**Fast** door so ideas are not lost. **Does not** execute the work. **Does not** replace `/ask-requirement`.

**Living list (SoT):** `<agent-knowledge>/users/<email>/session-backlog.md`  
Resolve email via `git config user.email` (lowercase, keep `@`). Create from `users/_template/session-backlog.md` if missing.

Do **not** write under `.cursor/` or under global `knowledge/delivery/`.  
(If the project has a formal product backlog, move items there only when the user confirms promoting an item.)

## Flow (MUST)

```text
1. Capture the text (idea / bug / "later…")
2. Resolve agent-knowledge + user email; ensure users/<email>/session-backlog.md exists
3. Write a bullet under ## Open
4. Acknowledge in ONE sentence
5. Return to current focus
```

**Migrate once if needed:** Open items from legacy `.cursor/out-of-scope.md` or `knowledge/delivery/out-of-scope.md` → this user’s `session-backlog.md`, then leave pointer stubs or remove legacy files.

## Commands

| Input | Action |
|-------|--------|
| `/ask-backlog` + text | Park that text |
| `/ask-backlog` with no text | Ask in one sentence: «What should we note?» |
| `/ask-backlog list` or «show me the backlog» | List only **Open** (short; do not clear) |
| `/ask-backlog done …` / «we already did X» | Move bullet to **Done / discarded** if clear |

Synonyms: «note this», «later», «while we're at it», «for later», «not now but…».

## Bullet format

```markdown
- YYYY-MM-DD — short summary in plain language (optional context if helpful)
```

## Communication (MUST)

- **One sentence** parked + continue focus.
- No long confirmation, skill menu, or implementing the parked item.

## Git

Parking does not require a commit. `session-backlog.md` is **tracked**; when the user commits agent-knowledge, it can go with that repo (`ask-git-project`).

## MUST NOT

- Append only under `.cursor/` or global `knowledge/delivery/out-of-scope.md`.
- Execute or deeply plan the parked item.
- Clear the list without being asked.

## Relation

| Piece | Role |
|-------|------|
| Rule `ask-focus-scope` | Same park policy |
| `/ask-requirement` | Do a parked item → treat as requirement |
| `ask-git-project` | Optional commit in agent-knowledge repo |

## For the user

1. Mid work: `/ask-backlog that we can also…`
2. Later: `/ask-requirement` with that topic.
