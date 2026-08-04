---
name: agent-skill-discipline
description: >-
  Mandatory discipline for all project agents: every action must follow an
  existing project skill; shared skills (git, etc.) apply to every role; on
  gaps the agent must stop, declare the gap, and create or improve the skill
  instead of improvising. Use always.
disable-model-invocation: true
---

# Disciplina de skills (todos los agentes)

## Principio rector

1. **Todo acto con procedimiento** pertenece a un **skill existente** (`.cursor/skills/`) o a una **rule/doc** que un skill cita como fuente.
2. **Prohibido improvisar** flujos o convenciones no ancladas.
3. **Mejora = crear/ampliar skills** (y docs que citan), no magia de un solo chat.
4. Si el agente **no sabe** o **no hay skill**: **decirlo** (`GAP DE SKILL`) y **añadir/ampliar el skill** (con OK del usuario si el default es parar).
5. Hay un **pack de skills compartidos** que **todos** los roles cargan; el resto son skills de rol.

## Skills compartidos (pack — todos los agentes)

| Skill | Obligatorio cuando | Fuente / notas |
|-------|-------------------|----------------|
| `agent-skill-discipline` | Siempre | Este skill |
| `git-proyecto` | Cualquier commit, rama, PR, stage, amend | `agent-knowledge/knowledge/conventions/git.md` (crear si no existe) |
| `agent-knowledge` | Cierre de bloque / recall de porqués | Pointer → `agent-knowledge/AGENTS.md` |

Al delegar o actuar, el orquestador MUST recordar el pack compartido **más** el skill de rol.

Si falta un skill del pack (o se descubre una práctica común no listada):

1. `GAP DE SKILL` — pack compartido.
2. Crear/ampliar el skill compartido en `.cursor/skills/`.
3. Actualizar la doc de roles del proyecto (si existe, ej. `agent-knowledge/knowledge/architecture/agentes/roles.md`) § Skills compartidos.
4. Actualizar esta sección del skill.

## Antes de actuar

| Pregunta | Si la respuesta es no |
|----------|----------------------|
| ¿Es Git? → ¿cargué `git-proyecto`? | Cargar o GAP + crear |
| ¿Qué skill de rol cubre esto? | Declarar gap |
| ¿Ya leí el skill + fuentes? | Leer primero |
| ¿Estoy inventando un paso? | Parar; ampliar skill |

Skills de rol típicos (ejemplo — depende del stack del proyecto): skills de framework backend/frontend, testing E2E, migraciones de base de datos, Spec Kit (`speckit-*`). Bases externas no anulan normas del monorepo.

## Protocolo de gap (MUST — visible al usuario)

```text
GAP DE SKILL — me estoy mejorando (no improvisaré)
- Qué necesitaba hacer: …
- Pack: compartido | rol
- Qué busqué / leí: …
- Qué falta: skill inexistente | skill incompleto | doc sin skill
- Propuesta: crear/ampliar skill `nombre` con estos MUST: …
- Mientras tanto: (a) crear/ampliar skill ahora  (b) aparcar  (c) excepción explícita
```

- **Default:** no continuar esa parte.
- **(a):** crear/ampliar `SKILL.md` (+ doc del proyecto si es norma) **antes o junto** al trabajo.
- **(c):** anotar en `.cursor/fuera-de-alcance.md`.

Para gaps del **pack compartido**, preferir (a): el skill debe existir para todos los agentes.

## Automejora válida vs inválida

| Válida | Inválida |
|--------|----------|
| Crear `git-proyecto` / ampliar pack | Commit "a mi estilo" sin skill |
| Ampliar skill de rol + citar la fuente del proyecto | Improvisar convenciones no ancladas |
| Decir gap a tiempo | Callar y seguir |
| `npx skills find` solo como base | Skill externo pisa ADR/constitution |

## Orquestador

`orquestar-requerimiento` MUST:

1. Asumir pack compartido en cada subtarea.
2. Asignar **al menos un skill de rol** (o Spec Kit) por subtarea.
3. Si no puede mapear → gap **antes** de delegar.

## Cierre de turno (gap o mejora)

Qué skills se usaron (compartidos + rol), si se creó/amplió alguno, qué gap quedó abierto.
