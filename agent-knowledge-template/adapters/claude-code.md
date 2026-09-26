# Adapter — Claude Code

SoT: product **agent-knowledge** `AGENTS.md` + kit/process **`.agents/skills`**.

## Product wiring (after `/ask-install` with host `claude` or `both`)

```text
<adapter-home>/
  CLAUDE.md                 ← thin pointer
  .agents/skills/           ← SoT (from kit)
  .agents/rules/            ← plain rules SoT
  .claude/skills → ../.agents/skills
  .claude/rules  → ../.agents/rules
  .claude/agents/ask-*.md   ← role subagents from /ask-setup-agents
```

**Do not** create `.cursor/` for Claude-only installs.

## Minimal session

1. Open adapter home (or add it) as cwd / project.
2. Claude loads `CLAUDE.md` + `.claude/skills` + `.claude/rules` + `.claude/agents`.
3. Memory protocol: agent-knowledge `AGENTS.md` (workspace folder).
