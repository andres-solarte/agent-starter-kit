---
name: ask-agent-skill-discipline
description: >-
  Mandatory discipline for all project agents: every action must follow an
  existing project skill; shared skills (git, etc.) apply to every role; on
  gaps the agent must stop, declare the gap, and create or improve the skill
  instead of improvising. Use always.
disable-model-invocation: true
---

# Skill discipline (all agents)

## Guiding principle

1. **Every procedural act** belongs to an **existing skill** (`.agents/skills/`) or a **rule/doc** that a skill cites as source.
2. **Forbidden to improvise** unanchored flows or conventions.
3. **Improvement = create/extend skills** (and docs they cite), not one-chat magic.
4. If the agent **does not know** or **there is no skill**: **say so** (`SKILL GAP`) and **add/extend the skill** (with user OK if the default is to stop).
5. There is a **shared skill pack** that **every** role loads; **product roles** are Cursor **subagents** under `.cursor/agents/` (not skills). Stack/procedure skills (framework, e2e, migrations) remain skills.

## Shared skills (pack — all agents)

| Skill | Required when | Source / notes |
|-------|---------------|----------------|
| `ask-agent-skill-discipline` | Always | This skill |
| `ask-git-project` | Any commit, branch, PR, stage, amend; **agent-knowledge auto close-out** | `agent-knowledge/knowledge/conventions/git.md` (create if missing) |
| `ask-agent-knowledge` | Block close-out / recalling why | Pointer → `agent-knowledge/AGENTS.md` (includes git persist step) |

When delegating or acting, the orchestrator MUST remember the shared pack **plus** the matching **role subagent** (`.cursor/agents/ask-*.md`) and any stack skills that apply.

If a pack skill is missing (or a common practice not listed is discovered):

1. `SKILL GAP` — shared pack.
2. Create/extend the shared skill under `.agents/skills/`.
3. Update the project's role docs (if any, e.g. `agent-knowledge/knowledge/architecture/agents/roles.md`) § Shared skills.
4. Update this section of the skill.

## Before acting

| Question | If the answer is no |
|----------|---------------------|
| Is it Git? → did I load `ask-git-project`? | Load or GAP + create |
| Which **role subagent** (`.cursor/agents/ask-*`) owns this frontier? | `/ask-setup-agents` or add the agent `.md` |
| Which stack/procedure **skill** covers the how? | Declare SKILL GAP |
| Did I already read the skill + sources? | Read first |
| Am I inventing a step? | Stop; extend skill or subagent |

Typical **stack skills** (not role subagents): framework, E2E, DB migrations. Role specialists live in `.cursor/agents/`. External bases do not override monorepo norms.

## Gap protocol (MUST — visible to the user)

```text
SKILL GAP — improving myself (I will not improvise)
- What I needed to do: …
- Pack: shared | role
- What I searched / read: …
- What is missing: nonexistent skill | incomplete skill | doc without skill
- Proposal: create/extend skill `name` with these MUSTs: …
- Meanwhile: (a) create/extend skill now  (b) park  (c) explicit exception
```

- **Default:** do not continue that part.
- **(a):** create/extend `SKILL.md` (+ project doc if it is a norm) **before or alongside** the work.
- **(c):** note in `users/<email>/session-backlog.md` (via `/ask-backlog`).

For **shared pack** gaps, prefer (a): the skill must exist for all agents.

## Valid vs invalid self-improvement

| Valid | Invalid |
|-------|---------|
| Create `ask-git-project` / extend pack | Commit "my style" without skill |
| Extend role **subagent** or stack skill + cite source | Improvise unanchored conventions |
| Declare gap in time | Stay silent and continue |
| `npx skills find` only as a base | External skill overrides ADR/constitution |

## Orchestrator

`ask-orchestrate-requirement` MUST:

1. Assume shared pack on every subtask.
2. Assign **at least one role subagent** (Task / `.cursor/agents/ask-*`) per subtask (plus stack skills as needed).
3. If it cannot map → gap **before** delegating (prefer `/ask-setup-agents` when the role file is missing).

## Turn close-out (gap or improvement)

Which skills were used (shared + role), whether any were created/extended, which gap remains open.
