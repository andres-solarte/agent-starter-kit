# Session focus — out of scope

If the user asks for or mentions something **outside the scope** of the current task, **do not execute it**. Park it and continue with what is in progress.

## What counts as out of scope

- A bug, feature, or refactor not required to finish the active work
- "While we're at it…" / "later…" / a parallel idea without "do it now"
- A topic change unrelated to the current plan or item
- Under a REQ: anything **not needed to make one of its acceptance criteria (`AC-*`) pass** — say which criteria it falls outside of; it becomes a separate item / ticket unless the user chooses to amend the criteria

## What to do

1. Follow the **`ask-backlog`** skill (`.agents/skills/ask-backlog/SKILL.md`): `BL-NNN` item in `agent-knowledge/users/<email>/session-backlog.md` (per user; not under `.cursor/`), with its dependency + ticket check.
2. Acknowledge in **one sentence** (what was parked, its id, and a dependency on the current item if any).
3. Continue only with the focused task.
4. Do not open PRs, migrate, or do a "quick fix" on the side.

If the user wrote `/ask-backlog …`, apply that skill immediately (same outcome).

## When to execute immediately

- The user explicitly says to do it **now** / in this session
- It blocks finishing the current task
- It is only a clarification or decision about the work in progress

## At close-out or when asked

Offer to review the parked list or tackle a specific item — do not clear it on your own. Suggest tackling the next item in a **new conversation** (rule `ask-one-item-per-conversation`).
