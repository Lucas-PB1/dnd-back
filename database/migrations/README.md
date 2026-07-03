# Migrations PostgreSQL

Schema do catálogo PHB em **migrations granulares** — geradas por `npm run generate:sql-schema`.

## Estrutura

| Pasta / arquivo | Conteúdo |
|-----------------|----------|
| `001_schema.sql` | `CREATE SCHEMA rpg` + extensão `pg_trgm` |
| `types/002_types.sql` | ENUMs |
| `tables/T###_<nome>.sql` | **Uma tabela por arquivo** (+ índices inline) |
| `alters/A###_<nome>.sql` | `ALTER TABLE` (ex.: `tool_category_id` em antecedentes) |
| `functions/F001_set_updated_at.sql` | Função de auditoria |
| `triggers/TR001_audit.sql` | Triggers `updated_at` |
| `views/V###_<nome>.sql` | **Uma view por arquivo** |
| `materialized/MV001_*.sql` | Materialized views |
| `indexes/IX001_catalog.sql` | Índices adicionais |
| `comments/C001_schema.sql` | Comentários |

Registro: `rpg.schema_migration` (versão = caminho relativo sem `.sql`).

## Comandos

```bash
# Regenerar schema.sql + migrations/ a partir dos scripts em scripts/lib/
npm run generate:sql-schema

# Aplicar migrations pendentes
npm run migrate:run

# Dev: reset + migrations + seeds
npm run seed:run

# Produção: migrations + seeds (sem DROP)
npm run seed:prod
```

## Regras

1. Editar DDL em `scripts/generate-sql-schema.mjs` e `scripts/lib/subclass-mechanics-ddl.mjs`
2. Rodar `npm run generate:sql-schema` — **não editar migrations à mão**
3. `database/schema.sql` é referência concatenada (catálogo only, sem fichas)
