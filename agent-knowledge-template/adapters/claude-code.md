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
  .claude/agents/ask-*.md   ← RUNTIME MIRROR (materialized)

agent-knowledge/
  agents/ask-*.md                    ← TEAM SoT (git)
  users/<email>/agents/ask-*.md      ← USER SoT (git)
```

**Do not** create `.cursor/` for Claude-only installs.

Create/modify via `/ask-setup-agents` — always ask user-only vs team.  
`/ask-update` rematerializes SoT → `.claude/agents/`.

## Minimal session

1. Open adapter home (or add it) as cwd / project.
2. Claude loads `CLAUDE.md` + `.claude/skills` + `.claude/rules` + `.claude/agents`.
3. Memory protocol: agent-knowledge `AGENTS.md` (workspace folder).
