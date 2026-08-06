# work-log/

Personal log: **when / what / why**, small files.

## Layout

```text
work-log/
  INDEX.md           # short index (optional)
  YYYY/
    MM/
      DD.md          # one day = one file (e.g. 2026/07/27.md)
```

| Path | Role |
|------|------|
| [INDEX.md](./INDEX.md) | Summary of recent entries |
| `YYYY/MM/DD.md` | Day log (append-only) |

Template: [../../templates/work-log-day.md](../../templates/work-log-day.md).

## How to write (agents)

1. Day path: `work-log/<year>/<month>/<day>.md` (month and day **two digits**: `07`, `27`).
2. If the file or folders do not exist, create them.
3. Append at the end: title **without time** + **What** + **Why** (+ Where / Next).
4. If notable, update `INDEX.md` (link to `YYYY/MM/DD.md`).

## How to read

1. `INDEX.md`
2. Recent days under the current year/month
3. Search `work-log/` if asked “why…”
