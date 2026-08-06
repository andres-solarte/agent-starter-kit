# users/

One folder per person. Id = **`git config user.email` lowercase**, as-is (`@` kept).

Example: `dev@example.com` → `users/dev@example.com/`.

`knowledge/` inside the user **mirrors** global with the **same basename** (deltas). Work-log/prefs are local (gitignore).

## Layout

```text
users/<email>/
  IDENTITY.md               # tracked
  DELTAS.md                 # tracked
  knowledge/                # tracked — deltas only, same paths as global
  work-log/                 # LOCAL — YYYY/MM/DD.md
  preferences.yaml          # LOCAL gitignore — communication_language, detail_level, …
  MEMORY.md                 # LOCAL gitignore
```

## Create a user

1. `git config --get user.email`
2. Copy `_template/` → `users/<email>/`
3. Complete `IDENTITY.md`
4. Set `preferences.yaml` → `communication_language` (chat language for this user; default `en`)

Detail: [../knowledge/architecture/agent-knowledge-operating-contract.md](../knowledge/architecture/agent-knowledge-operating-contract.md) · [AGENTS.md](../AGENTS.md)
