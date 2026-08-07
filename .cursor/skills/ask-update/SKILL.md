---
name: ask-update
description: >-
  Update an installed agent-starter-kit: resolve kit and product .cursor
  directories (ask if unknown), git pull the kit clone, safely re-merge skills/rules
  without wiping agent-knowledge. Use when the user says /ask-update, "update
  the kit", or "pull agent-starter-kit changes". Does not offer doc scan —
  use /ask-centralize-docs for that.
---

# /ask-update — update kit dependency (user)

Follow **`INSTALL.md` at the kit root** → **Agent contract — update**.

## Flow (MUST)

```text
1. Resolve kit directory + product .cursor/ home (+ agent-knowledge dir to avoid)
2. Ask if paths not recorded / ambiguous
3. git pull in kit directory
4. Re-merge .cursor/ → product .cursor/ home (include new ask-* skills/rules)
5. Leave agent-knowledge content untouched (except missing template stubs / backlog migrate)
6. Summarize — do NOT offer /ask-centralize-docs
```

## Resolve paths

| Path | How |
|------|-----|
| Kit directory | From `ask-project.mdc` / `ask-kit-paths.mdc`, or ask |
| Product `.cursor/` home | Same, or ask |
| agent-knowledge directory | Confirm only to **not** overwrite; needed for backlog migrate |

Do not assume defaults that differ from the original install choices.

## Doc centralization

**Do not** prompt for a workspace doc scan on update. If the user wants that, they run `/ask-centralize-docs` themselves.

## Merge policy / MUST NOT

Same as `INSTALL.md` update contract: no wipe of agent-knowledge; no overwrite of product overlays; no force-push; no commit unless asked.

**Framework path migrations (MUST):** when replacing an old kit path with a new one (rules, backlog files, etc.), **move/merge content then delete the old file**. Do **not** leave pointer stubs.

After merge, verify product `.cursor/` includes rule `ask-route-via-ask-question.mdc`, skill `ask-question`, and skill `ask-centralize-docs` (add if missing — process-critical).

If the product still has **legacy kit rule filenames** (numbered and/or pre-`ask-` names, e.g. `00-project.mdc`, `00-ask-project.mdc`, `16-route-via-ask-question.mdc`, `16-ask-route-via-ask-question.mdc`), add the current `ask-*.mdc` files and remove those obsolete kit-sourced copies (do not delete product-only rules).

**Session backlog:** ensure `users/<email>/session-backlog.md` exists for the current user. Migrate items from legacy `.cursor/out-of-scope.md` or `knowledge/delivery/out-of-scope.md` into that file, then **delete** the legacy files (no stubs).

## Close

Kit revision; what merged into product `.cursor/`; memory path untouched. Optional one line: docs scan is `/ask-centralize-docs` if they ask.
