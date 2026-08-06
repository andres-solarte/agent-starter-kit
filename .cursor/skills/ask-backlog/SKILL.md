---
name: ask-backlog
description: >-
  Park ideas, bugs, or requests for later without interrupting work in progress.
  Use when the user says /ask-backlog, "note this", "later", "while we're at it", or
  wants to save something for later while staying on the current task.
---

# /ask-backlog — park for later (user)

**Fast** door so ideas are not lost. **Does not** execute the work. **Does not** replace `/ask-requirement` (that is for doing something now).

Living list: `.cursor/out-of-scope.md`
(If the project has a formal product backlog, move items there only when the user confirms promoting an item.)

## Flow (MUST)

```text
1. Capture the text (idea / bug / "later…")
2. Write a bullet in out-of-scope.md
3. Acknowledge in ONE sentence
4. Return to current focus (no long Q&A, no plan, no code for that idea)
```

## Commands

| Input | Action |
|-------|--------|
| `/ask-backlog` + text | Park that text |
| `/ask-backlog` with no text | Ask in one sentence: «What should we note?» |
| `/ask-backlog list` or «show me the backlog» | List only the **Open** section (short summary; do not clear) |
| `/ask-backlog done …` / «we already did X» | Move the bullet to **Done / discarded** if clearly identified |

Synonyms that trigger the same flow (even without `/ask-backlog`): «note this», «later», «while we're at it», «for later», «not now but…».

## Bullet format

```markdown
- YYYY-MM-DD — short summary in plain language (optional context if helpful)
```

- Date = today (user's timezone if known).
- No loose internal codes in chat when acknowledging; in the file you may leave an ID in parentheses if it already existed.
- Do not duplicate: if a nearly identical bullet exists, do not add another; say «Already noted» in one sentence.

## Communication (MUST)

- **One sentence** to the user: what was parked.
- Then **continue** with the focused task (if there is one).
- Do not ask for long confirmation. Do not offer a skill menu. Do not start implementing the parked item.

Example: «Parked: notification preferences. Continuing with the current request.»

## MUST NOT

- Execute, specify, or deeply plan the parked item.
- Switch focus to the new item.
- Put it in a formal product backlog unless the user says they want it as a confirmed improvement.
- Clear the list «for cleanup» without being asked.

## Relation to other pieces

| Piece | Role |
|-------|------|
| Rule `09-focus-scope` | Same policy; this skill is the explicit procedure |
| `/ask-requirement` | When they want to **do** a backlog item: take it off the list and treat it as a requirement |
| `ask-git-project` | Does not apply (no required commit when parking) |

## For the user: how to use it

1. Mid other work: `/ask-backlog that we can also…`
2. When you want to tackle it: `/ask-requirement` with that topic (or «pull from the backlog the one about …»).
