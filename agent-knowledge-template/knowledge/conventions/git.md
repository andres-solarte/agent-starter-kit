# Git conventions (project)

Norms for Git in this product workspace. Cursor shared skill: `ask-git-project`.

## Repos

| Repo | Commit / push |
|------|----------------|
| **agent-knowledge** | **Automatic** on block/loop close-out and durable memory writes (see below) |
| App / product code repos | Only when the user asks |
| Kit clone (`agent-starter-kit`) | Only when the user asks |

## agent-knowledge auto close-out (MUST)

After a meaningful block/loop close, or after durable tracked writes (deltas, `session-backlog.md`, requirement registry, roles, agreed `knowledge/**`):

1. Work in the **agent-knowledge** directory only.
2. Respect `.gitignore` (do not force-add `work-log/`, `preferences.yaml`, `MEMORY.md`).
3. If there are staged/unstaged **tracked-relevant** changes → commit (English Conventional Commit style; focus on **why**).
4. If remote `origin` exists → `git push` (set upstream if needed). If no remote → leave commit local and tell the user once.
5. Never force-push. Never rewrite unrelated history.

If the only changes are gitignored → no commit (still OK).
