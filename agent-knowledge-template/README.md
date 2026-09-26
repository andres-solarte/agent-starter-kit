# agent-knowledge

Shared project knowledge **optimized for agents**, in an independent git repo.

Contract: [knowledge/architecture/agent-knowledge-operating-contract.md](./knowledge/architecture/agent-knowledge-operating-contract.md).

## Quick use

1. **Team machine setup (clone this repo first):** [WORKSPACE.md](./WORKSPACE.md) — remotes, sibling layout, multi-root.
2. Agents: [AGENTS.md](./AGENTS.md) (SoT). Optional adapters: [adapters/](./adapters/).
3. Humans: [INDEX.md](./INDEX.md).
4. Config: [config.yaml](./config.yaml) — including nested `locale.content` / `locale.paths`.

Load in `.cursor` / `.claude`: **minimal** (pointers only). The protocol is not duplicated there.

## Layers

- `knowledge/` — global
- `users/<email>/knowledge/` — deltas (same basename)
- `users/<email>/work-log/` — local (not pushed by default)
- `users/<email>/preferences.yaml` — local chat prefs (`communication_language`)
- `consolidation/` — promote / merge

## Identity

Folder = `git config user.email` lowercase **as-is** (e.g. `dev@example.com`).

## Language

- Durable docs: `locale.content` (default `en`)
- Paths: `locale.paths` (always `en`)
- Chat: per-user `preferences.yaml` → `communication_language`

## When using this template in a new project

1. Rename/complete `config.yaml` (`repo:`, `locale:`), this `README.md`, and **[WORKSPACE.md](./WORKSPACE.md)** (remotes + sibling folders).
2. Leave `knowledge/` folders empty until there is real project content (do not invent).
3. Create the first user by copying `users/_template/` → `users/<email>/`.
4. See `INSTALL.md` at the starter-kit root (or run `/ask-install` / `/ask-update`). `/ask-install` should fill `WORKSPACE.md` from the sibling-repos answers.
