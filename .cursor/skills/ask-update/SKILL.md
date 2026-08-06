---
name: ask-update
description: >-
  Update an installed agent-starter-kit: resolve kit and product .cursor
  directories (ask if unknown), git pull the kit clone, safely re-merge skills/rules
  without wiping agent-knowledge. Use when the user says /ask-update, "update
  the kit", or "pull agent-starter-kit changes".
---

# /ask-update — update kit dependency (user)

Follow **`INSTALL.md` at the kit root** → **Agent contract — update**.

## Flow (MUST)

```text
1. Resolve kit directory + product .cursor/ home (+ agent-knowledge dir to avoid)
2. Ask if paths not recorded / ambiguous
3. git pull in kit directory
4. Re-merge .cursor/ → product .cursor/ home
5. Leave agent-knowledge untouched; summarize
```

## Resolve paths

| Path | How |
|------|-----|
| Kit directory | From `00-project.mdc` / `ask-kit-paths.mdc`, or ask |
| Product `.cursor/` home | Same, or ask |
| agent-knowledge directory | Confirm only to **not** overwrite; ask if unclear |

Do not assume defaults that differ from the original install choices.

## Merge policy / MUST NOT

Same as `INSTALL.md` update contract: no wipe of agent-knowledge; no overwrite of product overlays; no force-push; no commit unless asked.

After merge, verify product `.cursor/` includes rule `16-route-via-ask-question.mdc` and skill `ask-question` (add if missing — process-critical).

## Close

Kit revision; what merged into product `.cursor/`; memory path untouched.
