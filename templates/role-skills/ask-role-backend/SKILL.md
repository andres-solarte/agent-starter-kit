---
name: ask-role-backend
description: >-
  [agent-only] Backend / API role for this product. Invoked by orchestrator;
  not for end-user slash use. Customize frontiers after /ask-setup-agents.
disable-model-invocation: true
---

# ask-role-backend

## Shared pack (MUST)

Follow `ask-agent-skill-discipline` + `ask-git-project` + `ask-agent-knowledge`.

## Frontier

- Primary repos/paths: {{from /ask-setup-agents}}
- Stack notes: {{e.g. NestJS, FastAPI, auth boundary}}

## MUST

- Own API surface, validation at the edge, domain services in this frontier.
- Coordinate schema changes with Data; keep contracts explicit for Frontend.
- Verify with API tests / typecheck as the project defines.

## MUST NOT

- Own UI layouts or infra-as-code unless dual-hatted and confirmed in roles.md.
- Expand product scope; park with `/ask-backlog`.
