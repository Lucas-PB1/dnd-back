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

Mudou o modelo?

| Caminho | Ação |
|---------|------|
| Wipe OK (dev) | Editar `CREATE` aqui + entity → `npm run db:setup` |
| DB com dados | Idem **e** migration TypeORM (`npm run db:migration:create`) — ver [`../migrations/README.md`](../migrations/README.md) |

**Nunca** editar migration já aplicada. Runner: [`BaselineSchema`](../../src/database/migrations/1727000000000-BaselineSchema.ts) · política: [`../migrations/README.md`](../migrations/README.md).
