# Ordem das migrations

## Schema declarative (greenfield)

1. [`database/schema/`](../../../database/schema/) — um arquivo ≈ um `CREATE` (enums → tables → views → functions → RLS).
2. Registro: versão `schema/…` em `rpg.schema_migration`.

**Sem produção:** mudou o modelo → editar o `CREATE` e `npm run db:setup`. Pasta `database/migrations/` fica vazia até surgir necessidade real de forward-only.

Doc: [`docs/architecture/sql-layout.md`](../../../docs/architecture/sql-layout.md).

## Forward-only (opcional)

Se no futuro precisar de ALTER sem rebasar o schema, criar arquivos em `database/migrations/` — ordem lexicográfica por path.

## Setup

```bash
npm run db:setup   # reset → schema (+ forward se houver) → seed
```

Fonte de verdade: `database/schema/` + `database/seeds/` (+ `database/migrations/` se houver).
