---
name: backlog
description: >-
  Aparcar ideas, bugs o pedidos para después sin interrumpir el trabajo en curso.
  Use when the user says /backlog, "apunta esto", "después", "de paso", or wants to
  save something for later while staying on the current task.
---

# /backlog — aparcar para después (usuario)

Puerta **rápida** para no perder ideas. **No** ejecuta el trabajo. **No** sustituye `/requerimiento` (eso es para hacer algo ahora).

Lista viva: `.cursor/fuera-de-alcance.md`
(Si el proyecto tiene un backlog de producto formal, moverlo ahí solo cuando el usuario confirme promover un ítem.)

## Flujo (MUST)

```text
1. Capturar el texto (idea / bug / "después…")
2. Escribir viñeta en fuera-de-alcance.md
3. Acusar recibo en UNA frase
4. Volver al foco actual (no Q&A largo, no plan, no código de esa idea)
```

## Comandos

| Entrada | Acción |
|---------|--------|
| `/backlog` + texto | Aparcar ese texto |
| `/backlog` sin texto | Preguntar en una frase: «¿Qué apuntamos?» |
| `/backlog list` o «muéstrame el backlog» | Listar solo la sección **Abiertos** (resumen corto; no vaciar) |
| `/backlog done …` / «ya hicimos X» | Mover la viñeta a **Hechos / descartados** si se identifica claro |

Sinónimos que disparan el mismo flujo (aunque no diga `/backlog`): «apunta», «después», «de paso», «para más tarde», «no ahora pero…».

## Formato de viñeta

```markdown
- YYYY-MM-DD — resumen corto en lenguaje claro (contexto opcional si ayuda)
```

- Fecha = hoy (zona del usuario si se conoce).
- Sin códigos internos sueltos en el chat al acusar recibo; en el archivo sí puedes dejar un ID entre paréntesis si ya existía.
- No duplicar: si ya hay viñeta casi igual, no añadas otra; di «Ya estaba apuntado» en una frase.

## Comunicación (MUST)

- **Una frase** al usuario: qué se aparcó.
- Luego **continuar** con la tarea en foco (si hay una).
- No pedir confirmación larga. No ofrecer menú de skills. No empezar a implementar lo aparcado.

Ejemplo: «Aparcado: preferencias de notificaciones. Seguimos con el pedido actual.»

## MUST NOT

- Ejecutar, especificar o planificar a fondo lo aparcado.
- Cambiar de foco al ítem nuevo.
- Meter en un backlog de producto formal sin que el usuario diga que lo quiere como mejora confirmada.
- Vaciar la lista «por limpieza» sin pedirlo.

## Relación con otras piezas

| Pieza | Rol |
|-------|-----|
| Rule `09-foco-alcance` | Misma política; este skill es el procedimiento explícito |
| `/requerimiento` | Cuando quiera **hacer** un ítem del backlog: sacar de la lista y tratarlo como requerimiento |
| `git-proyecto` | No aplica (no hay commit obligatorio al aparcar) |

## Al usuario: cómo usarlo

1. En medio de otra tarea: `/backlog que también pueda…`
2. Cuando quieras atacarlo: `/requerimiento` con ese tema (o «saquemos del backlog lo de …»).
