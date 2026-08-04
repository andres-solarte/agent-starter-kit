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

# Delta — título corto

## Relación con el global

- Global: `knowledge/<same_point>` (existe / no existe)
- Tipo: `add` | `override` | `question` | `correction`

## Contenido del delta

Solo la diferencia. **Mismo basename** que el archivo global (`users/<email>/knowledge/<same_point>`).

## Por qué

Enlazar `work-log/` si aplica.

## Candidato a consolidación

- [ ] Promote (1 → global)
- [ ] Merge (N usuarios, mismo `same_point`) → `consolidation/QUEUE.md`
