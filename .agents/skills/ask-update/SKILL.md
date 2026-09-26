---
name: ask-update
description: >-
  Update an installed agent-starter-kit: resolve kit and product adapter home
  + agent hosts (Cursor and/or Claude), git pull the kit, re-merge .agents/ and
  only the selected host adapters. Never add .cursor to Claude-only products.
  Use for /ask-update. Doc scan is separate (/ask-centralize-docs).
---

# /ask-update — update kit dependency (user)

Follow **`INSTALL.md` at the kit root** → **Agent contract — update**.

## Flow (MUST)

```text
1. Resolve kit dir + adapter home + agent hosts (+ agent-knowledge to avoid)
2. Ask if paths/hosts not recorded / ambiguous
3. git pull in kit directory
4. Re-merge .agents/ → adapter home; re-wire only selected host adapters
5. Leave agent-knowledge untouched (except missing template stubs / backlog migrate)
6. Materialize role agents from AK SoT → host agents/ dirs (team ∪ current user)
7. Claude-only: if .cursor/ kit-sourced exists → offer delete (migration)
8. Surface delta → propose agents if new uncovered repos (scope ask via setup-agents)
9. Once-only / legacy notices as needed
10. Summarize — do NOT offer /ask-centralize-docs
```

## Resolve paths

| Path | How |
|------|-----|
| Kit directory | `ask-project` Kit paths, or ask |
| Product adapter home | Same, or ask |
| Agent hosts | `ask-project` → Agent hosts (`cursor` / `claude` / `both`), or ask |
| agent-knowledge directory | Confirm only to **not** overwrite |

## Merge (MUST)

1. Merge kit `.agents/skills` + `.agents/rules` into `<adapter-home>/.agents/` (safe merge).
2. Refresh host wiring **only** for recorded hosts (same rules as install):
   - cursor → `.cursor/rules` merge; `.cursor/skills` → `.agents/skills`; keep `.cursor/agents`
   - claude → `.claude/skills` + `.claude/rules` → `.agents/…`; keep `.claude/agents`; thin `CLAUDE.md`
3. **If hosts = claude only:** do **not** create or refresh `.cursor/`. If a kit-sourced `.cursor/` exists, **offer to delete** it (list paths) after user yes.
4. **If hosts = cursor only:** do not create `.claude/` unless user expands hosts.
5. Ensure process-critical skills present under `.agents/skills`: `ask-question`, `ask-setup-agents`, `ask-centralize-docs`, route rule (cursor `.mdc` and/or `.agents/rules`). Ensure rules `ask-agent-scope` and `ask-knowledge-pr` exist under `.agents/rules` and cursor `.mdc` when hosts include cursor.

## Materialize role agents (MUST)

After merge, sync runtime host mirrors from agent-knowledge SoT (do not invent agents here):

1. Team: `<agent-knowledge>/agents/ask-*.md`
2. Current user: `<agent-knowledge>/users/<email>/agents/ask-*.md` (`git config user.email` lowercase)
3. Copy into `<adapter-home>/.cursor/agents/` and/or `.claude/agents/` per recorded hosts

Host dirs are mirrors; SoT stays in agent-knowledge (shared via git). Create/modify still goes through `/ask-setup-agents` + scope question.

## Once-only: `/ask-setup-agents` notice (MUST)

If Agents setup notice is pending: announce once (subagents for orchestration); set notice done; offer to run.

## New surfaces → propose agents (MUST)

Same as before: compare siblings vs Known surfaces / `roles.md`; offer `ask-setup-agents` **delta**. Check frontiers under `.cursor/agents` and/or `.claude/agents` per hosts. Do not create silently. If a new sibling remote is confirmed, also offer to add a row to `agent-knowledge/WORKSPACE.md`.

## Legacy migrations (MUST)

- Session backlog / out-of-scope: migrate then delete (no stubs).
- Spec Kit placeholder dirs: delete if empty/placeholder-only.
- Legacy `ask-role-*` skills: offer migrate via setup-agents.
- Numbered pre-`ask-` rule filenames: replace with current names (cursor hosts).

## MUST NOT

- Wipe agent-knowledge.
- Install `.cursor/` into Claude-only products.
- Force-push; commit app/kit unless asked.

## Close

Kit revision; hosts; what merged; materialize counts; Claude-only `.cursor` cleanup if done; surface proposals if any.
