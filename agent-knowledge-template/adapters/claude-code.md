# Adapter — Claude Code

SoT: product **agent-knowledge** `AGENTS.md` + kit/process **`.agents/skills`**.

## Product wiring (after `/ask-install` with host `claude` or `both`)

```text
<adapter-home>/
  CLAUDE.md                 ← thin pointer
  .agents/skills/           ← process SoT (from kit)
  .agents/rules/            ← plain rules SoT (incl. ask-agent-scope)
  .claude/skills → ../.agents/skills
  .claude/rules  → ../.agents/rules
  .claude/agents/ask-*.md   ← RUNTIME MIRROR (materialized; + ## Knowledge MUSTs per role)
  .agents/rules/ask-knowledge-musts.md ← GENERATED index of MUST blocks in knowledge docs; imported from CLAUDE.md
  .agents/rules/ask-tools-available.md ← GENERATED per machine: tools + status (ask-tools); imported from CLAUDE.md

agent-knowledge/
  agents/ask-*.md                    ← TEAM SoT (git)
  users/<email>/agents/ask-*.md      ← USER SoT (git)
```

**Do not** create `.cursor/` for Claude-only installs.

Create/modify via `/ask-setup-agents` — always ask user-only vs team.  
`/ask-update` rematerializes SoT → `.claude/agents/` and MUST blocks → `.agents/rules/ask-knowledge-musts.md` (contract: skill `ask-retrospective`). Thin `CLAUDE.md` MUST contain the lines `@.agents/rules/ask-knowledge-musts.md` and `@.agents/rules/ask-tools-available.md` so they load every session.

## Minimal session

1. Open adapter home (or add it) as cwd / project.
2. Claude loads `CLAUDE.md` + `.claude/skills` + `.claude/rules` + `.claude/agents`.
3. Memory protocol: agent-knowledge `AGENTS.md` (workspace folder).
