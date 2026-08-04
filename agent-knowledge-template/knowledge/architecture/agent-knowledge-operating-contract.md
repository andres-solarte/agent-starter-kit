---
id: agent-knowledge-operating-contract
type: guide
status: active
scope: architecture
tags: [agent-knowledge, deltas, consolidation]
updated: 2026-07-27
---

# Operating contract — agent-knowledge

Normas operativas del repo `agent-knowledge`. Fuente corta para agentes; detalle de ruteo en `AGENTS.md`.

## 1. Identidad de usuario

- Carpeta: `users/<email>/` — **el email literal** en minúsculas (se conserva `@`)
- Fuente: `git config user.email` (no `user.name`)
- Ejemplo: `devsolarte@gmail.com` → `users/devsolarte@gmail.com/`
- No reemplazar `@` por `_at_` (legibilidad > escape innecesario en macOS/Linux)
- Archivo `users/<email>/IDENTITY.md` MUST existir y listar el email canónico
- Si el email es `*.local` / vacío: avisar al humano; no inventar otro id a mitad de sesión
- Prefer the same email as the GitHub account used for this org's remotes

## 2. Convención de archivo delta (basename idéntico)

| Global | Delta individual |
|--------|------------------|
| `knowledge/<relpath>/<file>.md` | `users/<email>/knowledge/<relpath>/<file>.md` |

- **Mismo basename y misma ruta relativa.** Eso es el `same_point`.
- Un solo archivo delta por usuario por punto (se edita; no `foo.delta.md` ni `foo-andres.md`).
- Contenido = **solo la diferencia** (add / override / question / correction), no copia del global.
- Frontmatter MUST: `type: delta`, `status`, `delta_of`, `same_point` (relpath sin prefijo `knowledge/`, p.ej. `architecture/foo.md`).
- Net-new: crear el path que **será** el global; `delta_of: null` hasta el promote.
- Registrar en `users/<email>/DELTAS.md`.

## 3. Árbol de decisión (dónde escribir)

```text
¿Es preferencia personal / scratch?     → users/<email>/preferences.md | MEMORY.md
¿Cuándo/qué/por qué de este bloque?    → users/<email>/work-log/YYYY/MM/DD.md
¿Aprendizaje durable no (aún) global?  → users/<email>/knowledge/<relpath>/<file>.md (delta)
¿Listo para el equipo / ya acordado?   → knowledge/<relpath>/ (vía consolidation promote|merge)
```

No hay tercera capa `memory/` para hechos durables.

## 4. Cierre de bloque (MUST)

1. Append work-log en `users/<email>/work-log/YYYY/MM/DD.md` (**Qué** + **Por qué**).
2. Si hay aprendizaje reutilizable → crear/actualizar delta + `DELTAS.md`.
3. Si varios usuarios o delta maduro → proponer fila en `consolidation/QUEUE.md` (no consolidar sin confirmación).

## 5. Tool-agnostic first

- Protocol SoT = this repo (`AGENTS.md` + this contract).  
- Cursor / Claude Code / others: **thin adapters only** (`adapters/`).  
- Do not grow `.cursor/`, `.claude/`, etc. with duplicated close-out or delta rules.  
- Workspace MUST make this repo visible to the agent (container folder or multi-root).

## 6. Privacidad

- `work-log/`, `MEMORY.md`, `preferences.md` son **locales por defecto** (gitignore en el repo).  
- En git compartido SÍ van: `users/<email>/knowledge/**` (deltas), `DELTAS.md`, `IDENTITY.md`.  
- Nunca pegar secretos, tokens ni PII en logs ni deltas.
