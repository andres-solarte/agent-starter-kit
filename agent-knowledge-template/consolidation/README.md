# consolidation/

Promote individual deltas → global `knowledge/`.

## Detection (snippet)

```bash
# Tracked deltas (same basename as global)
find users -path '*/knowledge/*' -name '*.md' ! -name 'README.md'

# Group by same_point (= relative path under knowledge/)
# e.g. users/alice@x.com/knowledge/architecture/foo.md
#   → same_point=architecture/foo.md
```

Also: `users/*/DELTAS.md` with `status: open|proposed`.

## Modes

| Mode | Action |
|------|--------|
| **Promote** | 1 mature delta → integrate into `knowledge/<same_point>` |
| **Merge** | N users same `same_point` → one write-up → global |
| **Discard** | `status: discarded` |

Human confirmation MUST before writing `knowledge/**`.

See [QUEUE.md](./QUEUE.md) · contract in `knowledge/architecture/agent-knowledge-operating-contract.md`.
