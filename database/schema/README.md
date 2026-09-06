# Schema `rpg` (declarative)

SSOT do DDL. Um arquivo ≈ um objeto (`CREATE`). Ordem = prefixo numérico + pasta.

| Pasta | Conteúdo |
|-------|----------|
| `000_rpg_schema.sql` | SCHEMA + extensions |
| `010_enums/` | `CREATE TYPE` |
| `015_functions/` | helpers early (`set_updated_at`) |
| `020_tables/` | `CREATE TABLE` + indexes/comments |
| `030_views/` | views + materialized views |
| `040_functions/` | functions que dependem de tabelas |
| `045_triggers/` | `CREATE TRIGGER` |
| `050_runtime/` | RLS policies (`DO $$ …`) |

Mudou o modelo? Edite o `CREATE` e rode `npm run db:setup`. **Sem ALTER.**

Gerado a partir do baseline histórico; não editar `database/baseline/` (removido após migração).
