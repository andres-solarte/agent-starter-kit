# Adopting the kit

How to install this kit in a new or existing project. This repo is a **template you copy**, not a linked dependency.

## What gets installed

| Piece | Destination in the project | Role |
|-------|----------------------------|------|
| `.cursor/rules/` | project root (or workspace) | Agent process rules |
| `.cursor/skills/` | project root | Shared pack (requirement, backlog, git, discipline, …) |
| `agent-knowledge-template/` | copy as `agent-knowledge/` (path adjustable) | Project memory / SoT (**separate** git repo) |

Does not include stack skills (framework, testing, DB) or `speckit-*`; those are added per project.

## Order when also using ai-dev-standard

1. **ai-dev-standard first** — adopt core (and matching profiles) and create the product adoption document. Guide: `ADOPTION.md` in the `ai-dev-standard` repo (sibling in the workspace, or clone from your org).
2. **This kit after** — install rules/skills and `agent-knowledge`; link the standard from the product adoption document or from `agent-knowledge/knowledge/conventions/`.

If you only want the agent protocol, install this kit alone. When you later adopt the standard, you do not need to re-copy the kit: just document adoption and point at the standard version.

## Language configuration

| Layer | Where | Default |
|-------|-------|---------|
| Durable content (knowledge, decisions, specs the agent writes) | `agent-knowledge/config.yaml` → `locale.content` | `en` |
| Paths / identifiers | `locale.paths` | `en` |
| Chat with this user | `users/<email>/preferences.yaml` → `communication_language` | `en` if missing |

Code, commits, and technical names are English by default. Chat language is **per-user**, not a project-wide SoT (rule `08-user-communication`).

## New project

1. **Copy `.cursor/`** to the project root (or use this repo as a GitHub template and delete what does not apply).
2. **Fill placeholders** in `.cursor/rules/00-project.mdc`:
   - `{{PROJECT_NAME}}`, description, sibling repos
   - technical language note (English defaults / `config.yaml`); chat language stays in per-user prefs
3. **Instantiate `agent-knowledge`:**
   - Copy `agent-knowledge-template/` → `agent-knowledge/` (or another path)
   - `cd agent-knowledge && git init` (independent of the app code repo)
   - Adjust `config.yaml` (`repo:`, `locale:`) and `README.md` with the real name
   - Copy `users/_template/` → `users/<your-git-email>/` and complete `IDENTITY.md` + `preferences.yaml` (`communication_language`)
4. **Review paths** if `agent-knowledge` is not at the project root:
   - `.cursor/rules/15-agent-knowledge.mdc`
   - `.cursor/skills/agent-knowledge/SKILL.md`
   - `agent-knowledge/adapters/cursor.md`
5. **Add stack skills** for the project (backend/frontend/testing/local-env) — they are not shipped here.
6. **Spec Kit (optional):** install `github-spec-kit` pointing at `agent-knowledge/` as root if you want `specify` → `plan` → `tasks` → `implement`.
7. **First use:** `/requirement` with the user; other skills are agent-only.
8. **If adopting ai-dev-standard:** create/complete the product adoption document (version, profiles, exceptions) and link it from `agent-knowledge` or `docs/`.

## Existing project

1. **Quick inventory:** Are there already `.cursor/rules` or `.claude`? Is there a team docs/memory folder?
2. **Merge, do not overwrite:**
   - Copy kit rules/skills that **do not** already exist.
   - On a name conflict, keep the project's and adapt kit content (focus, communication, discipline) without deleting own stack rules.
3. **Placeholders** in `00-project.mdc` (or equivalent): name, pointers to real product docs; language via `config.yaml` + per-user `preferences.yaml`.
4. **`agent-knowledge`:**
   - If missing: instantiate the template as in a new project.
   - If docs already live elsewhere: either migrate gradually into `agent-knowledge/knowledge/`, or keep the current SoT and point rules there (thin adapters; do not duplicate protocol).
5. **User entry:** document `/requirement` and `/backlog` for the team; do not ask them to pick internal skills.
6. **Smoke:** a trivial `/requirement` (e.g. clarify a doc) to validate Q&A → plan → focus; park an item with `/backlog` and confirm it lands in `.cursor/out-of-scope.md`.
7. **Standard:** if the project does not yet adopt `ai-dev-standard`, register it when you can (does not block the kit).

## Post-install checklist

- [ ] `.cursor/rules/` and `.cursor/skills/` present; `00-project.mdc` without placeholders
- [ ] `agent-knowledge/` is its own git repo; user created under `users/<email>/` with `preferences.yaml`
- [ ] `config.yaml` uses nested `locale.content` / `locale.paths` (not flat `locale_content` / `locale_paths`)
- [ ] Pointers to `agent-knowledge/AGENTS.md` match the real path
- [ ] `/requirement` and `/backlog` work in Cursor
- [ ] (Optional) `ai-dev-standard` adoption document linked
- [ ] Project stack skills added or listed as gaps

## Maintenance

Improvements made in a consuming project are **copied by hand** back into this kit (without business content). There is no symlink or npm package: each project carries its own copy.

## Quick verification

- [ ] Agent reads `agent-knowledge/AGENTS.md` (not a protocol only in `.cursor/`)
- [ ] Out of scope is parked; not executed "while at it"
- [ ] Commits/PRs only if the user asks (project rule)
- [ ] Chat language follows `users/<email>/preferences.yaml`; durable docs follow `locale.content`
- [ ] If there is a standard: version cited in the product adoption document
