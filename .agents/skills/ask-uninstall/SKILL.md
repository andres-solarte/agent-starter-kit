---
name: ask-uninstall
description: >-
  Uninstall agent-starter-kit wiring: ask which pieces to remove (kit clone,
  agent-knowledge, .agents SoT, .cursor and/or .claude adapters), confirm, then
  delete only what was approved. Use for /ask-uninstall.
---

# /ask-uninstall — remove kit wiring (user)

Follow **`INSTALL.md` at the kit root** → **Agent contract — uninstall**.

## Flow (MUST)

```text
1. Resolve kit dir, agent-knowledge dir, adapter home, hosts
2. Q&A: what to remove (each piece independently)
3. Summary of exact paths → explicit yes
4. Perform only approved removals
5. Close
```

## Q&A (MUST — per piece)

| Piece | Options | Default |
|-------|---------|---------|
| **Kit directory** | keep / delete | **keep** |
| **agent-knowledge** | keep / delete | **keep** (confirm path/phrase if delete) |
| **`.agents/` SoT** | keep / remove kit-sourced ask-* skills+rules | **remove kit-sourced** |
| **`.cursor/`** (if present) | keep / remove kit-sourced rules+skills link+ask-* agents / remove entire `.cursor/` | **remove kit-sourced** |
| **`.claude/`** (if present) | keep / remove kit-sourced links+agents / remove entire `.claude/` | **remove kit-sourced** |
| **`CLAUDE.md`** at adapter home | keep / delete if kit-written | follow `.claude/` choice |

Never delete product-only stack skills/rules unless listed and approved.

## Confirm gate (MUST)

List exact paths. Require clear yes.

## Execution

1. Remove only approved adapter / `.agents` kit pieces.
2. Delete agent-knowledge / kit only if approved.
3. No force-push; no app repo wipes; no commit unless asked.

## Close

What was removed; what remains; how to `/ask-install` again.
