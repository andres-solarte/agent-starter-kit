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
Learning from a REQ / fix / correction? → edit the doc that owns the topic (§7) + MUST block if critical (§8)
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

## 7. Learnings extend existing knowledge (MUST)

A learning (retrospective, fix root cause, user correction) **edits the doc that already owns the topic** — it is not stored in a separate lessons list.

| Learning is about… | Edit |
|--------------------|------|
| A decision (new, changed, reversed) | `knowledge/decisions/…` — new BDR/ADR or `superseded` + new record (rule `ask-decisions`); update docs that depend on it |
| A convention / how we build | `knowledge/conventions/…` |
| A tool agents use (MCP, CLI, SDK, service) — new, changed, or setup steps | `knowledge/tooling/INVENTORY.md` (skill `ask-tools`) |
| Architecture, domain, product, design facts | Their doc under `knowledge/…` |
| How a role works (its frontier, checks it must run) | Role agent SoT (`agents/ask-*.md` / `users/<email>/agents/`) — scope rule `ask-agent-scope` |
| The delivery process itself | `knowledge/delivery/PROCESS.md`, or kit skill gap (`ask-agent-skill-discipline`) |

Modify the existing statement when it was wrong or incomplete (do not append a contradiction). Create a new doc only when no doc owns the topic, and link it from the nearest index. Team docs → PR; personal → same-basename delta.

## 8. Agent MUST blocks (critical knowledge)

Docs under `knowledge/` are not auto-loaded. A statement whose omission would cause a repeat mistake is marked **inside its doc** as a MUST block:

```markdown
> **MUST (agents)** · Applies to: all | ask-backend, ask-qa · Source: REQ-012, REQ-019
> When <trigger>, do <X> / don't <Y>. (1–2 lines; detail stays in the doc around it)
```

- The doc stays the SoT; the block is the short, enforceable form of what the doc says.
- Same learning again → add the REQ to `Source` (do not duplicate the block). Three or more sources → propose an automated check (test/lint/CI) as a follow-up, then remove the block once enforced.
- When the doc changes and the block no longer holds → edit or delete the block in the same change.
- Personal blocks may live in user deltas (same basename); a team block pending PR may be copied to the user delta with `· Pending: <PR URL>` until merged.
- Budget: ≤ ~25 active `all` blocks and ≤ ~10 per role across the repo; over budget → merge or automate.

**Materialized** (generated, never hand-edited) by skill `ask-retrospective` → *Materialize MUSTs*: always-on host rule `ask-knowledge-musts` (`Applies to: all`: one line + link each) and a `## Knowledge MUSTs` block in each role agent mirror. Docs under `knowledge/archive/` or with `status: superseded` are skipped.

## 9. Privacy

- `work-log/`, `MEMORY.md`, `preferences.yaml` are **local by default** (gitignore in the repo).
- Shared git **does** include: `users/<email>/knowledge/**` (deltas), `DELTAS.md`, `IDENTITY.md`, `session-backlog.md`, `users/<email>/agents/**`, team `agents/**`.
- Never paste secrets, tokens, or PII into logs or deltas.
