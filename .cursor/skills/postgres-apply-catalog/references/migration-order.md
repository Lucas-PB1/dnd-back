# Ordem das migrations

## Baseline (squash greenfield)

1. [`database/baseline/001_full_schema.sql`](../../../database/baseline/001_full_schema.sql) — schema `rpg` completo (enums + tabelas + views/funções). Inclui motor `phb_effect`.

Registro: versão `baseline/001_full_schema` em `rpg.schema_migration`.

**Sem produção:** não há histórico forward a preservar. Mudança de schema → editar o baseline e `npm run db:setup`. Pasta `database/migrations/` fica vazia até surgir necessidade real de forward-only.

Histórico granular antigo: git (pré squash).

## Forward-only (opcional)

Se no futuro precisar de ALTER sem rebasar o baseline, criar arquivos em `database/migrations/` — ordem lexicográfica por path (`010_types/`, `020_tables/`, …).

## Setup

```bash
npm run db:setup   # reset → baseline (+ forward se houver) → seed
```

Fonte de verdade: `database/baseline/` + `database/seeds/` (+ `database/migrations/` se houver).
