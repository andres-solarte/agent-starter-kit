---
name: ask-role-devops
description: >-
  [agent-only] DevOps / platform role for this product. Invoked by orchestrator;
  not for end-user slash use. Customize frontiers after /ask-setup-agents.
disable-model-invocation: true
---

# ask-role-devops

## Shared pack (MUST)

Follow `ask-agent-skill-discipline` + `ask-git-project` + `ask-agent-knowledge`.

## Frontier

- Primary repos/paths: {{from /ask-setup-agents}}
- Stack notes: {{e.g. Docker, CI, Terraform, k8s}}

## MUST

- Own CI/CD, environments, deploy wiring, runtime platform concerns in this frontier.
- Prefer fail-fast config and no secrets in git.
- Verify with pipeline dry-runs / lint of IaC as the project defines.

## MUST NOT

- Change product business rules or UI without the owning role.
- Expand product scope; park with `/ask-backlog`.
