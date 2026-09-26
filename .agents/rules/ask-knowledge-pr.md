# Knowledge promotion — PR only (MUST)

**User-scoped** knowledge may be written and pushed **directly** on the default branch.  
**General / team** knowledge MUST land only via **pull request** — never commit+push those paths straight to `main`/`master`.

## Direct OK (auto close-out → commit + push default branch)

| Path | Notes |
|------|--------|
| `users/<email>/knowledge/**` | Deltas |
| `users/<email>/agents/**` | User-only agents (after scope = user) |
| `users/<email>/DELTAS.md`, `IDENTITY.md`, `session-backlog.md` | Tracked personal |
| `users/<email>/work-log/**`, `preferences.yaml`, `MEMORY.md` | Local / gitignore — no commit |
| `consolidation/QUEUE.md` | Queue **proposals** only (no `knowledge/**` body yet) |

## PR required (never push these to default branch from the agent)

| Path | Notes |
|------|--------|
| `knowledge/**` | All global SoT (product, domain, architecture, delivery REQs, roles.md, …) |
| `agents/**` | Team role agents |
| `WORKSPACE.md` | Team multi-root layout |
| Root team docs (`README.md`, `INDEX.md`, `AGENTS.md`, `config.yaml`) when changing product norms | Prefer PR |

## Flow when promoting or editing general knowledge (MUST)

1. Confirm intent with the user (what becomes team SoT).
2. From a clean/default-branch tip: create branch `docs/…` or `feat/…` (kebab-case; optional REQ id).
3. Apply the `knowledge/**` / team `agents/**` / `WORKSPACE.md` changes **on that branch only**.
4. Commit on the branch; `git push -u origin HEAD`.
5. Open a PR with `gh pr create` (summary + what reviewers should check). **Do not merge** unless the user explicitly asks.
6. Tell the user the PR URL. Keep deltas / QUEUE status reflecting “proposed via PR” when relevant.

## Consolidation

- Detect / queue → OK on default branch (`consolidation/QUEUE.md`).
- **Promote / merge into `knowledge/**`** → same PR flow above (branch contains the global file edits).
- Human review happens on the PR; chat “yes” alone is **not** enough to write global on `main`.

## Related

- `AGENTS.md` write rules · `knowledge/conventions/git.md` · skill `ask-git-project`
- User vs team agents: rule `ask-agent-scope` (team agents still need PR after scope = team)
