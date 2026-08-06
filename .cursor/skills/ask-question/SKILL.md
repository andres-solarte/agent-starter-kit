---
name: ask-question
description: >-
  Default entry for user questions and unclear intents: triage framework
  how/where questions vs product work. Answers kit/agent-knowledge questions
  (e.g. where is my work-log); hands off to ask-requirement when the user wants
  product changes. Use for /ask-question, "where is…", "how do I…", or any
  user message that is not already an explicit /ask-install|/ask-update|
  /ask-uninstall|/ask-requirement|/ask-backlog (rule 16).
---

# /ask-question — ask the framework + triage (user)

Default router for user messages (see rule `16-route-via-ask-question`).  
Also used explicitly as `/ask-question …`.

Answer framework questions in the user’s chat language (`preferences.yaml` → `communication_language`, default `en`). Be concrete: **real paths** when known.

## Flow (MUST)

```text
1. Capture message ($ARGUMENTS or user turn)
2. Triage (below) → answer | hand off ask-requirement | hand off ask-backlog | ask one clarifier
3. If framework: resolve paths + answer (2–6 short sentences)
4. If product work: continue with ask-requirement (do not improvise a mini-implement here)
```

## Triage (MUST)

| Signal | Action |
|--------|--------|
| How/where about kit, agent-knowledge, work-log, prefs, slashes, install/update | **Answer here** |
| Wants a feature, bugfix, refactor, product doc/spec change, “build/change/add…” on the product | **Hand off → `ask-requirement`** (follow that skill from step 1; one short line: “Treating this as a product requirement.”) |
| Side idea / later / while-at-it without “do it now” | **Hand off → `ask-backlog`** |
| Explicit `/ask-requirement` or `/ask-backlog` | Honor that skill |
| Explicit `/ask-install` / `/ask-update` / `/ask-uninstall` | Those skills (not this one) |
| Ambiguous | One clarifying question: framework fact vs product work? |

**Hand off means:** read and execute `.cursor/skills/ask-requirement/SKILL.md` (or backlog) — including its Q&A and plan gates. Do not skip gates.

## Resolve context (framework answers)

1. **User id:** `git config user.email` → lowercase as-is (keep `@`).
2. **Paths:** install record (`00-project.mdc`, `ask-kit-paths.mdc`) → workspace kit/agent-knowledge folders → **ask** if ambiguous.
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
| Install / update / uninstall | `INSTALL.md` + matching `/ask-*` |
| Which slash for work vs park | `/ask-requirement` vs `/ask-backlog` |
| Out of scope list | `.cursor/out-of-scope.md` |
| Doc locale | `config.yaml` → `locale.content` |

## Style (MUST)

- Rule `08-user-communication`.
- Framework answers: no product implementation in this skill.
- After hand off to requirement: the requirement skill owns the rest of the turn/flow.

## MUST NOT

- Invent install paths.
- Implement product work while claiming it is “just a question”.
- Skip `ask-requirement` plan gates after triage says product work.
- Expose secrets from env files.

## Close

Framework: answer (+ optional one related path/slash).  
Handoff: continue under the target skill; no duplicate long answer here.
