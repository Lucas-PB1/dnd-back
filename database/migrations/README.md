# Migrations PostgreSQL

Schema do **catálogo PHB** em migrations granulares.

## Estrutura

| Pasta / arquivo | Conteúdo |
|-----------------|----------|
| `001_schema.sql` | `CREATE SCHEMA rpg` + extensão `pg_trgm` |
| `010_types/` | ENUMs |
| `020_tables/T###_<nome>.sql` | Uma tabela por arquivo (`T001`–`T077`) |
| `040_functions/` | Funções PL/pgSQL |
| `050_triggers/` | Triggers |
| `060_views/V###_<nome>.sql` | Uma view por arquivo (`V001`–`V030`) |
| `070_materialized/` | Materialized views |
| `080_indexes/` | Índices adicionais |
| `090_player/P###_<nome>.sql` | Jogador + RLS (`P001`–`P014`) |

Registro: `rpg.schema_migration` (versão = caminho relativo sem `.sql`).

## Aplicar

**Dev local (reset + catálogo completo):**

```bash
npm run db:setup
```

Ordem: reset → migrations → seeds (PHB + Valda).

**Incremental:**

```bash
npm run db:migrate          # DATABASE_URL
npm run db:migrate:supabase # SUPABASE_DATABASE_URL (direct 5432)
npm run db:migrate:all      # os dois
```

O runner registra versões em `rpg.schema_migration` e só aplica arquivos pendentes.

**Seeds** (banco vazio ou após `db:reset`):

```bash
npm run db:seed
npm run db:seed:supabase
```

**Dev reset com confirmação:**

```bash
npm run db:reset                    # LOCAL apenas
npm run db:reset -- --target=supabase # Supabase (requer CONFIRM_DROP_RPG=yes)
```

Sem tabelas `player_character_*` no fluxo padrão de catálogo — ver `090_player/` para dados de jogador (fase 5+).
