# Memory: editor rules vs agent-knowledge

Container workspace: `{{workspace-name}}/`.

| Location | What goes here |
|----------|----------------|
| `.cursor/rules/` (or `.claude/`, etc.) | Short rules — thin adapters; do not duplicate protocol |
| `PRODUCT.md` / `DESIGN.md` (if they exist) | Visual product — single source; do not copy |
| `agent-knowledge/` | **SoT** for all knowledge and delivery |

## Write here (in agent-knowledge)

- Product, BDR/ADR, domain, design, architecture, conventions
- Specs / specify / PROCESS / NEXT
- Historical archive → `knowledge/archive/`
- Wikilinks policy → `knowledge/WIKILINKS.md`

## What NOT to do

- Do not put the agent protocol only inside `.cursor/` / `.claude/` — the SoT is `agent-knowledge/AGENTS.md`
- Do not duplicate content: link, do not copy
- Do not use `knowledge/archive/` as SoT for implementation
