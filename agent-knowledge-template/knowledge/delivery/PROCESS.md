---
id: delivery-process
type: guide
status: active
scope: delivery
tags: [delivery, process, spec-kit, loop-engineering]
updated: YYYY-MM-DD
---

# PROCESS — entrega (proceso propio)

Fuente viva del **cómo** entregamos. Si el proyecto documenta esta decisión como ADR, enlazarlo aquí.
Qué retomar: [NEXT.md](./NEXT.md).

## Entrada

| Quién | Qué |
|-------|-----|
| Humano | `/requerimiento` (trabajo ahora) · `/backlog` (aparcado) |
| Agentes | `orquestar-requerimiento` + skills de rol (agent-only) |

No ofrecer menú de skills Spec Kit al usuario.

## Paths (SoT)

| Qué | Path |
|-----|------|
| Specs (globales) | `knowledge/delivery/specs/NNN-slug/` |
| Plantillas + constitution | `knowledge/delivery/specify/` |
| Runtime markers (symlinks, si se usa Spec Kit) | `agent-knowledge/.specify` → `knowledge/delivery/specify` · `agent-knowledge/specs` → `knowledge/delivery/specs` |
| Qué sigue | `knowledge/delivery/NEXT.md` |

## Tiers

| Tier | Cuándo | Camino |
|------|--------|--------|
| **micro** | Criterios del orquestador (pocos repos, sin alcance/API/tabla nueva, sin auth/pagos, …) | Roles + verify light — **sin** Spec Kit |
| **normal** | Default features | Núcleo Spec Kit (abajo) |
| **ambiguous** | Falta producto / BDR | Product / clarify — **sin código** hasta resolver |

## Núcleo Spec Kit (tier normal, si el proyecto lo instaló)

Orden:

1. `speckit-git-feature` (si aplica rama)
2. `speckit-specify`
3. `speckit-clarify` (solo si el spec está ambiguo)
4. `speckit-plan`
5. `speckit-tasks`
6. `speckit-analyze` (gate)
7. `speckit-implement`

Scripts bash (si se usan): ejecutar desde `agent-knowledge/` (encuentra `.specify`).

## Loop engineering (resumen)

1. Plan de ejecución del bloque + validación con roles → usuario acepta.
2. Ejecutar según tier.
3. Verify bar: maker ≠ checker (analyze / E2E / smoke según tier).
4. Cerrar: work-log; actualizar `NEXT.md` si cambió el foco; commits solo si se piden / reglas de proyecto.

Detalle de roles: doc propia del proyecto en `knowledge/architecture/agentes/roles.md` (crear si no existe).
