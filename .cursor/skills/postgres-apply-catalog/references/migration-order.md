# Ordem das migrations

## Baseline (squash + compactação greenfield — 2026-09)

1. [`database/baseline/001_full_schema.sql`](../../../database/baseline/001_full_schema.sql) — schema `rpg` completo (~241 KiB; 0 `ALTER TABLE` evolutivo top-level; enums no `CREATE TYPE`)

Registro: versão `baseline/001_full_schema` em `rpg.schema_migration`.

Histórico granular (239 arquivos): git history pré 2026-09-01. **Não** regerar — editar baseline ou forward.

## Forward-only

Novos arquivos em `database/migrations/` — ordem lexicográfica por path:

1. `010_types/` — enums
2. `020_tables/T###` — tabelas
3. `040_functions/`, `050_triggers/`
4. `060_views/V###`
5. `070_materialized/`, `080_indexes/`
6. `090_player/P###` — runtime + RLS

Não há migrations de dados de catálogo — isso fica nos seeds (`database/seeds/`).

## Registro

Tabela `rpg.schema_migration` via `npm run db:migrate` (versão = caminho relativo sem `.sql`).

## Setup

```bash
npm run db:setup   # reset → baseline + forward → seed
```

Fonte de verdade: `database/baseline/` + `database/migrations/` + `database/seeds/`.

Histórico granular: git history (pré 2026-09-01).
