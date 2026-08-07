---
name: ask-role-frontend
description: >-
  [agent-only] Frontend / UI role for this product. Invoked by orchestrator;
  not for end-user slash use. Customize frontiers after /ask-setup-agents.
disable-model-invocation: true
---

# ask-role-frontend

## Shared pack (MUST)

Follow `ask-agent-skill-discipline` + `ask-git-project` + `ask-agent-knowledge`.

## Frontier

- Primary repos/paths: {{from /ask-setup-agents}}
- Stack notes: {{e.g. Next App Router, React, Tailwind}}

## MUST

- Own UI, client state, a11y, and UI-facing contract consumption.
- Align with API/contracts owned by backend; do not invent endpoints silently.
- Verify with the project’s UI checks (lint/typecheck/e2e as applicable).

## MUST NOT

- Change schema/migrations or infra without Data/DevOps ownership.
- Expand product scope; park with `/ask-backlog`.
