# adapters/

Thin, optional wiring for specific coding agents. **Protocol SoT = repo root [`AGENTS.md`](../AGENTS.md)** (+ operating contract).

| File | Tool |
|------|------|
| [cursor.md](./cursor.md) | Cursor (`.cursor/rules` + optional skill pointer) |
| [claude-code.md](./claude-code.md) | Claude Code (`CLAUDE.md` already at repo root) |
| [generic.md](./generic.md) | Any agent that reads `AGENTS.md` |

## Rules for adapters

1. Max ~20–30 lines. Pointers only — no second copy of close-out/delta rules.  
2. Prefer native discovery (`AGENTS.md`, `CLAUDE.md`) over heavy IDE config.  
3. Never require MCP for basic read/write of this repo.  
4. If an adapter grows past a screen, move content into `AGENTS.md` / contract and shrink the adapter.
