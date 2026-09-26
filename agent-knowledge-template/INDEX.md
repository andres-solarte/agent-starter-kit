# INDEX — agent-knowledge

Start with [AGENTS.md](./AGENTS.md) and the [operating contract](./knowledge/architecture/agent-knowledge-operating-contract.md).
**New machine / team workspace:** [WORKSPACE.md](./WORKSPACE.md) — clone this repo first, then the sibling remotes.
Adapters: [adapters/](./adapters/). Config: [config.yaml](./config.yaml).
Wikilinks: [knowledge/WIKILINKS.md](./knowledge/WIKILINKS.md).

## Map

| Area | Path |
|------|------|
| Team workspace (multi-root) | [WORKSPACE.md](./WORKSPACE.md) |
| Team role agents | [agents/](./agents/) |
| Product | [knowledge/product/](./knowledge/product/) |
| Decisions | [knowledge/decisions/](./knowledge/decisions/) |
| Domain | [knowledge/domain/](./knowledge/domain/) |
| Design | [knowledge/design/](./knowledge/design/) |
| Architecture | [knowledge/architecture/](./knowledge/architecture/) |
| Conventions | [knowledge/conventions/](./knowledge/conventions/) |
| Requirements | [knowledge/delivery/requirements/](./knowledge/delivery/requirements/) |
| Process | [knowledge/delivery/PROCESS.md](./knowledge/delivery/PROCESS.md) |
| What's next | [knowledge/delivery/NEXT.md](./knowledge/delivery/NEXT.md) |
| Archive | [knowledge/archive/](./knowledge/archive/) |

## Layers

| Layer | Path | Use |
|-------|------|-----|
| Global | [knowledge/](./knowledge/) | Shared SoT |
| Individual delta | `users/<email>/knowledge/<same-relpath>/<same-file>.md` | Identical basename; diff only |
| Indexes | `DELTAS.md`, [consolidation/](./consolidation/) | Detect and promote/merge |
| Work log | `users/<email>/work-log/` | Local (gitignore) |
| Prefs | `users/<email>/preferences.yaml` | Local chat language, etc. |

Identity: literal email (`users/<email>/`). See [users/README.md](./users/README.md).

## Outside this repo

- Application code (apps, services, libraries)
- `.cursor/` / `.claude/` — thin adapters (rules/skills point here)

## How to maintain

1. Deltas: same basename as global — **direct** under `users/<email>/`.
2. Close-out via skill `ask-agent-knowledge`.
3. Promote to global `knowledge/**` only via **pull request** (rule `ask-knowledge-pr`).
4. Wikilinks: normalize when touching ([WIKILINKS.md](./knowledge/WIKILINKS.md)).
