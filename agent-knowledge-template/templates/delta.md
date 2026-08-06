---
id: delta-slug
type: delta
status: open
scope: personal
# Path under knowledge/ this extends/overrides. null if net-new.
delta_of: knowledge/area/file.md
# MUST equal relative path under knowledge/ (no "knowledge/" prefix).
same_point: area/file.md
tags: []
updated: YYYY-MM-DD
---

# Delta — short title

## Relation to global

- Global: `knowledge/<same_point>` (exists / does not exist)
- Type: `add` | `override` | `question` | `correction`

## Delta content

Diff only. **Same basename** as the global file (`users/<email>/knowledge/<same_point>`).

## Why

Link `work-log/` if applicable.

## Consolidation candidate

- [ ] Promote (1 → global)
- [ ] Merge (N users, same `same_point`) → `consolidation/QUEUE.md`
