# Migrations PostgreSQL

Schema do **catálogo PHB** em migrations granulares — geradas por `npm run generate:sql-schema`.

## Estrutura

| Pasta / arquivo | Conteúdo |
|-----------------|----------|
| `001_schema.sql` | `CREATE SCHEMA rpg` + extensão `pg_trgm` |
| `010_types/` | ENUMs |
| `020_tables/T###_<nome>.sql` | **Uma tabela por arquivo** (+ índices inline) |
| `040_functions/` | Funções PL/pgSQL |
| `050_triggers/` | Triggers |
| `060_views/V###_<nome>.sql` | **Uma view por arquivo** |
| `070_materialized/` | Materialized views |
| `080_indexes/` | Índices adicionais |

Registro: `rpg.schema_migration` (versão = caminho relativo sem `.sql`).

## Comandos

```bash
npm run generate:sql-schema   # schema.sql + migrations/
npm run migrate:run           # aplica pendentes
npm run seed:run              # dev-reset + migrate + seeds
npm run seed:prod             # migrate + seeds (sem DROP)
```

**Não editar migrations à mão** — altere `scripts/generate-sql-schema.mjs` e regenere.

Sem tabelas `player_character_*` — este repo é só catálogo para testar o modelo PostgreSQL.
