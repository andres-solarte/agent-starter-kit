# work-log/

Log personal: **cuándo / qué / por qué**, archivos chicos.

## Layout

```text
work-log/
  INDEX.md           # índice corto (opcional)
  YYYY/
    MM/
      DD.md          # un día = un archivo (ej. 2026/07/27.md)
```

| Path | Rol |
|------|-----|
| [INDEX.md](./INDEX.md) | Resumen de entradas recientes |
| `YYYY/MM/DD.md` | Log del día (append-only) |

Plantilla: [../../templates/work-log-day.md](../../templates/work-log-day.md).

## Cómo escribir (agentes)

1. Path del día: `work-log/<year>/<month>/<day>.md` (mes y día con **dos dígitos**: `07`, `27`).
2. Si no existe el archivo o carpetas, crearlos.
3. Append al final: título **sin hora** + **Qué** + **Por qué** (+ Dónde / Sigue).
4. Si es notable, actualizar `INDEX.md` (enlace a `YYYY/MM/DD.md`).

## Cómo leer

1. `INDEX.md`
2. Últimos días bajo el año/mes actuales
3. Buscar en `work-log/` si preguntan “por qué…”
