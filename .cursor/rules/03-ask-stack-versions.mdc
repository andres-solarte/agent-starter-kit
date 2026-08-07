# Stack versions

Source of truth: **`agent-knowledge/knowledge/architecture/stack-versions.md`** (create if missing).

## When introducing or updating a technology

1. Look up the **latest stable version** (npm, official releases, Docker tags)
2. Verify **compatibility** with the rest of the documented stack
3. Update `stack-versions.md` (version, verification date, source, notes)
4. If it is a material decision → ADR in `agent-knowledge/knowledge/decisions/architecture/`

## Compatibility criteria (examples — adjust to the project's real stack)

- Respect the framework's minimum requirements
- Prefer **LTS / stable** versions for production
- Avoid betas in critical pieces (DB, runtime)
- Coupled pairs (e.g. framework + its driver/ORM) must stay aligned

## In code (when it exists)

- Pin versions in `package.json` / `Dockerfile` aligned with `stack-versions.md`
- `engines.node` (or equivalent) consistent with what is documented

## Do not

- Assume versions from memory without checking
- Stop updating `stack-versions.md` when changing dependencies
