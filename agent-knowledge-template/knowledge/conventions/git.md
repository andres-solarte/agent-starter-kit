# Git conventions (project)

Norms for Git in this product workspace. Cursor shared skill: `ask-git-project`.  
Knowledge promotion: rule `ask-knowledge-pr`.

## Repos

| Repo | Commit / push |
|------|----------------|
| **agent-knowledge** | Split by path — see below |
| App / product code repos | Only when the user asks |
| Kit clone (`agent-starter-kit`) | Only when the user asks |

## agent-knowledge — user paths (direct)

After a meaningful block/loop close, or durable **user-scoped** tracked writes (deltas, `session-backlog.md`, user `agents/ask-*.md`, `DELTAS.md`, `consolidation/QUEUE.md` proposals):

1. Work in the **agent-knowledge** directory only.
2. Respect `.gitignore` (do not force-add `work-log/`, `preferences.yaml`, `MEMORY.md`).
3. Stage **only** user-scoped / queue paths → commit (English Conventional Commit; **why**).
4. If remote `origin` exists → `git push` to the **default branch** (or current personal branch if already on one for user-only work).
5. Never force-push.

## agent-knowledge — general / team paths (PR only)

Changes under `knowledge/**`, team `agents/**`, or `WORKSPACE.md` (and product-norm edits to root `AGENTS.md` / `INDEX.md` / `config.yaml`):

1. **Do not** commit+push them onto `main`/`master` from the agent.
2. Create a branch → commit there → `git push -u origin HEAD` → **`gh pr create`**.
3. Do **not** merge the PR unless the user explicitly asks.
4. Return the PR URL in chat.

Chat confirmation alone is not a substitute for a PR on general knowledge.

If the only changes are gitignored → no commit (still OK).
