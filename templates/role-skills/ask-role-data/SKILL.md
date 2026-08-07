---
name: ask-role-data
description: >-
  [agent-only] Data / persistence role for this product. Invoked by orchestrator;
  not for end-user slash use. Customize frontiers after /ask-setup-agents.
disable-model-invocation: true
---

# ask-role-data

## Shared pack (MUST)

Follow `ask-agent-skill-discipline` + `ask-git-project` + `ask-agent-knowledge`.

## Frontier

- Primary repos/paths: {{from /ask-setup-agents}}
- Stack notes: {{e.g. PostgreSQL, Drizzle, migrations}}

## MUST

- Own schema, migrations, and query boundaries for owned aggregates.
- Keep a single system of record per aggregate; coordinate API impact with Backend.
- Verify migrations apply cleanly in the project’s local/CI path.

## MUST NOT

- Ship breaking schema without Backend/Frontend contract awareness.
- Expand product scope; park with `/ask-backlog`.
