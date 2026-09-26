---
name: ask-git-project
description: >-
  Shared Git practices for this project (single repo or sibling multi-repo
  layout). Use whenever committing, branching, opening PRs, staging, or
  amending; every agent role must follow this skill for Git work.
disable-model-invocation: true
---

# Project Git (shared skill)

## Source of truth

1. This skill
2. `agent-knowledge/knowledge/conventions/git.md` (create if missing)

User/workspace commit safety rules still apply (no force-push to main, no amend of others' commits, etc.).

## Shared skill — who loads it

**Every** agent role MUST use this skill for any Git operation. It is part of the **shared pack** (see `ask-agent-skill-discipline`).

## Multi-repo layout (if applicable)

If the project is multi-repo (sibling repos under one workspace), work as follows:

Run `git status` / `git diff` / commits **inside the repo that owns the files**. One logical change may need **one commit per repo**.

## Commits (MUST)

| Rule | Detail |
|------|--------|
| When (app / kit repos) | Only if the user asks |
| When (**agent-knowledge**) | **Automatic** on close-out — see below (project rule) |
| Language | English messages; focus on **why** |
| Shape | Concise; conventional style preferred: `feat(scope): …` / `fix(scope): …` / `docs(…): …` |
| Feature / REQ | Prefer Conventional Commits; optional `Req: REQ-NNN` |
| Secrets | Never stage `.env`, credentials, keys |
| Noise | Exclude accidental build artifacts; respect `.gitignore` |
| Hooks | If pre-commit rejects → fix and **new** commit (do not `--amend` unless user amend rules allow) |

Project detail: `agent-knowledge/knowledge/conventions/git.md` (create if missing).

### Protocol before commit (any repo)

1. `git status` / `git diff` / recent `git log` (style) in that repo
2. Stage only relevant files
3. Commit via HEREDOC message
4. `git status` after

**App / kit repos:** **no push** unless the user explicitly asks. **No** updating git config.

### agent-knowledge auto close-out (MUST)

**Trigger:** finishing a requirement **block/loop**, or completing a durable tracked write in agent-knowledge.

**Split by path (rule `ask-knowledge-pr`):**

| Paths | Action |
|-------|--------|
| User-scoped (`users/<email>/…` tracked), `consolidation/QUEUE.md` | Commit + **push default branch** without waiting for the user |
| `knowledge/**`, team `agents/**`, `WORKSPACE.md` (team SoT) | **Branch + PR only** — never push these to `main`/`master` from the agent |

**User-scoped direct path:**

1. Resolve the **agent-knowledge** directory. Run git **only** there.
2. Complete `ask-agent-knowledge` close-out writes first (work-log, deltas as needed).
3. `git status`. If nothing to commit (only ignored local files) → stop; OK.
4. Stage **user-scoped** tracked paths only. **Never** force-add gitignored paths.
5. Commit (English; why-focused) → `git push` when `origin` exists.
6. Never force-push. Never auto-commit/push sibling app repos or the kit clone under this rule.

**General / team PR path:**

1. Confirm the user wants the team/global change.
2. Create branch → apply `knowledge/**` / team `agents/**` / `WORKSPACE.md` there → commit → `git push -u origin HEAD` → `gh pr create`.
3. Do **not** merge unless the user explicitly asks. Return the PR URL.
4. Chat “yes” alone does **not** authorize pushing global SoT to the default branch.

## Branches

- Short English names `feat/…`, `fix/…`, `chore/…` kebab-case; do not invent parallel branch naming conventions.
- Optional: include REQ id, e.g. `feat/req-003-checkout`.
- Do not force-push to `main`/`master`.

## Pull requests

- **agent-knowledge general/team SoT:** open a PR as part of the write path (rule `ask-knowledge-pr`) — do not wait for a separate “please open a PR” when promoting to `knowledge/**`.
- App/kit: use `gh` when the user asks for a PR.
- Include summary + test plan / review checklist.
- Push with `-u` when opening the PR branch. Do **not** merge agent-knowledge team PRs unless the user asks.

## MUST NOT

- Commit app/kit repos "while at it" without user trigger
- Push or merge **app/kit** without explicit ask
- Push `knowledge/**`, team `agents/**`, or `WORKSPACE.md` to the agent-knowledge **default branch**
- Skip user-scoped agent-knowledge close-out commit/push when there are tracked user changes after a block
- Single commit across multiple sibling repos (split per repo)
- Force-push under auto close-out
- Merge an agent-knowledge team PR without explicit user ask

## Gap / self-improve

If a Git practice needed is not covered here → follow `ask-agent-skill-discipline`: declare `SKILL GAP`, then create/amplify **this** skill (and update `agent-knowledge/knowledge/conventions/git.md` if the norm is project-wide).
