# users/

Una carpeta por persona. Id = **`git config user.email` en minúsculas**, tal cual (se conserva `@`).

Ejemplo: `devsolarte@gmail.com` → `users/devsolarte@gmail.com/`.

`knowledge/` dentro del usuario **espeja** el global con **mismo basename** (deltas). Work-log/prefs son locales (gitignore).

## Layout

```text
users/<email>/
  IDENTITY.md               # tracked
  DELTAS.md                 # tracked
  knowledge/                # tracked — deltas only, same paths as global
  work-log/                 # LOCAL — YYYY/MM/DD.md
  preferences.md            # LOCAL gitignore
  MEMORY.md                 # LOCAL gitignore
```

## Crear usuario

1. `git config --get user.email`
2. Copiar `_template/` → `users/<email>/`
3. Completar `IDENTITY.md`

Detalle: [../knowledge/architecture/agent-knowledge-operating-contract.md](../knowledge/architecture/agent-knowledge-operating-contract.md) · [AGENTS.md](../AGENTS.md)
