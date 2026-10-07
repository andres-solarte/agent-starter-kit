# conversations/

One log per agent conversation (rule `ask-conversation-log`). **Tracked** — follows you to any machine. Summaries only; no secrets.

| Path | Role |
|------|------|
| [INDEX.md](./INDEX.md) | One line per conversation, newest first |
| `YYYY/MM/YYYY-MM-DD-<slug>.md` | The log (zero-padded month; slug = kebab-case topic) |

## File format

```markdown
---
date: YYYY-MM-DD
updated: YYYY-MM-DD
title: "Short topic"
status: open | paused | done
items: [BL-004, REQ-002]
tags: [backlog, tooling]
host: cursor | claude
transcript: "<host conversation id, if known>"
---

# Short topic

## Goal
- …

## Done
- …

## Decisions
- … (link: knowledge/decisions/…)

## Changes
- repo / PR / commit / paths · tools installed

## Items
- BL-004 → done · REQ-002 → in_progress (AC 2/4)

## Open threads / next step
- …
- Resume: `/ask-backlog resume BL-005`
```

## INDEX line

```markdown
| YYYY-MM-DD | Short topic | BL-004, REQ-002 | done | [log](./YYYY/MM/YYYY-MM-DD-short-topic.md) |
```
