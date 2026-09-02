# Migrations forward-only

Schema **incremental** após o baseline. Catálogo completo vive em [`../baseline/`](../baseline/README.md).

## Estrutura (quando houver arquivos)

| Pasta | Conteúdo |
|-------|----------|
| `010_types/` | Novos ENUMs ou `ALTER TYPE` (evitar — preferir enum completo no baseline pré-prod) |
| `020_tables/T###_<nome>.sql` | Tabelas / colunas novas |
| `040_functions/` | Funções PL/pgSQL |
| `050_triggers/` | Triggers |
| `060_views/V###_<nome>.sql` | Views |
| `070_materialized/` | Materialized views |
| `080_indexes/` | Índices adicionais |
| `090_player/P###_<nome>.sql` | Runtime jogador + RLS |

Registro: `rpg.schema_migration` (versão = caminho relativo sem `.sql`).

## Aplicar

```bash
npm run db:setup              # reset + baseline + forward + seeds
npm run db:migrate            # DATABASE_URL
npm run db:migrate:supabase   # SUPABASE_DATABASE_URL (direct 5432)
```

O runner aplica `database/baseline/001_full_schema.sql` uma vez, depois só arquivos `.sql` pendentes nesta pasta (ordem lexicográfica).

**Seeds** (dados de catálogo): [`../seeds/`](../seeds/) via `npm run db:seed` — não ficam em migrations.
