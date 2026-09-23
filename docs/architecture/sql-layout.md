# Layout SQL — schema declarative + seeds + TypeORM

SSOT do catálogo Postgres (`rpg`). Runner DDL: **TypeORM** (`npm run db:migrate`).

## Onde iterar (importante)

| Alvo | Quando | Comando |
|------|--------|---------|
| **Postgres local** | Quase sempre (schema/seeds/FK) | `npm run db:up` → `DATABASE_URL=localhost` → `npm run db:setup` |
| **Supabase cloud** | Só alinhar catálogo no fim | `npm run db:setup:all` ou `--target=supabase` |

Se `DATABASE_URL` apontar para `*.supabase.co`, `db:reset` / `db:seed` **local falham de propósito** (era isso que deixava o ciclo lento). Escape: `--allow-remote`.

### Stack local

```bash
# Opção A — Supabase local (recomendado se quiser Auth/Studio + Postgres)
# Requer Docker Desktop rodando.
npm run db:supabase:start
# .env: use a DB URL impressa por `npm run db:supabase:status` (porta típica 54322)
# DATABASE_URL=postgresql://postgres:postgres@127.0.0.1:54322/postgres
npm run db:setup

# Opção B — só Postgres (Docker Compose)
npm run db:up
# .env: DATABASE_URL=postgresql://postgres:postgres@localhost:5432/postgres
npm run db:setup
```

### Ciclo rápido após falha no seed

```bash
# Corrige o SQL, depois retoma sem truncate (dados anteriores ficam)
npm run db:seed -- --from=thread/northlands/phb_character.threads.sql --skip-truncate --skip-refresh

# Ou seed completo local (truncate) sem re-migrar schema
npm run db:seed
```

Cloud remoto: só quando o seed local estiver verde.

## Árvore

```text
database/
  schema/                      # DDL SSOT (CREATE; um arquivo ≈ um objeto)
  seeds/
    000_truncate.sql
    SEED_ORDER.txt             # ordem FK-safe
    {domínio}/{fonte}/{tabela}.{conteudo-slug}.sql
  migrations/                  # README da política; arquivos .ts vivem em src/

src/database/
  data-source.ts               # CLI TypeORM
  migrations/*.ts              # Baseline + forward (ledger rpg.migrations)
```

## Seeds — nome e ordem

```text
{tabela}.{conteudo-slug}[.nn].sql
```

- Conteúdo = identidade jogável — **não** `E008` / `C078`.
- Ordem: [`SEED_ORDER.txt`](../../database/seeds/SEED_ORDER.txt) (`node scripts/generate/seed-order.mjs`).

## Regras duras

| Regra | Detalhe |
|-------|---------|
| **Wipe local** | Editar `CREATE` em `schema/**` + entity → `npm run db:setup` |
| **Forward** | DB com dados: `schema/**` + migration TypeORM nova (`db:migration:create`); **nunca** editar migration já aplicada |
| Upsert | `INSERT … ON CONFLICT`. Effects CTE: `-- seed-mode: truncate-scoped`. |
| Local ≠ cloud | `DATABASE_URL` = localhost; `SUPABASE_DATABASE_URL` = cloud. |
| Legado → Vasco | Após migrar fatia, apagar arquivo antigo no mesmo PR. |
| Seeds ≠ migrations | DML só em `database/seeds/**` + ledger `rpg.seed_migration` (`db:seed` / `fresh` / `status`). |

Política completa: [`database/migrations/README.md`](../../database/migrations/README.md).

## Domínios

`catalog` · `background` · `class` · `subclass` · `species` · `feat` · `transformation` · `heritage` · `thread` · `item` · `spell` · `economy` · `creature` · `effect` · `notes`

Skill: [`catalog-sql-first`](../../.cursor/skills/catalog-sql-first/SKILL.md).
