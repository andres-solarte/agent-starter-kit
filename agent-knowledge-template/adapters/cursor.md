# Adapter — Cursor

SoT: product **agent-knowledge** `AGENTS.md` + kit/process **`.agents/skills`**.

## Product wiring (after `/ask-install` with host `cursor` or `both`)

```text
<adapter-home>/
  .agents/skills/           ← SoT (from kit)
  .cursor/skills → ../.agents/skills
  .cursor/rules/*.mdc       ← Cursor globs / always-on
  .cursor/agents/ask-*.md   ← role subagents from /ask-setup-agents
```

Keep **one** always-on rule that points at agent-knowledge (`ask-agent-knowledge.mdc`).

Do **not** paste close-out / delta rules into `.cursor/`; edit agent-knowledge instead.
