---
name: ask-update
description: >-
  Update an installed agent-starter-kit: git pull the kit clone, then safely
  re-merge .cursor rules/skills into the product home without wiping
  agent-knowledge. Use when the user says /ask-update, "update the kit", or
  "pull agent-starter-kit changes".
---

# /ask-update — update kit dependency (user)

Follow **`INSTALL.md` at the kit root** → **Agent contract — update**.

## When to use

- Kit already installed (`/ask-install` done).
- User wants upstream process changes without losing product memory.

## Flow (MUST)

```text
1. Resolve kit root + product home
2. git status in kit; warn if dirty
3. git pull (or fetch+merge per user)
4. Re-merge .cursor/ → product home (same policy as install)
5. Do not overwrite agent-knowledge content
6. Summarize new/changed skills and rules
```

## Resolve paths

- Kit root: folder with `INSTALL.md` + `agent-knowledge-template/` (often still in the workspace).
- Product home: where product `.cursor/` and `agent-knowledge/` live — ask if unclear.

## Merge policy (MUST)

Same as install: copy missing; on conflict keep product overlays (`00-project.mdc`, stack skills, `out-of-scope.md` content); merge critical MUSTS only if missing.

## agent-knowledge (MUST NOT wipe)

- Never re-copy the full template over an existing `agent-knowledge/`.
- Never delete `knowledge/` or `users/` data.
- Optional: add **new** empty dirs from an upstream template only with user OK.

## MUST NOT

- `rm -rf` kit `.git` or product `agent-knowledge/.git`.
- Force-push.
- Commit unless asked.

## Close

Kit revision pulled (short hash/message if available); what was merged into product `.cursor/`; confirm memory untouched.
