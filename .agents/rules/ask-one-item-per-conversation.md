# One backlog item per conversation

Every agent (main agent, orchestrator, role subagents reporting to it) **suggests** working **one backlog item per conversation**.

**Why (tell the user once, briefly, in chat language):** answer quality degrades as the conversation grows — the context window fills with earlier, unrelated work, and the model loses precision. A fresh conversation per item keeps context small and focused.

This is a **suggestion**, not a block: if the user insists on continuing in the same conversation, comply (and still record the handoff below).

"Item" = one `BL-NNN` in `users/<email>/session-backlog.md`, or one `REQ-NNN` (one block at a time, rule `ask-one-point-at-a-time`).

## Start of a conversation (MUST)

1. Read `users/<email>/session-backlog.md` (**In progress** + **Open**) and `knowledge/delivery/NEXT.md`.
2. If the user's message maps to an existing item → name it in one sentence («This conversation: `BL-004` — …»). Read its **Resume** note; do not re-ask what is already recorded.
3. If the user names no item and one is `in_progress` → offer to resume it (one sentence).
4. If the chosen item has **unmet dependencies** (`Depends on` not `done`/`closed`) → say so and offer: (a) tackle the dependency first, (b) proceed anyway (user's call).
5. Mark the item `in_progress` (skill `ask-backlog`).

## During the conversation (MUST)

- New idea / bug / request unrelated to the current item → **park** it (`ask-backlog`), do not execute (rule `ask-focus-scope`).
- When parking or discovering work, **check dependencies** against current Open / In progress items and REQs:
  - It must happen before the current item → `Depends on` on the current item; tell the user (it may block).
  - It needs the current item first → `Depends on: <current id>` on the new item.
  - Same area / likely conflict → `Related`.
- **Ticket check:** if an item is product work that needs team traceability (new feature, multi-surface change, data/API contract, auth/payments, more than one conversation of work) → suggest promoting it to a ticket via `/ask-requirement` (creates `REQ-NNN`; link it in the item's `Ticket`). Trivial / personal notes stay as `BL-NNN`. Never create a REQ silently. Every ticket gets acceptance criteria (`AC-*`) — they define done and scope. If the project tracks tickets elsewhere (user mentions Jira, Linear, GitHub Issues…), record that URL/key in `Ticket` instead.
- If the user asks to switch to a **different item** mid-conversation → write the handoff for the current one and suggest continuing the new item in a **new conversation**.

## Closing or pausing an item (MUST)

Before the final message for the item:

1. Update the item (skill `ask-backlog`): status (`done` / `in_progress` / `blocked`), **Resume** note (where it stopped, pending `AC-*`, next concrete step, key paths / branch / PR), and unblock dependents (items whose `Depends on` is now satisfied).
2. If it has a REQ → also follow `ask-requirement` close-out (REQ file + `NEXT.md` via PR); when every `AC-*` is met, that includes follow-up tickets + retrospective (`ask-retrospective`).
3. Tell the user, in 2–4 sentences: what landed, the item status, and the **next ready item** (no unmet dependencies) — or the blocker.
4. Suggest a **new conversation** for the next item and give the exact line to paste there:

```text
/ask-backlog resume BL-005
```

(For REQ work: `/ask-requirement resume REQ-003`.)

## Long-conversation signal

If the conversation is clearly long (many turns, multiple items touched, context summarized/compacted, or you start re-reading earlier turns to remember decisions) → write the handoff now and suggest a fresh conversation, even mid-item.

## MUST NOT

- Refuse to work because the conversation is long.
- Leave an item `in_progress` without a **Resume** note when the conversation ends.
- Repeat the context-window explanation every turn (once per conversation is enough).
- Promote items to REQ or external tickets without the user's confirmation.

## Related

Skill `ask-backlog` (format, ids, dependencies) · rule `ask-focus-scope` · rule `ask-one-point-at-a-time` · skill `ask-requirement` (tickets = REQ registry).
