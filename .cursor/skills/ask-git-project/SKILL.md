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
3. Spec Kit hooks (`.cursor/skills/speckit-git-*`) — only inside Spec Kit flows, if the project uses them

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
| Feature / Spec Kit | Prefer Conventional Commits; optional `Spec: knowledge/delivery/specs/NNN-slug` |
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

**Trigger:** finishing a requirement **block/loop**, or completing a durable tracked write in agent-knowledge (deltas, `session-backlog.md`, roles, agreed global knowledge, install/setup memory fills).

**Do this without waiting for the user to ask** (exception to app-repo policy):

1. Resolve the **agent-knowledge directory** (install record / workspace). Run git **only** there.
2. Complete `ask-agent-knowledge` close-out writes first (work-log, deltas as needed).
3. `git status`. If nothing to commit (only ignored local files) → stop; OK.
4. Stage relevant tracked paths. **Never** force-add gitignored paths (`work-log/`, `preferences.yaml`, `MEMORY.md`, secrets).
5. Commit (English; why-focused).
6. **Push:** if remote `origin` exists → `git push` (use `-u origin HEAD` when upstream is missing). If **no** remote → leave commit local and tell the user once that push needs a remote.
7. Never force-push. Never auto-commit/push sibling app repos or the kit clone under this rule.

## Branches

- Spec Kit / feature work: prefer `/speckit-git-feature` from `agent-knowledge/` (numbered branches), if the project uses Spec Kit.
- Otherwise: short English names `feat/…`, `fix/…`, `chore/…` kebab-case; do not invent parallel branch naming conventions.
- Do not force-push to `main`/`master`.

## Pull requests

- Use `gh` when the user asks for a PR (app/kit).
- Include summary + test plan.
- Push with `-u` only if needed and user requested the PR/push path (app/kit). agent-knowledge close-out push does not open a PR by itself.

## MUST NOT

- Commit app/kit repos "while at it" without user trigger
- Push or merge **app/kit** without explicit ask
- Skip agent-knowledge close-out commit/push when there are tracked changes after a block
- Single commit across multiple sibling repos (split per repo)
- Treat Spec Kit git hooks as general-purpose commit outside Spec Kit flows
- Force-push under auto close-out

## Gap / self-improve

If a Git practice needed is not covered here → follow `ask-agent-skill-discipline`: declare `SKILL GAP`, then create/amplify **this** skill (and update `agent-knowledge/knowledge/conventions/git.md` if the norm is project-wide).
