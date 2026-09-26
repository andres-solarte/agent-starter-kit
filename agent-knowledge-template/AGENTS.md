# AGENTS — agent-knowledge

Tool-agnostic instructions for any coding agent (Cursor, Claude Code, Codex, Copilot, …).
**SoT is this repo.** IDE/dotfile adapters MUST stay thin — see [adapters/README.md](./adapters/README.md).

**Operating contract (MUST):** [knowledge/architecture/agent-knowledge-operating-contract.md](./knowledge/architecture/agent-knowledge-operating-contract.md)

## Language

| Kind | Source | Default |
|------|--------|---------|
| Durable knowledge/docs the agent writes | `config.yaml` → `locale.content` | `en` |
| Paths / identifiers | `locale.paths` | `en` |
| Chat with this user | `users/<email>/preferences.yaml` → `communication_language` | `en` if missing |

Do not use flat keys `locale_content` / `locale_paths` — use nested `locale.content` / `locale.paths`.

## Resolve user id (MUST first)

1. Read `git config user.email` (repo or global).
2. Directory name = email **lowercase as-is** (keep `@`). Example: `dev@example.com`.
3. Path = `users/<email>/` (under this repo).
4. If missing: copy `users/_template/` → `users/<email>/` and fill `IDENTITY.md` (+ `preferences.yaml` for chat language).
5. If email is `*.local` or empty: warn once (provisional identity).

## Scopes (path-aligned)

| Scope | Path |
|-------|------|
| Global | `knowledge/<relpath>/<file>.md` |
| Individual delta | `users/<email>/knowledge/<relpath>/<file>.md` (**same basename**) |

Also under each user (not mirrors): `work-log/` (local), `preferences.yaml` (local), `MEMORY.md` (local), `DELTAS.md` (tracked), `IDENTITY.md` (tracked), `session-backlog.md` (tracked — `/ask-backlog`).

## Read order

1. This file → operating contract
2. `INDEX.md`
3. `knowledge/<relpath>/…`
4. `users/<email>/knowledge/<same relpath>/…` + `DELTAS.md`
5. `users/<email>/preferences.yaml` (chat language)
6. `users/<email>/work-log/` (local when/what/why)
7. `consolidation/QUEUE.md` if consolidating

## Delta naming (locked)

- Same relative path + **same filename** as global.
- One delta file per user per point; edit in place.
- Content = diff only. Template: `templates/delta.md`.
- Example: `knowledge/architecture/foo.md` ↔ `users/<email>/knowledge/architecture/foo.md`

## Where to write

| Need | Write |
|------|-------|
| Prefs / scratch | `users/<email>/preferences.yaml` / `MEMORY.md` (local) |
| When / what / why | `users/<email>/work-log/` (local) |
| Durable not-yet-global | delta under `users/<email>/knowledge/…` |
| Team SoT | `knowledge/…` via consolidation + **PR only** (never push global to default branch) |
| Team role agents | `agents/ask-*.md` (scope = team) → **PR only** |
| User-only role agents | `users/<email>/agents/ask-*.md` (direct OK) |

## Close-out (MUST every meaningful block)

1. Append work-log at `users/<email>/work-log/YYYY/MM/DD.md` (**What** + **Why**). Create year/month dirs if needed (zero-padded `MM`/`DD`).
2. If reusable learning → delta + `DELTAS.md`.
3. If mature / multi-user → propose `consolidation/QUEUE.md`; landing in `knowledge/**` is **PR only** (rule `ask-knowledge-pr`).
4. **Git (this repo only):** follow `knowledge/conventions/git.md` + `ask-git-project` → **direct** commit/push for **user-scoped** tracked paths; for `knowledge/**`, team `agents/**`, `WORKSPACE.md` → **branch + PR** (do not push those to default branch). App/kit repos out of scope unless asked.

## Before "why did we…?" / resuming related work

1. `users/<email>/work-log/`
2. `users/<email>/DELTAS.md` + matching deltas
3. Global `knowledge/…` for the same relpath

## Routing

| Task | Path |
|------|------|
| Same workspace on every machine (clone this repo first) | [WORKSPACE.md](./WORKSPACE.md) |
| Team role agents (SoT) | [agents/](./agents/) |
| User-only role agents | `users/<email>/agents/` |
| What to do next | `knowledge/delivery/NEXT.md` |
| Requirement registry | `knowledge/delivery/requirements/INDEX.md` + `REQ-NNN-*.md` |
| Fix on existing REQ | `/ask-requirement-fix` |
| Session backlog (`/ask-backlog`, personal) | `users/<email>/session-backlog.md` |
| Global docs | `knowledge/…` |
| Delta | `users/<email>/knowledge/<same-relpath>` |
| Delta index | `users/<email>/DELTAS.md` |
| Consolidation | `consolidation/` |
| Work log | `users/<email>/work-log/YYYY/MM/DD.md` (gitignored) |
| User prefs | `users/<email>/preferences.yaml` (gitignored) |
| Tool wiring | `adapters/` |

## Write rules

| Location | Policy |
|----------|--------|
| `knowledge/**` | **PR only** (never direct to default branch) |
| `agents/**` (team role agents) | Scope = team + **PR only** |
| `WORKSPACE.md` | **PR only** |
| `users/<email>/agents/**` | Direct OK after scope = user |
| `users/<email>/knowledge/**` | Direct OK (deltas) |
| `users/<email>/work-log/**` | Append OK (local) |
| `users/<email>/DELTAS.md`, `session-backlog.md`, `IDENTITY.md` | Direct OK |
| `consolidation/QUEUE.md` | Direct OK (proposals); promote into `knowledge/**` via PR |

Rule: `ask-knowledge-pr`.

## Never

- Put the operating protocol only inside `.cursor/`, `.claude/`, etc.
- Copy whole global files into the user mirror
- Use `user.name` as folder id
- Dump transcripts or secrets into logs/deltas

## First use in a new project

1. Rename/fill this repo's `README.md`, `config.yaml` (`repo:` and `locale:` fields), and **`WORKSPACE.md`** (remotes + siblings) for the new project.
2. Fill `knowledge/product/`, `knowledge/domain/`, `knowledge/architecture/stack-versions.md` as the project takes shape — these start empty on purpose.
3. Create the first `users/<email>/` from `users/_template/`.
4. Wikilinks policy: [knowledge/WIKILINKS.md](./knowledge/WIKILINKS.md).
5. Teammates joining later: follow **`WORKSPACE.md`** (this repo first), not a one-off folder layout.
