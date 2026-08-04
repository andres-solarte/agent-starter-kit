# agent-knowledge

Conocimiento compartido del proyecto **optimizado para agentes**, en git independiente.

Contrato: [knowledge/architecture/agent-knowledge-operating-contract.md](./knowledge/architecture/agent-knowledge-operating-contract.md).

## Uso rápido

1. Agentes: [AGENTS.md](./AGENTS.md) (SoT). Adapters opcionales: [adapters/](./adapters/).
2. Humanos: [INDEX.md](./INDEX.md).
3. Config: [config.yaml](./config.yaml).

Carga en `.cursor` / `.claude`: **mínima** (solo punteros). El protocolo no se duplica ahí.

## Capas

- `knowledge/` — global
- `users/<email>/knowledge/` — deltas (mismo basename)
- `users/<email>/work-log/` — local (no se pushea por defecto)
- `consolidation/` — promote / merge

## Identidad

Carpeta = `git config user.email` en minúsculas **tal cual** (ej. `dev@example.com`).

## Al usar este template en un proyecto nuevo

1. Renombrar/completar `config.yaml` (`repo:` field) y este `README.md`.
2. Dejar vacías las carpetas de `knowledge/` hasta que haya contenido real del proyecto (no inventar).
3. Crear el primer usuario copiando `users/_template/` → `users/<email>/`.
4. Ver checklist completo en el `README.md` raíz del starter kit.
