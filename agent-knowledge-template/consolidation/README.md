# consolidation/

Subir deltas individuales → `knowledge/` global.

## Detección (snippet)

```bash
# Deltas tracked (mismo basename que global)
find users -path '*/knowledge/*' -name '*.md' ! -name 'README.md'

# Agrupar por same_point (= path relativo bajo knowledge/)
# Ej.: users/alice@x.com/knowledge/architecture/foo.md
#   → same_point=architecture/foo.md
```

También: `users/*/DELTAS.md` con `status: open|proposed`.

## Modos

| Modo | Acción |
|------|--------|
| **Promote** | 1 delta maduro → integrar en `knowledge/<same_point>` |
| **Merge** | N usuarios mismo `same_point` → una redacción → global |
| **Discard** | `status: discarded` |

Confirmación humana MUST antes de escribir `knowledge/**`.

Ver [QUEUE.md](./QUEUE.md) · contrato en `knowledge/architecture/agent-knowledge-operating-contract.md`.
