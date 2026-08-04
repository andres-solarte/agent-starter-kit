---
name: requerimiento
description: >-
  Única entrada de usuario para pedir trabajo: describe el requerimiento,
  aclara dudas en Q&A, luego el orquestador reparte e implementa. Use when the
  user says /requerimiento, wants a feature or fix, or starts with a product
  request.
---

# /requerimiento — entrada única (usuario)

Tú hablas **solo** con este skill. El resto de skills (Spec Kit, skills de rol, `orquestar-requerimiento`, etc.) son **para agentes**: el orquestador los lee e invoca; tú no tienes que elegirlos.

## Flujo (MUST)

```text
1. Capturar requerimiento
2. Q&A (aclarar vacíos)  ← no código todavía
3. Confirmar resumen + criterios de aceptación
4. Plan de ejecución del bloque  ← NUEVO GATE (obligatorio)
5. Ejecutar en modo loop hasta resolver el bloque por completo
6. Entregar / cerrar (o pasar al siguiente bloque con un plan nuevo)
```

Si el trabajo está partido en **varios bloques**: **cada bloque** repite pasos 4→5→6. No encadenar el siguiente bloque sin plan aceptado.

## Paso 1 — Captura

Tomar el texto del usuario (`$ARGUMENTS` o el mensaje). Si está vacío, preguntar en una frase: «¿Qué necesitas?»

No inventar alcance. Aplicar foco (rule `09`): aparcar "de paso…" con skill **`backlog`** (`.cursor/skills/backlog/SKILL.md`).

## Paso 2 — Q&A (sesión de aclaración)

**Antes de escribir código o tocar repos**, reducir ambigüedad.

### Reglas

- Máximo **5** preguntas de alto valor (bloqueantes).
- Preferir **una pregunta por turno** (o un bloque corto de 2–3 si son independientes).
- Lenguaje claro; sin jerga interna salvo que el usuario ya la use.
- Si ya está claro (fix obvio, micro tipográfico), decir «No tengo bloqueantes» y pasar al paso 3 con 0 preguntas.
- Si hace falta una decisión de negocio/arquitectura / choca con el alcance acordado → decirlo; no implementar hasta OK o decisión documentada.

### Qué preguntar (priorizar bloqueantes)

1. Resultado observable / criterio de "listo"
2. Superficie (qué repo/app/módulo)
3. Alcance OUT (qué no hacer)
4. Datos o migraciones ¿sí/no?
5. Riesgo (auth, pagos, PII)
6. ¿Hay spec o ticket ya abierto?

No preguntar detalles de implementación (librería, nombres de archivos) salvo que cambien el contrato.

### Formato de pregunta

Breve contexto (1 línea) + pregunta + opciones si ayuda (A/B/C) + "u otra cosa".

## Paso 3 — Confirmar alcance del requerimiento / bloque

Cuando no queden bloqueantes, mostrar:

```text
Resumen:
- Qué: …
- Listo cuando: …
- Superficies/repos: …
- Fuera de alcance: …
```

Pedir confirmación: «¿Seguimos al plan de ejecución?»
(Si el usuario ya dijo «hazlo / adelante» sobre el resumen, igual hay que pasar por el **paso 4** — el plan de agentes — salvo micro trivial acordado.)

## Paso 4 — Plan de ejecución (GATE — MUST)

**Antes de escribir código**, presentar un plan en lenguaje simple. El usuario debe **aceptarlo** («sí / ok / adelante con el plan»).

### Validación con subagentes (MUST — antes de pedir aceptación)

Antes de mostrar el plan al usuario para el «sí»:

1. Identificar los **roles que el plan va a involucrar**.
2. **Consultar a cada uno** (subagente / skill de rol) con el borrador del plan y el contexto del requerimiento.
3. Cada rol revisa con **su propio criterio** (datos: migración/backfill; backend: contratos/auth; frontend: superficies/i18n; QA: cómo verificar; producto: alcance IN/OUT).
4. El **Tech Lead** recibe el feedback, **cruza** hallazgos y **resuelve incoherencias** (re-consultando a los roles afectados si hace falta).
5. **Loop** de ese patrón (consultar → integrar → re-validar lo conflictivo) hasta que el plan sea **coherente de punta a punta**.
6. Solo entonces presentar el plan **ya ajustado** y pedir aceptación.

**Cuándo preguntar al usuario (en esta fase):** únicamente si aparece algo **no contemplado** en el requerimiento (decisión de negocio, alcance nuevo, trade-off que el producto no resolvió). No elevar al usuario contradicciones técnicas entre roles que el Tech Lead pueda cerrar con ellos.

No basta con listar roles en el texto del plan sin haberlos consultado. Si un rol no aplica al bloque, omitirlo y decirlo en una frase.

Excepción estrecha (micro tipográfico / un string): no hace falta ronda de subagentes; nombrar quién toca qué en una frase.

### Contenido mínimo del plan

1. **Qué vamos a hacer en este bloque** (resultado observable).
2. **Cómo** (pasos cortos, sin jerga).
3. **Quién participa** (roles/agentes): nombre en claro + qué hace cada uno — **ya validados** en el loop anterior.
4. **Orden** (secuencia; qué va en paralelo si aplica).
5. **Cómo sabemos que terminó** (criterio de "bloque resuelto").
6. **Qué no entra** en este bloque.
7. **Si hay cambio de datos/BD:** cómo migran los **datos que ya existen** (NULL/default/backfill). Tratar datos actuales como producción.
8. **Hallazgos del loop** (opcional, breve): 1–3 bullets de lo que aportaron los roles si cambió el plan.

Formato sugerido al usuario:

```text
Plan del bloque:
- Objetivo: …
- Pasos: 1) … 2) … 3) …
- Quién (validado):
  - … → …
  - … → …
- Orden: …
- Listo cuando: …
- No entra: …
¿Aceptas el plan?
```

**Prohibido:** empezar implementación, migraciones o Spec Kit `implement` sin ese «sí» al plan.
**Prohibido:** pedir aceptación del plan sin haber pasado por la validación con subagentes (salvo excepción micro).

## Paso 5 — Ejecutar en loop hasta resolver

Tras aceptar el plan, seguir `.cursor/skills/orquestar-requerimiento/SKILL.md` en **modo loop**:

1. Ejecutar el siguiente paso del plan (delegar al rol que toque).
2. Verificar ese paso.
3. Si falla o queda incompleto → corregir y repetir (mismo bloque).
4. No declarar el bloque cerrado hasta cumplir el criterio «Listo cuando».
5. No saltar al **siguiente bloque** del roadmap sin un **plan nuevo** (volver al paso 4).

Heartbeat `/loop` de Cursor es opcional (re-chequear cola/drift); el "loop" de aquí es **ciclo ejecutar → verificar → corregir** hasta cerrar el requerimiento/bloque.

## Paso 6 — Cierre (al usuario)

2–4 frases: qué se hizo, qué quedó, un siguiente paso. Sin códigos internos sueltos.

Si hay más bloques pre-acordados: «Bloque N listo. Siguiente: bloque N+1 — ¿preparo el plan?»

## MUST NOT (hacia el usuario)

- Pedirle que ejecute skills internos (`/speckit-*`, `/orquestar-*`, etc.).
- Mostrar menú de skills internos.
- Empezar código en el paso 2 o **sin plan aceptado** (paso 4).
- Saltar Q&A cuando haya bloqueantes reales.
- Dar por cerrado un bloque a medias.

## Referencias internas (agentes)

- Orquestación: `orquestar-requerimiento`
- Disciplina: `agent-skill-discipline` + rule `12`
- Git: `git-proyecto`
- Roles / RACI / loop: doc propia del proyecto en `agent-knowledge/knowledge/architecture/agentes/` (crear si no existe)
