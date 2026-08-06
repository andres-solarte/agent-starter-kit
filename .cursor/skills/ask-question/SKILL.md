---
name: ask-question
description: >-
  Answer questions about this agent framework / kit layout (where is my
  work-log, preferences, kit path, how install/update works, which slash to
  use). Use when the user says /ask-question, asks "where is…", "how do I…",
  or has a how/where question about agent-knowledge or the starter kit.
---

# /ask-question — ask the framework (user)

Short Q&A about **how this kit and agent-knowledge are wired** — not product feature work (that is `/ask-requirement`).

Answer in the user’s chat language (`users/<email>/preferences.yaml` → `communication_language`, default `en`). Be concrete: give **real paths** when known.

## Flow (MUST)

```text
1. Capture the question ($ARGUMENTS or message)
2. Resolve paths (kit / agent-knowledge / .cursor home / user email)
3. Answer from SoT docs + resolved paths (2–6 short sentences)
4. If unknown: say what is missing and how to find it (do not invent paths)
```

## Resolve context (MUST)

1. **User id:** `git config user.email` → lowercase as-is (keep `@`).
2. **Paths** (in order): recorded install (`00-project.mdc`, `ask-kit-paths.mdc`, or similar) → workspace folders that look like kit (`INSTALL.md` + `agent-knowledge-template/`) or agent-knowledge (`AGENTS.md` + `users/`) → **ask** if still ambiguous.
3. Read only what you need: `agent-knowledge/AGENTS.md`, `config.yaml`, `users/<email>/preferences.yaml`, `INSTALL.md` (kit).

## Question router (common)

| User asks about… | Answer from |
|------------------|-------------|
| Work-log / “dónde queda mi worklog” | `<agent-knowledge>/users/<email>/work-log/YYYY/MM/DD.md` (local/gitignored). Layout in `AGENTS.md` + `config.yaml` `work_log`. |
| Preferences / chat language | `<agent-knowledge>/users/<email>/preferences.yaml` → `communication_language` |
| Identity / user folder | `<agent-knowledge>/users/<email>/` + `IDENTITY.md` |
| Global knowledge | `<agent-knowledge>/knowledge/…` |
| Personal deltas | `<agent-knowledge>/users/<email>/knowledge/…` + `DELTAS.md` |
| Kit location / upstream | Kit directory from install record; update via `/ask-update` |
| Product `.cursor/` | Product `.cursor/` home from install record |
| Install / update / uninstall | `INSTALL.md` + `/ask-install`, `/ask-update`, `/ask-uninstall` |
| Which slash for work vs park | `/ask-requirement` vs `/ask-backlog` |
| Out of scope list | Product `.cursor/out-of-scope.md` |
| Locale for docs the agent writes | `agent-knowledge/config.yaml` → `locale.content` |

For other framework questions: search `INSTALL.md`, `AGENTS.md`, `INDEX.md`, then answer with citations (path + one-line why).

## Style (MUST)

- Plain language; one idea per sentence (rule `08-user-communication`).
- Prefer absolute or workspace-clear paths the user can open.
- Do **not** start implementing product features.
- Do **not** dump whole docs — answer the question; offer one follow-up if useful.

## MUST NOT

- Invent install paths when none are recorded — ask or say “not installed / path unknown”.
- Treat this as `/ask-requirement` (no plans, no code changes unless the user switches intent).
- Expose secrets from env files if somehow adjacent.

## Close

Answer first. Optional one line: “Related: …” with one slash or path only if it helps.
