# Conversation log (MUST)

**Every conversation leaves a log** so anything can be resumed later — from another conversation, another machine, or months from now — without re-reading transcripts.

## Where

| File | Role |
|------|------|
| `agent-knowledge/users/<email>/conversations/YYYY/MM/YYYY-MM-DD-<slug>.md` | One file per conversation (tracked) |
| `agent-knowledge/users/<email>/conversations/INDEX.md` | One line per conversation, newest first (tracked) |

Format: `users/_template/conversations/README.md`. Tracked and pushed directly (user-scoped; rule `ask-knowledge-pr`), so it follows the user to any machine.

The local `work-log/` keeps the daily *what / why* notes; its entries link to the conversation file instead of repeating it.

## When (MUST)

1. **First substantive turn** (anything beyond a greeting): create the file + INDEX line. A pure framework question still gets a short entry (goal + answer in 1–2 lines).
2. **End of every turn that changed something** (files, decisions, backlog / REQ status, PRs, tools): update the file. Do not wait for the conversation to "end" — the user may just close the window.
3. **Item close / pause / handoff to a new conversation** (rule `ask-one-item-per-conversation`): final update, `status`, resume line; commit + push agent-knowledge (`ask-git-project` auto close-out).
4. **Start of a conversation:** if a previous log has uncommitted changes, commit + push it first.

Keep track of this conversation's file path once created; reuse it (do not create a second file for the same conversation).

## Content

Summaries, not transcripts — ≤ ~40 lines:

- **Goal** — what the user wanted
- **Done** — outcomes, not steps
- **Decisions** — with links to BDR/ADR / docs changed
- **Changes** — repos, commits, PRs, files (paths), tools installed
- **Items** — `BL-NNN` / `REQ-NNN` touched, with status
- **Open threads / next step** + the exact resume line (`/ask-backlog resume BL-NNN`, `/ask-requirement resume REQ-NNN`)

## Resuming (MUST)

When the user wants to resume, asks «what did we do about X?», «where were we?», or references past work:

1. Search `conversations/INDEX.md` (title, items, tags), then open the matching file(s).
2. Follow links to the item (`BL` / `REQ` **Resume** notes) and changed docs.
3. Summarize in 2–4 sentences where it stopped and the next step; then continue (one item per conversation).

Order of sources: conversation log → item Resume note → work-log → docs. Do not re-read raw transcripts unless the log is missing.

## MUST NOT

- Paste secrets, tokens, credentials, or personal data of third parties into the log.
- Copy whole transcripts, long code, or command output (link paths / commits instead).
- Skip the log because the conversation was short.
- Let the log contradict the item / REQ — they must agree on status and next step.

## Related

Rule `ask-one-item-per-conversation` · skill `ask-backlog` · `agent-knowledge/AGENTS.md` (close-out) · skill `ask-git-project`.
