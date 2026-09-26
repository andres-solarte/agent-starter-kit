# adapters/

Thin, optional wiring notes for coding agents. **Process SoT = kit `.agents/`** (skills/rules). **Memory SoT = this repo `AGENTS.md`**.

| File | Tool |
|------|------|
| [cursor.md](./cursor.md) | Cursor (`.cursor/` adapter + `.agents/` SoT) |
| [claude-code.md](./claude-code.md) | Claude Code (`.claude/` adapter + `.agents/` SoT) |
| [generic.md](./generic.md) | Any agent that reads `AGENTS.md` |

## Rules for adapters

1. Max ~20–30 lines. Pointers only.
2. Prefer native discovery; never require MCP for basic memory R/W.
3. Product install chooses hosts — Claude-only must not receive `.cursor/`.
