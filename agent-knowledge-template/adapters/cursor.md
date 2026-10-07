# Adapter — Cursor

SoT: product **agent-knowledge** `AGENTS.md` + kit/process **`.agents/skills`**.

## Product wiring (after `/ask-install` with host `cursor` or `both`)

```text
<adapter-home>/
  .agents/skills/           ← process SoT (from kit)
  .cursor/skills → ../.agents/skills
  .cursor/rules/*.mdc       ← Cursor globs / always-on (incl. ask-agent-scope)
  .cursor/agents/ask-*.md   ← RUNTIME MIRROR (materialized; + ## Knowledge MUSTs per role)
  .cursor/rules/ask-knowledge-musts.mdc ← GENERATED always-on index of MUST blocks in knowledge docs
  .cursor/rules/ask-tools-available.mdc ← GENERATED per machine: tools inventory + status here (ask-tools)

agent-knowledge/
  agents/ask-*.md                    ← TEAM SoT (git)
  users/<email>/agents/ask-*.md      ← USER SoT (git)
  knowledge/architecture/agents/roles.md
```

Keep **one** always-on rule that points at agent-knowledge (`ask-agent-knowledge.mdc`).

Create/modify agents via `/ask-setup-agents` — **always** ask user-only vs team.  
`/ask-update` rematerializes SoT → `.cursor/agents/` and MUST blocks → `ask-knowledge-musts.mdc` (contract: skill `ask-retrospective`).

Do **not** paste close-out / delta rules into `.cursor/`; edit agent-knowledge instead.
