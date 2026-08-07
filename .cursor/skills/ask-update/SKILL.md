---
name: ask-update
description: >-
  Update an installed agent-starter-kit: resolve kit and product .cursor
  directories (ask if unknown), git pull the kit clone, safely re-merge skills/rules
  without wiping agent-knowledge, then offer an optional workspace doc scan
  (/ask-centralize-docs). Use when the user says /ask-update, "update the kit",
  or "pull agent-starter-kit changes".
---

# /ask-update — update kit dependency (user)

Follow **`INSTALL.md` at the kit root** → **Agent contract — update**.

## Flow (MUST)

```text
1. Resolve kit directory + product .cursor/ home (+ agent-knowledge dir to avoid)
2. Ask if paths not recorded / ambiguous
3. git pull in kit directory
4. Re-merge .cursor/ → product .cursor/ home (include ask-centralize-docs if new)
5. Leave agent-knowledge content untouched
6. Offer gated doc scan → if yes, run ask-centralize-docs; if no, skip
7. Summarize
```

## Resolve paths

| Path | How |
|------|-----|
| Kit directory | From `ask-project.mdc` / `ask-kit-paths.mdc`, or ask |
| Product `.cursor/` home | Same, or ask |
| agent-knowledge directory | Confirm only to **not** overwrite; needed if user accepts doc scan |

Do not assume defaults that differ from the original install choices.

## Doc scan offer (MUST after merge)

Ask in the user’s chat language whether to scan the **entire workspace** and centralize docs into agent-knowledge (same as install).

- **Yes** → follow `.cursor/skills/ask-centralize-docs/SKILL.md` (authorize details, inventory, copy, recommend cleanup).
- **No** → skip; mention `/ask-centralize-docs` for later.
- Never start a recursive doc scan without this **yes**.

Useful for workspaces that installed the kit before this step existed.

## Merge policy / MUST NOT

Same as `INSTALL.md` update contract: no wipe of agent-knowledge; no overwrite of product overlays; no force-push; no commit unless asked.

**Framework path migrations (MUST):** when replacing an old kit path with a new one (rules, backlog files, etc.), **move/merge content then delete the old file**. Do **not** leave pointer stubs.

After merge, verify product `.cursor/` includes rule `ask-route-via-ask-question.mdc`, skill `ask-question`, and skill `ask-centralize-docs` (add if missing — process-critical).

If the product still has **legacy kit rule filenames** (numbered and/or pre-`ask-` names, e.g. `00-project.mdc`, `00-ask-project.mdc`, `16-route-via-ask-question.mdc`, `16-ask-route-via-ask-question.mdc`), add the current `ask-*.mdc` files and remove those obsolete kit-sourced copies (do not delete product-only rules).

**Session backlog:** ensure `users/<email>/session-backlog.md` exists for the current user. Migrate items from legacy `.cursor/out-of-scope.md` or `knowledge/delivery/out-of-scope.md` into that file, then **delete** the legacy files (no stubs).

## Close

Kit revision; what merged into product `.cursor/`; memory path untouched; whether doc scan ran or was deferred.
