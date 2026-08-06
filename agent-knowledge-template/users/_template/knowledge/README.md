# knowledge/ (individual — mirror of global)

This tree **mirrors** repo-root `knowledge/` with the **same relative paths**.

| Global | Individual delta |
|--------|------------------|
| `knowledge/product/foo.md` | `users/<email>/knowledge/product/foo.md` |

## Rules

- Store **deltas only** (additions, overrides, open questions). Never copy the whole global file.
- Same relative path = same knowledge point → enables consolidation across users.
- Frontmatter: use `templates/delta.md` (`delta_of`, `same_point`, `status`).
- Register open deltas in `../DELTAS.md`.
- Cross-user merges: see repo `consolidation/`.

Not a mirror of global: `../work-log/`, `../preferences.yaml`, `../MEMORY.md`.
