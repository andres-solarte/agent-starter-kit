---
name: ask-update
description: >-
  Update an installed agent-starter-kit: resolve kit and product .cursor
  directories (ask if unknown), git pull the kit clone, safely re-merge skills/rules
  without wiping agent-knowledge. Once, mention /ask-setup-agents if not yet
  announced. Use when the user says /ask-update, "update the kit", or "pull
  agent-starter-kit changes". Does not offer doc scan — use
  /ask-centralize-docs for that.
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
6. Surface delta: compare workspace sibling repos vs Known surfaces / roles.md → if new uncovered apps, propose agents
7. If legacy ask-role-* skills exist: mention once that /ask-setup-agents migrates them to .cursor/agents/ (offer to run)
8. Once-only notice: /ask-setup-agents (if flag pending)
9. Summarize — do NOT offer /ask-centralize-docs
```

## Resolve paths

| Path | How |
|------|-----|
| Kit directory | From `ask-project.mdc` / `ask-kit-paths.mdc`, or ask |
| Product `.cursor/` home | Same, or ask |
| agent-knowledge directory | Confirm only to **not** overwrite; needed for backlog migrate |

Do not assume defaults that differ from the original install choices.

## Once-only: `/ask-setup-agents` notice (MUST)

If `ask-project.mdc` has **no** Agents section, or `Update notice for /ask-setup-agents:` is missing/`pending`:

1. In the close, **one short paragraph** (chat language): `/ask-setup-agents` analyzes business + stack and creates **Cursor subagents** under `.cursor/agents/` plus `roles.md` for orchestration. Offer to run it now (yes) or later.
2. Set `Update notice for /ask-setup-agents: done` in `ask-project.mdc` after announcing (whether or not they run it).
3. Do **not** re-run full analysis every update. Do **not** re-announce if the flag is already `done`.

If they say yes → run `ask-setup-agents` skill. If no → leave roles as-is.

## New surfaces → propose agents (MUST)

After merge, inventory workspace sibling repos (exclude kit, agent-knowledge, vendor/build dirs). Compare to:

- `ask-project.mdc` → `Known surfaces`, and/or
- `roles.md` Surfaces / primary-repos columns

If there is at least one **new** app/service surface not covered by an existing `.cursor/agents/ask-*.md` frontier:

1. In the close (chat language), list the new surfaces and say a matching **subagent** should be added (nature/scope of that surface).
2. Ask granularity if several share a specialty (type vs per-surface) — same question as `/ask-setup-agents`.
3. Offer to run **`ask-setup-agents` in delta mode** now (yes → run that skill scoped to gaps). Do **not** create agents silently.
4. If the user declines, leave a one-line note under Open session-backlog or simply report; do not block the update.

If no new uncovered surfaces → skip this section.

## Doc centralization

**Do not** prompt for a workspace doc scan on update. If the user wants that, they run `/ask-centralize-docs` themselves.

## Merge policy / MUST NOT

Same as `INSTALL.md` update contract: no wipe of agent-knowledge; no overwrite of product overlays; no force-push; no commit unless asked.

**Framework path migrations (MUST):** when replacing an old kit path with a new one (rules, backlog files, etc.), **move/merge content then delete the old file**. Do **not** leave pointer stubs.

After merge, verify product `.cursor/` includes rule `ask-route-via-ask-question.mdc`, skills `ask-question`, `ask-centralize-docs`, and `ask-setup-agents` (add if missing — process-critical).

If the product still has **legacy kit rule filenames** (numbered and/or pre-`ask-` names, e.g. `00-project.mdc`, `00-ask-project.mdc`, `16-route-via-ask-question.mdc`, `16-ask-route-via-ask-question.mdc`), add the current `ask-*.mdc` files and remove those obsolete kit-sourced copies (do not delete product-only rules).

**Session backlog:** ensure `users/<email>/session-backlog.md` exists for the current user. Migrate items from legacy `.cursor/out-of-scope.md` or `knowledge/delivery/out-of-scope.md` into that file, then **delete** the legacy files (no stubs).

**Legacy Spec Kit paths (MUST):** under agent-knowledge, if `knowledge/delivery/specify/` or `knowledge/delivery/specs/` exist and contain **only** kit placeholder README(s) (or are empty), **delete** those directories. If they contain real product content, do **not** delete — tell the user once and leave them. Also remove obsolete `ask-project.mdc` lines pointing at those paths; point at `knowledge/delivery/requirements/` instead. Ensure `knowledge/delivery/requirements/` exists (copy from kit template if missing).

## Close

Kit revision; what merged into product `.cursor/`; memory path untouched; new-surface agent proposal if any; once-only setup-agents notice if applicable. Optional one line: docs scan is `/ask-centralize-docs` if they ask.
