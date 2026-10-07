---
id: tooling-inventory
type: guide
status: active
scope: tooling
tags: [tooling, mcp, cli, onboarding]
updated: YYYY-MM-DD
---

# Tool inventory

What agents (and developers) need to work on this product: MCP servers, CLIs, SDKs, services, runtimes. How to install, configure, and verify each. **Team SoT — PR only.** Personal tools: `users/<email>/knowledge/tooling/INVENTORY.md`.

Maintained by `/ask-tools` (scan at install; `/ask-tools add` when a new tool appears; checked at REQ retrospective). Status per machine lives in `users/<email>/tools.local.yaml` (local) and is materialized into the always-on rule `ask-tools-available`.

App runtime / library versions: [stack-versions.md](../architecture/stack-versions.md).

**Never** write secret values here — only env var names and where to obtain them.

Entry format (skill `ask-tools`):

```markdown
### <id> — <name>
- Kind: cli | mcp | sdk | service | runtime | ide-extension | other
- Purpose: …
- Used by: all | ask-<role> | skill:<name>
- Need: required | optional
- Hosts: any | cursor | claude
- Install: macOS `…` · Linux `…` · Windows `…`
- Configure: … · env: NAME (where to get it)
- MCP config: (kind mcp) server, command/url, scope, target file per host
- Verify: `…`
- Docs: <url>
- Evidence: <paths>
```

## Tools

(none yet — run `/ask-tools scan`)
