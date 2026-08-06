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
| When | Only if the user asks (or a project rule for automatic close-out applies) |
| Language | English messages; focus on **why** |
| Shape | Concise; conventional style preferred: `feat(scope): …` / `fix(scope): …` / `docs(…): …` |
| Feature / Spec Kit | Prefer Conventional Commits; optional `Spec: knowledge/delivery/specs/NNN-slug` |
| Secrets | Never stage `.env`, credentials, keys |
| Noise | Exclude accidental build artifacts |
| Hooks | If pre-commit rejects → fix and **new** commit (do not `--amend` unless user amend rules allow) |

### Protocol before commit (when asked)

1. `git status` / `git diff` / recent `git log` (style) in that repo
2. Stage only relevant files
3. Commit via HEREDOC message
4. `git status` after

**No push** unless the user explicitly asks. **No** updating git config.

## Branches

- Spec Kit / feature work: prefer `/speckit-git-feature` from `agent-knowledge/` (numbered branches), if the project uses Spec Kit.
- Otherwise: short English names `feat/…`, `fix/…`, `chore/…` kebab-case; do not invent parallel branch naming conventions.
- Do not force-push to `main`/`master`.

## Pull requests

- Use `gh` when the user asks for a PR.
- Include summary + test plan.
- Push with `-u` only if needed and user requested the PR/push path.

## MUST NOT

- Commit "while at it" without user trigger
- Push or merge without explicit ask
- Single commit across multiple sibling repos (split per repo)
- Treat Spec Kit git hooks as general-purpose commit outside Spec Kit flows

## Gap / self-improve

If a Git practice needed is not covered here → follow `ask-agent-skill-discipline`: declare `SKILL GAP`, then create/amplify **this** skill (and update `agent-knowledge/knowledge/conventions/git.md` if the norm is project-wide).
