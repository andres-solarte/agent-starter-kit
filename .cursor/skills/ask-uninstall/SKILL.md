---
name: ask-uninstall
description: >-
  Uninstall agent-starter-kit wiring from a product workspace: ask which
  directories to remove (kit clone, agent-knowledge, product .cursor kit pieces),
  confirm explicitly, then delete or strip only what the user approved. Use
  when the user says /ask-uninstall, "uninstall the kit", or "remove
  agent-starter-kit".
---

# /ask-uninstall — remove kit wiring (user)

Follow **`INSTALL.md` at the kit root** → **Agent contract — uninstall**.

## Flow (MUST)

```text
1. Resolve recorded paths (or ask): kit dir, agent-knowledge dir, product .cursor/ home
2. Q&A: what to remove (each piece independently)
3. Summary of destructive actions → explicit yes
4. Perform only approved removals
5. Close: what was removed / what was kept
```

## Q&A (MUST — per piece)

For each path, ask keep vs remove (defaults in bold = safest):

| Piece | Options | Default |
|-------|---------|---------|
| **Kit directory** | keep clone / delete directory | **keep** |
| **agent-knowledge directory** | keep / delete directory | **keep** (memory; require typing the path or “delete agent-knowledge” to confirm if remove) |
| **Product `.cursor/` kit pieces** | keep / remove only `ask-*` skills + kit process rules that match upstream names / remove entire `.cursor/` | **remove only kit-sourced `ask-*` skills + known kit rules** (never delete stack skills the product added unless listed and approved) |

Also ask: remove `out-of-scope.md`? Default **keep**.

## Confirm gate (MUST)

Show a bullet list of **exact paths** that will be deleted or files that will be removed. User must reply clearly (e.g. “yes, uninstall”). No silent deletes.

## Execution

1. Product `.cursor/`: delete only approved skill folders / rule files (kit-sourced). Leave product overlays and non-kit skills.
2. agent-knowledge: delete directory **only** if explicitly confirmed.
3. Kit directory: delete **only** if explicitly confirmed (this removes the updatable dependency clone).
4. Do not `git push --force` or touch app repos (`repo-api`, etc.).
5. No commit unless asked.

## MUST NOT

- Delete agent-knowledge or kit dir without explicit per-piece approval.
- Wipe the whole product `.cursor/` unless the user chose that option.
- Remove unrelated workspace folders.
- Uninstall by “cleaning” without path confirmation.

## Close

What was removed; what remains; how to `/ask-install` again if they want.
