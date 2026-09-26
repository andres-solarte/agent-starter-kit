# Route user messages via ask-question

After this kit is installed (or updated), **every user turn that is a question or a work request** must be handled through the **`ask-question`** skill first, even if the user did not type `/ask-question` or `/ask-requirement`.

## MUST

1. Read and follow `.agents/skills/ask-question/SKILL.md` (host adapters symlink here).
2. Let **`ask-question` triage**:
   - Framework / how / where / kit wiring → answer there.
   - Error / failure / regression on existing or recent REQ work → **hand off to `ask-requirement-fix`**.
   - New product work (feature, new bug without REQ link, change or document the product) → **hand off to `ask-requirement`**.
   - Park-for-later side idea → **`ask-backlog`**.
3. On hand off: the **first** lines of the user-visible reply MUST announce the triage in the user’s chat language (see `ask-question` → Visible handoff). Silent handoff is forbidden.
4. If the user already invoked `/ask-requirement`, `/ask-requirement-fix`, or `/ask-backlog` explicitly, honor that slash (still OK to peek at ask-question router if unsure).
5. If the user invoked `/ask-install`, `/ask-update`, `/ask-uninstall`, `/ask-centralize-docs`, or `/ask-setup-agents`, run those skills directly (not ask-question).

## Why

Users forget slash commands. Triage must stay in the loop, and the user must **see** when a message became a requirement vs a fix-on-same-REQ (different gates).

## Source

Skill: `ask-question`. Related: `ask-requirement`, `ask-requirement-fix`, `ask-backlog`, rule `ask-agent-skill-discipline`.
