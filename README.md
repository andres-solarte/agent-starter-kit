# agent-starter-kit

Reusable process engine for coding agents (Cursor, Claude Code, etc.): skill discipline, communication, focus/scope, requirement orchestration, and the **agent-knowledge** skeleton (memory separate from code).

Does not include stack skills or `speckit-*` — those are added per project.

> Installation and adoption (new or existing project): **[ADOPTION.md](ADOPTION.md)**.

## What's here

```text
.cursor/
  rules/     — process rules
  skills/    — shared pack (requirement, backlog, git, discipline, …)
agent-knowledge-template/
  — skeleton to clone as an independent git repo
ADOPTION.md  — installation and adoption guide
```

## Language

- **Default English** for code, commits, paths, and durable docs the agent writes.
- **Project-global content language:** `agent-knowledge/config.yaml` → `locale.content` / `locale.paths` (defaults `en` / `en`).
- **Per-user chat language:** `users/<email>/preferences.yaml` → `communication_language` (default `en` if missing). See rule `08-user-communication`.

## Adoption (summary)

1. Follow [ADOPTION.md](ADOPTION.md).
2. If you also adopt the engineering standard: first `ai-dev-standard`, then this kit — see [ai-dev-standard ADOPTION](../ai-dev-standard/ADOPTION.md) (sibling repo) for combined order.
3. First use in the project: `/requirement`.

## Maintenance

A template that is **copied**, not a linked dependency. Useful improvements from a consuming project are brought back by hand, without business content.
