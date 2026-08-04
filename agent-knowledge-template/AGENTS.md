# AGENTS — agent-knowledge

Tool-agnostic instructions for any coding agent (Cursor, Claude Code, Codex, Copilot, …).
**SoT is this repo.** IDE/dotfile adapters MUST stay thin — see [adapters/README.md](./adapters/README.md).

**Operating contract (MUST):** [knowledge/architecture/agent-knowledge-operating-contract.md](./knowledge/architecture/agent-knowledge-operating-contract.md)

## Resolve user id (MUST first)

1. Read `git config user.email` (repo or global).
2. Directory name = email **lowercase as-is** (keep `@`). Example: `dev@example.com`.
3. Path = `users/<email>/` (under this repo).
4. If missing: copy `users/_template/` → `users/<email>/` and fill `IDENTITY.md`.
5. If email is `*.local` or empty: warn once (provisional identity).

## Scopes (path-aligned)

| Scope | Path |
|-------|------|
| Global | `knowledge/<relpath>/<file>.md` |
| Individual delta | `users/<email>/knowledge/<relpath>/<file>.md` (**same basename**) |

Also under each user (not mirrors): `work-log/` (local), `preferences.md` (local), `MEMORY.md` (local), `DELTAS.md` (tracked), `IDENTITY.md` (tracked).

## Read order

1. This file → operating contract
2. `INDEX.md`
3. `knowledge/<relpath>/…`
4. `users/<email>/knowledge/<same relpath>/…` + `DELTAS.md`
5. `users/<email>/work-log/` (local when/what/why)
6. `consolidation/QUEUE.md` if consolidating

## Delta naming (locked)

- Same relative path + **same filename** as global.
- One delta file per user per point; edit in place.
- Content = diff only. Template: `templates/delta.md`.
- Example: `knowledge/architecture/foo.md` ↔ `users/<email>/knowledge/architecture/foo.md`

## Where to write

| Need | Write |
|------|-------|
| Prefs / scratch | `users/<email>/preferences.md` / `MEMORY.md` (local) |
| When / what / why | `users/<email>/work-log/` (local) |
| Durable not-yet-global | delta under `users/<email>/knowledge/…` |
| Team SoT | `knowledge/…` via consolidation only |

## Close-out (MUST every meaningful block)

1. Append work-log at `users/<email>/work-log/YYYY/MM/DD.md` (**Qué** + **Por qué**). Create year/month dirs if needed (zero-padded `MM`/`DD`).
2. If reusable learning → delta + `DELTAS.md`.
3. If mature / multi-user → propose `consolidation/QUEUE.md` (confirm before writing global).

## Before "why did we…?" / resuming related work

1. `users/<email>/work-log/`
2. `users/<email>/DELTAS.md` + matching deltas
3. Global `knowledge/…` for the same relpath

## Routing

| Task | Path |
|------|------|
| What to do next | `knowledge/delivery/NEXT.md` |
| Global docs | `knowledge/…` |
| Delta | `users/<email>/knowledge/<same-relpath>` |
| Delta index | `users/<email>/DELTAS.md` |
| Consolidation | `consolidation/` |
| Work log | `users/<email>/work-log/YYYY/MM/DD.md` (gitignored) |
| Tool wiring | `adapters/` |

## Write rules

| Location | Policy |
|----------|--------|
| `knowledge/**` | Confirm / PR |
| `users/<email>/knowledge/**` | Delta OK |
| `users/<email>/work-log/**` | Append OK (local) |
| `consolidation/**` | Confirm |

## Never

- Put the operating protocol only inside `.cursor/`, `.claude/`, etc.
- Copy whole global files into the user mirror
- Use `user.name` as folder id
- Dump transcripts or secrets into logs/deltas

## First use in a new project

1. Rename/fill this repo's `README.md`, `config.yaml` (`repo:` field) for the new project.
2. Fill `knowledge/product/`, `knowledge/domain/`, `knowledge/architecture/stack-versiones.md` as the project takes shape — these start empty on purpose.
3. Create the first `users/<email>/` from `users/_template/`.
4. If the project wants a Spec Kit–based delivery process, install `github-spec-kit` and populate `knowledge/delivery/specify/` — see `knowledge/delivery/PROCESS.md`.
5. Wikilinks policy: [knowledge/WIKILINKS.md](./knowledge/WIKILINKS.md).
