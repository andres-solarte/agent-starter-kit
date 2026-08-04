---
id: decisions-index
type: guide
status: active
scope: global
tags: [decisions, bdr, adr]
updated: YYYY-MM-DD
---

# Registro de decisiones

Índice central de decisiones de **negocio** (BDR) y **arquitectura** (ADR).

Negocio → [business/](./business/) · Arquitectura → [architecture/](./architecture/)

## Negocio (BDR)

| ID | Estado | Título |
|----|--------|--------|
| — | — | — |

## Arquitectura (ADR)

| ID | Estado | Título |
|----|--------|--------|
| — | — | — |

---

## Plantilla BDR (negocio)

Archivo: `business/BDR-NNNN-titulo-corto.md` (plantilla completa: `templates/decision-business.md`)

```markdown
# BDR NNNN: Título

**Estado:** propuesta | aceptada | deprecada
**Fecha:** YYYY-MM-DD

## Contexto

¿Qué problema de negocio o producto resolvemos?

## Decisión

¿Qué elegimos?

## Consecuencias

Impacto en usuarios, operación, alcance o monetización.

## Alternativas consideradas

| Alternativa | Por qué no |
|-------------|------------|
```

## Plantilla ADR (arquitectura)

Archivo: `architecture/ADR-NNNN-titulo-corto.md` (plantilla completa: `templates/decision-architecture.md`)

```markdown
# ADR NNNN: Título

**Estado:** propuesta | aceptada | deprecada
**Fecha:** YYYY-MM-DD

## Contexto

Restricciones técnicas y requisitos que motivan la decisión.

## Opciones evaluadas

| Opción | Pros | Contras |
|--------|------|---------|

## Decisión

¿Qué elegimos?

## Consecuencias

Impacto en desarrollo, operación, costos y evolución futura.
```

## Convenciones

- Numeración independiente por tipo (BDR y ADR cada uno desde 0001)
- Un archivo por decisión; título claro y fecha
- Enlazar decisiones relacionadas con links relativos Markdown, no wikilinks
- Al aceptar una decisión, actualizar docs afectados (`mvp.md`, `overview.md`, etc.)
- Al adoptar o cambiar tecnología → actualizar `knowledge/architecture/stack-versiones.md` con versión verificada y fecha
