# Migrations PostgreSQL

Schema do **catálogo PHB** em migrations granulares.

## Estrutura

| Pasta / arquivo | Conteúdo |
|-----------------|----------|
| `001_schema.sql` | `CREATE SCHEMA rpg` + extensão `pg_trgm` |
| `010_types/` | ENUMs |
| `020_tables/T###_<nome>.sql` | Uma tabela por arquivo (+ índices inline) |
| `040_functions/` | Funções PL/pgSQL |
| `050_triggers/` | Triggers |
| `060_views/V###_<nome>.sql` | Uma view por arquivo |
| `070_materialized/` | Materialized views |
| `080_indexes/` | Índices adicionais |

Registro: `rpg.schema_migration` (versão = caminho relativo sem `.sql`).

## Aplicar

**Dev local (reset + catálogo completo):**

```bash
npm run db:setup
```

Ordem: reset → migrations de schema → seeds (PHB) → migrations `050_data` (opções de talento, humano, etc.).

**Incremental** — `npm run db:migrate` aplica tudo pendente; em banco **só com schema**, rode `db:seed` antes de aplicar `050_data`, ou use `db:migrate:data` após seed.

```bash
npm run db:migrate          # DATABASE_URL
npm run db:migrate:supabase # SUPABASE_DATABASE_URL (direct 5432)
npm run db:migrate:all      # os dois
```

O runner registra versões em `rpg.schema_migration` e só aplica arquivos pendentes.

**Banco já existente** (aplicado antes via psql):

```bash
npm run db:migrate:baseline      # marca tudo como aplicado, sem reexecutar SQL
npm run db:migrate:baseline:all  # local + Supabase
```

**Seeds** (banco vazio ou após `db:reset`):

```bash
npm run db:seed
npm run db:seed:supabase
```

Sem tabelas `player_character_*` no fluxo padrão de catálogo — ver `090_player/` para dados de jogador (fase 5+).
