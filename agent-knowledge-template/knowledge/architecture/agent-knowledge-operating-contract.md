---
id: agent-knowledge-operating-contract
type: guide
status: active
scope: architecture
tags: [agent-knowledge, deltas, consolidation]
updated: 2026-08-05
---

# Operating contract — agent-knowledge

Operating norms for the `agent-knowledge` repo. Short source for agents; routing detail in `AGENTS.md`.

## 1. User identity

- Folder: `users/<email>/` — **literal email** lowercase (keep `@`)
- Source: `git config user.email` (not `user.name`)
- Example: `dev@example.com` → `users/dev@example.com/`
- Do not replace `@` with `_at_` (readability > unnecessary escape on macOS/Linux)
- File `users/<email>/IDENTITY.md` MUST exist and list the canonical email
- If the email is `*.local` / empty: warn the human; do not invent another id mid-session
- Prefer the same email as the GitHub account used for this org's remotes

## 2. Language

- Durable agent-written content: `config.yaml` → `locale.content` (default `en`)
- Paths/identifiers: `locale.paths` (always `en`)
- Chat with this user: `users/<email>/preferences.yaml` → `communication_language` (default `en` if missing)
- Nested keys only (`locale.content` / `locale.paths`); do not use flat `locale_content` / `locale_paths`

## 3. Delta file convention (identical basename)

| Global | Individual delta |
|--------|------------------|
| `knowledge/<relpath>/<file>.md` | `users/<email>/knowledge/<relpath>/<file>.md` |

- **Same basename and same relative path.** That is the `same_point`.
- One delta file per user per point (edit in place; no `foo.delta.md` or `foo-andres.md`).
- Content = **diff only** (add / override / question / correction), not a copy of global.
- Frontmatter MUST: `type: delta`, `status`, `delta_of`, `same_point` (relpath without `knowledge/` prefix, e.g. `architecture/foo.md`).
- Net-new: create the path that **will be** global; `delta_of: null` until promote.
- Register in `users/<email>/DELTAS.md`.

## 4. Decision tree (where to write)

```text
Personal preference / scratch?           → users/<email>/preferences.yaml | MEMORY.md
Park for later (personal notes)?         → users/<email>/session-backlog.md
Formal requirement status?               → knowledge/delivery/requirements/ (REQ-NNN)
When / what / why for this block?        → users/<email>/work-log/YYYY/MM/DD.md
Durable learning not (yet) global?       → users/<email>/knowledge/<relpath>/<file>.md (delta)
Ready for the team / already agreed?     → propose consolidation/QUEUE.md → apply knowledge/** via **PR only** (ask-knowledge-pr)
Role subagent create/modify?             → ASK user-only vs team (ask-agent-scope)
  → user-only                            → users/<email>/agents/ask-*.md (direct OK)
  → team                                 → agents/ask-*.md + roles.md via **PR only**
Then materialize host .cursor/.claude agents/ mirrors (after merge, or locally from PR branch)
```

There is no third `memory/` layer for durable facts. Role agents are separate (`agents/` / `users/<email>/agents/`).

## 5. Block close-out (MUST)

1. Append work-log in `users/<email>/work-log/YYYY/MM/DD.md` (**What** + **Why**).
2. If there is reusable learning → create/update delta + `DELTAS.md` (**direct** OK).
3. If several users or a mature delta → propose a row in `consolidation/QUEUE.md` (direct OK). Landing edits in `knowledge/**` → **branch + PR** (rule `ask-knowledge-pr`); never push global SoT to the default branch from the agent.
4. **Persist this repo:** user-scoped tracked changes → commit + push default branch; general/team paths → PR only (see `knowledge/conventions/git.md`). Local-only files stay gitignored.

## 6. Tool-agnostic first

- Protocol SoT = this repo (`AGENTS.md` + this contract).
- Cursor / Claude Code / others: **thin adapters only** (`adapters/`).
- Do not grow `.cursor/`, `.claude/`, etc. with duplicated close-out or delta rules.
- Workspace MUST make this repo visible to the agent (container folder or multi-root).
- **Team layout SoT:** root [`WORKSPACE.md`](../../WORKSPACE.md) — clone **this** repo first; sibling remotes and multi-root steps live there so every machine matches.

## 7. Privacy

- `work-log/`, `MEMORY.md`, `preferences.yaml` are **local by default** (gitignore in the repo).
- Shared git **does** include: `users/<email>/knowledge/**` (deltas), `DELTAS.md`, `IDENTITY.md`, `session-backlog.md`, `users/<email>/agents/**`, team `agents/**`.
- Never paste secrets, tokens, or PII into logs or deltas.
