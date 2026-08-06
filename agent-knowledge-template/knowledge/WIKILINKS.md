---
id: wikilinks-policy
type: guide
status: active
scope: global
tags: [wikilinks]
updated: YYYY-MM-DD
---

# Wikilinks — policy

The SoT of `agent-knowledge` is plain Git/Markdown, not Obsidian.

## Rule

1. Relative Markdown links `[text](./path.md)` (or absolute repo path in skills/rules) — not `[[wikilinks]]`.
2. If migrating content from another tool (Obsidian, Notion, etc.) that uses wikilinks, normalize when touching the file — no big-bang required.
3. Do not introduce `[[…]]` in living indexes (`INDEX.md`, `PROCESS.md`, `decisions/README.md`).
