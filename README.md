# agent-starter-kit

Motor de proceso reutilizable para trabajar con agentes de código (Cursor, Claude Code, etc.) en proyectos nuevos: disciplina de skills, comunicación con el usuario, foco/alcance, delegación en subagentes, y el esqueleto de **agent-knowledge** (memoria/documentación optimizada para agentes, separada del código).

No incluye skills específicos de stack (framework backend, framework frontend, testing, etc.) ni los skills `speckit-*` — esos se suman por proyecto según haga falta.

## Qué hay acá

```text
.cursor/
  rules/     — reglas de proceso (comunicación, foco, disciplina de skills, un-punto-a-la-vez, adapter a agent-knowledge)
  skills/    — pack compartido: agent-skill-discipline, git-proyecto, agent-knowledge, backlog, requerimiento, orquestar-requerimiento
agent-knowledge-template/
  — esqueleto para clonar como repo git independiente dentro del proyecto nuevo
```

## Cómo usarlo en un proyecto nuevo

1. **Copiar `.cursor/`** a la raíz del proyecto nuevo (o usar este repo como "Use this template" en GitHub y luego borrar lo que no aplique).
2. **Rellenar los placeholders** de `.cursor/rules/00-proyecto.mdc` (`{{PROJECT_NAME}}`, idioma, repos hermanos si aplica).
3. **Instanciar `agent-knowledge`:**
   - Copiar `agent-knowledge-template/` → `agent-knowledge/` (o la ruta que uses) dentro del proyecto nuevo.
   - `cd agent-knowledge && git init` (repo propio, independiente del código de la app).
   - Ajustar `config.yaml` (`repo:` field) y `README.md` con el nombre real del proyecto.
   - Copiar `users/_template/` → `users/<tu-email-de-git>/` y completar `IDENTITY.md`.
4. **Revisar rutas hardcodeadas.** Las reglas y skills de este kit usan `agent-knowledge/` como nombre genérico — si en tu proyecto vive en otra ruta (ej. `tecnologia/codigo/agent-knowledge/`), ajustar los punteros en `.cursor/rules/15-agent-knowledge.mdc`, `.cursor/skills/agent-knowledge/SKILL.md` y `adapters/cursor.md`.
5. **Sumar skills de stack** propios del proyecto (framework backend/frontend, testing E2E, migraciones de DB, etc.) — no vienen en este kit.
6. **Spec Kit (opcional):** si querés el motor de entrega por specs (`speckit-specify` → `plan` → `tasks` → `implement`), instalar `github-spec-kit` apuntando a `agent-knowledge/` como raíz (crea `.specify/` y `specs/`). El proceso ya está descrito en `agent-knowledge-template/knowledge/delivery/PROCESS.md`.
7. **Primer requerimiento:** usar `/requerimiento` con el usuario; el resto de skills son agent-only.

## Qué NO entra aquí (por decisión de alcance)

- Skills de stack (framework backend/frontend, testing, migraciones de DB, design system).
- Skills `speckit-*` — vienen de `github-spec-kit`, se instalan en cada proyecto con su propio comando.
- Cualquier contenido de negocio/dominio — `agent-knowledge-template/knowledge/` se entrega vacío a propósito.

## Mantenimiento

Este repo es una **plantilla que se copia**, no una dependencia enlazada. Si mejorás una regla o skill en un proyecto que usa este kit y querés traerla de vuelta acá, copiala a mano y quitale lo específico del proyecto de origen.
