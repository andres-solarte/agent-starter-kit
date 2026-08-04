# INDEX — agent-knowledge

Empezá por [AGENTS.md](./AGENTS.md) y el [contrato operativo](./knowledge/architecture/agent-knowledge-operating-contract.md).
Adapters: [adapters/](./adapters/). Config: [config.yaml](./config.yaml).
Wikilinks: [knowledge/WIKILINKS.md](./knowledge/WIKILINKS.md).

## Mapa

| Área | Path |
|------|------|
| Producto | [knowledge/product/](./knowledge/product/) |
| Decisiones | [knowledge/decisions/](./knowledge/decisions/) |
| Dominio | [knowledge/domain/](./knowledge/domain/) |
| Diseño | [knowledge/design/](./knowledge/design/) |
| Arquitectura | [knowledge/architecture/](./knowledge/architecture/) |
| Convenciones | [knowledge/conventions/](./knowledge/conventions/) |
| Specs | [knowledge/delivery/specs/](./knowledge/delivery/specs/) |
| Specify | [knowledge/delivery/specify/](./knowledge/delivery/specify/) |
| Proceso | [knowledge/delivery/PROCESS.md](./knowledge/delivery/PROCESS.md) |
| Qué sigue | [knowledge/delivery/NEXT.md](./knowledge/delivery/NEXT.md) |
| Archivo | [knowledge/archive/](./knowledge/archive/) |

## Capas

| Capa | Path | Uso |
|------|------|-----|
| Global | [knowledge/](./knowledge/) | SoT compartido |
| Delta individual | `users/<email>/knowledge/<mismo-relpath>/<mismo-archivo>.md` | Basename idéntico; solo diferencia |
| Índices | `DELTAS.md`, [consolidation/](./consolidation/) | Detectar y promote/merge |
| Work log | `users/<email>/work-log/` | Local (gitignore) |

Identidad: email literal (`users/<email>/`). Ver [users/README.md](./users/README.md).

## Fuera de este repo

- Código de la aplicación (apps, servicios, librerías)
- `.cursor/` / `.claude/` — adapters thin (rules/skills apuntan aquí)

## Cómo mantener

1. Deltas: mismo basename que el global.
2. Close-out vía skill `agent-knowledge`.
3. Consolidar solo con confirmación.
4. Wikilinks: normalizar al tocar ([WIKILINKS.md](./knowledge/WIKILINKS.md)).
