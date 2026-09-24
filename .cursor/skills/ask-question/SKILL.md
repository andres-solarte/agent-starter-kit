---
name: ask-question
description: >-
  Default entry for user questions and unclear intents: triage framework
  how/where questions vs product work. Answers kit/agent-knowledge questions
  (e.g. where is my work-log); hands off to ask-requirement-fix for errors on
  an existing REQ, or ask-requirement for new product work. Use for /ask-question,
  "where is…", "how do I…", or any user message that is not already an explicit
  /ask-install|/ask-update|/ask-uninstall|/ask-centralize-docs|/ask-setup-agents|
  /ask-requirement|/ask-requirement-fix|/ask-backlog (route rule).
---

# /ask-question — ask the framework + triage (user)

Default router for user messages (see rule `ask-route-via-ask-question`).  
Also used explicitly as `/ask-question …`.

Answer framework questions in the user’s chat language (`preferences.yaml` → `communication_language`, default `en`). Be concrete: **real paths** when known.

## Flow (MUST)

```text
1. Capture message ($ARGUMENTS or user turn)
2. Triage (below) → answer | ask-requirement-fix | ask-requirement | ask-backlog | one clarifier
3. If framework: resolve paths + answer (2–6 short sentences)
4. If product work / fix: continue with the handed-off skill (do not improvise here)
```

## Triage (MUST)

| Signal | Action |
|--------|--------|
| How/where about kit, agent-knowledge, work-log, prefs, slashes, install/update | **Answer here** |
| Error / failure / regression / stacktrace / “no funciona” / “rompió…” / failing test **on recent or named work** | **Hand off → `ask-requirement-fix`** — see **Visible handoff — fix** below |
| New feature, new bug with no REQ link, refactor, product doc/spec change, “build/change/add/document…” | **Hand off → `ask-requirement`** — see **Visible handoff — requirement** below |
| Side idea / later / while-at-it without “do it now” | **Hand off → `ask-backlog`** — one clear line that it was parked |
| Explicit `/ask-requirement-fix` | That skill |
| Explicit `/ask-requirement` or `/ask-backlog` | Honor that skill |
| Explicit `/ask-install` / `/ask-update` / `/ask-uninstall` / `/ask-centralize-docs` / `/ask-setup-agents` | Those skills (not this one) |
| Ambiguous (new work vs fix on existing REQ) | One clarifying question |

**Prefer fix over new requirement** when an `in_progress` REQ exists (INDEX/NEXT) and the message clearly reports a failure. If unsure whether it is new scope vs a defect on current work → ask once.

### Visible handoff — fix (MUST)

Before following `ask-requirement-fix`, the **first** user-visible lines MUST say, in the user’s chat language:

1. This is a **fix on the same requirement** (not a new requirement).
2. You will **not** re-run full Q&A/plan — focus on the error.

Example shape:

```text
I'm treating this as a fix on the same requirement — not a new one.
I'll focus on the error; I won't re-run the full requirement plan.
```

Then read and execute `.cursor/skills/ask-requirement-fix/SKILL.md`.

### Visible handoff — requirement (MUST)

Before following `ask-requirement`, the **first** user-visible lines MUST say, in the user’s chat language:

1. This is being treated as a **product requirement** (not a framework FAQ).
2. Next come **clarifying questions and an agreed plan** — no implementing/documenting yet until those gates pass.

Example shape:

```text
I'm taking this as a product requirement.
Next I'll clarify scope and get a short plan accepted — I won't start documenting/coding until then.
```

**Hand off means:** after that announcement, read and execute the target skill — including its gates. Do not skip gates. Do **not** bury the announcement after a long FAQ.

## Resolve context (framework answers)

1. **User id:** `git config user.email` → lowercase as-is (keep `@`).
2. **Paths:** install record (`ask-project.mdc`, `ask-kit-paths.mdc`) → workspace kit/agent-knowledge folders → **ask** if ambiguous.
3. Read only what you need: `AGENTS.md`, `config.yaml`, `preferences.yaml`, kit `INSTALL.md`.

## Question router (common)

| User asks about… | Answer from |
|------------------|-------------|
| Work-log | `<agent-knowledge>/users/<email>/work-log/YYYY/MM/DD.md` |
| Preferences / chat language | `users/<email>/preferences.yaml` |
| Identity / user folder | `users/<email>/` + `IDENTITY.md` |
| Global knowledge | `knowledge/…` |
| Personal deltas | `users/<email>/knowledge/…` + `DELTAS.md` |
| Kit / `.cursor/` paths | Install record; `/ask-update` for upgrades |
| Install / update / uninstall / centralize docs / setup agents | `INSTALL.md` + matching `/ask-*` |
| Agent roles / RACI / subagents | `knowledge/architecture/agents/roles.md` · `.cursor/agents/ask-*.md` · `/ask-setup-agents` |
| Imported / centralized docs map | `knowledge/imported/IMPORT-MAP.md` |
| Which slash for work vs park vs fix | `/ask-requirement` · `/ask-backlog` · `/ask-requirement-fix` |
| Requirement status / REQ id | `knowledge/delivery/requirements/INDEX.md` + `REQ-NNN-*.md` |
| Session backlog (personal) | `<agent-knowledge>/users/<email>/session-backlog.md` |
| Doc locale | `config.yaml` → `locale.content` |

## Style (MUST)

- Rule `ask-user-communication`.
- Framework answers: no product implementation in this skill.
- After hand off: the target skill owns the rest of the turn/flow.

## MUST NOT

- Invent install paths.
- Implement product work while claiming it is “just a question”.
- Route a clear **error-on-existing-REQ** through full `ask-requirement` plan gates.
- Skip `ask-requirement` plan gates after triage says **new** product work.
- Hand off **silently** (no visible announcement).
- Expose secrets from env files.

## Close

Framework: answer (+ optional one related path/slash).  
Handoff: announcement first → then the target skill owns the rest.
