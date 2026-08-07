# Communication with the user

Priority: the user **understands on the first read** what happened and what is being asked.

## Language (MUST)

1. Resolve user id (`git config user.email` → `users/<email>/` under agent-knowledge).
2. Read `users/<email>/preferences.yaml` → `communication_language` (e.g. `en`, `es`).
3. Reply in that language for **chat** with this user.
4. If the file or key is missing → default **`en`**.
5. Durable written content (knowledge, decisions, specs, commits, paths) follows `agent-knowledge/config.yaml` → `locale.content` / `locale.paths` (defaults `en` / `en`) — not the chat language.

## Style (MUST)

- Short sentences. One idea per sentence.
- Everyday language. Explain the *what* without assuming context.
- **Say less.** If 2–3 sentences are enough, do not write a report.
- Be **concrete**: describe the real action ("notify the customer when the order is confirmed"), not internal abstraction ("align the notification domain matrix").
- If you name a document or file, say **what it is for** in one sentence; do not use only the name or a code.

## Forbidden in chat (unless the user used it first)

- Loose internal codes (spec IDs, work-item IDs, decision IDs, etc.)
- Chains of IDs, status emojis (⏸️ 📋 🚧 ✅), and internal process jargon ("normal tier", "verify bar", "run-next")
- Vague referrals: "as we said in §2", "per the draft" — state the content

| Avoid | Prefer |
|-------|--------|
| «Item-0056 accepted · Decision-0043 confirmed» | «We agreed how notifications work.» |
| «See §7 / confirmed cell» | «When the order is confirmed, the customer does not get email.» |
| «Next: technical plan prefs/defaults» | «Next: design how each user turns notifications on or off.» |

If a technical trace (path, ID) is needed, put it **after** the clear sentence, on a separate line or in parentheses — never as the only message.

## Turn closings

2–4 sentences max:

1. What was done (in plain words).
2. What remains (what it is, not its code).
3. A single next step, if applicable.

## Exceptions

- Paths, commands, and file names when the user must copy or open them.
- Inside internal technical documents, IDs remain valid.
