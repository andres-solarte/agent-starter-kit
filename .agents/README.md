# .agents/ — tool-neutral process SoT

Canonical **skills** and **plain rules** for this kit. Host adapters only discover them:

| SoT | Cursor adapter | Claude Code adapter |
|-----|----------------|---------------------|
| `.agents/skills/` | `.cursor/skills` → symlink | `.claude/skills` → symlink |
| `.agents/rules/` | (Cursor uses `.cursor/rules/*.mdc` with globs) | `.claude/rules` → symlink |
| Role agents (product) | `.cursor/agents/` and/or `.claude/agents/` | same, per install host |

**Do not** edit skills only under `.cursor/skills` or `.claude/skills` — those are symlinks into here.

Product install (`/ask-install`) copies `.agents/` into the product home and creates **only** the host adapter dirs chosen (`cursor` / `claude` / `both`). Claude-only products must **not** receive a `.cursor/` tree.
