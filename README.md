# agent-starter-kit

Reusable process engine for coding agents (Cursor, Claude Code, etc.): skill discipline, communication, focus/scope, requirement orchestration, and the **agent-knowledge** skeleton (memory separate from code).

Does not include stack skills or `speckit-*` — those are added per project.

> **Install into a product workspace:** clone this repo, add it as a workspace folder, then `/ask-install` (or ask in plain language). Full guide: **[INSTALL.md](INSTALL.md)**.

## What's here

```text
.cursor/
  rules/     — process rules
  skills/    — shared pack (ask-install, ask-requirement, ask-backlog, …)
agent-knowledge-template/
  — skeleton to clone as an independent git repo
INSTALL.md   — human setup + agent install contract
```

## Language

- **Default English** for code, commits, paths, and durable docs the agent writes.
- **Project-global content language:** `agent-knowledge/config.yaml` → `locale.content` / `locale.paths` (defaults `en` / `en`).
- **Per-user chat language:** `users/<email>/preferences.yaml` → `communication_language` (default `en` if missing). See rule `08-user-communication`.

## Install (summary)

1. Clone + add this repo to the Cursor workspace.
2. Run `/ask-install` (or “install this kit into my working environment”).
3. If you also adopt the engineering standard: first `ai-dev-standard` (`ADOPTION.md`), then this kit.
4. Day-to-day: `/ask-requirement` and `/ask-backlog`.

## Maintenance

A template that is **copied**, not a linked dependency. Useful improvements from a consuming project are brought back by hand, without business content.
