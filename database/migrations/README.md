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

## Aplicar (dev)

```bash
psql "$DATABASE_URL" -f database/dev-reset.sql
Get-ChildItem database/migrations -Recurse -Filter *.sql | Sort-Object FullName | ForEach-Object { psql "$DATABASE_URL" -f $_.FullName }
Get-ChildItem database/seeds -Recurse -Filter *.sql | Sort-Object FullName | ForEach-Object { psql "$DATABASE_URL" -f $_.FullName }
```

Sem tabelas `player_character_*` no fluxo padrão de catálogo — ver `090_player/` para dados de jogador (fase 5+).
