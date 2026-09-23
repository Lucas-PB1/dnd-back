# Migrations (TypeORM)

Runner: **TypeORM** (`npm run db:migrate`) · DataSource: [`src/database/data-source.ts`](../../src/database/data-source.ts)  
Ledger: `rpg.migrations` · Seeds: `rpg.seed_migration` · Layout: [`docs/architecture/sql-layout.md`](../../docs/architecture/sql-layout.md)

| Onde | O quê |
|------|--------|
| `src/database/migrations/*.ts` | `MigrationInterface` (única fila DDL versionada) |
| `database/schema/**` | DDL SSOT — `CREATE` aplicado pela baseline |
| `database/seeds/**` | DML catálogo — ledger `rpg.seed_migration` (`db:seed` / `fresh` / `status`), **nunca** em `MigrationInterface` |

## Dois modos

| Modo | Quando | O que fazer |
|------|--------|-------------|
| **Wipe / greenfield** | Dev local, cloud descartável | Editar `database/schema/**` (+ entity) → `npm run db:setup` |
| **Forward** | DB com dados a preservar | Editar `schema/**` **e** nova migration TypeORM → `npm run db:migrate` |

A baseline (`BaselineSchema…`) só re-aplica `schema/**` em DB **sem** catálogo. Se `phb_edition` já existe e a baseline está pendente → `db:reset` (ou wipe cloud) antes.

## Checklist de mudança de schema

1. **SQL SSOT** — coluna/tabela/índice em `database/schema/**` (CREATE alinhado ao modelo final)
2. **Entity** — `@Column` / relação em `src/entities/**` (sem inventar coluna só no TS)
3. **Forward?** — se algum ambiente **não** pode wipe: `npm run db:migration:create -- src/database/migrations/Nome` e DDL idempotente no `up()` (`IF NOT EXISTS` / `DROP IF EXISTS` quando seguro)
4. **Seed / view** — se o contrato de leitura mudar
5. **Rodar** — local: `db:migrate` (forward) ou `db:setup` (wipe); cloud: `--target=supabase` / `db:migrate:all`

## Regras duras

| Regra | Detalhe |
|-------|---------|
| **Nunca editar migration já aplicada** | Em local/cloud que já rodou o arquivo; corrija com migration **nova** |
| **Não** ligar `synchronize: true` | Nest e CLI ficam `false` |
| **Não** enfiar DML PHB em migration | Seeds = `database/seeds/**` (TORM-4: ledger próprio) |
| **Não** segundo runner | Só TypeORM após TORM-2 (`run-migrations.mjs` removido) |
| Baseline **irreversível** | `down()` da baseline falha de propósito — use `db:reset` |

## Comandos

```bash
npm run db:migrate:show
npm run db:migrate
npm run db:migration:create -- src/database/migrations/AddFoo
npm run db:migration:generate -- src/database/migrations/AddFoo   # diff entities (usar com cuidado)
```

Exemplo forward idempotente já na fila: `AddWeaponSecondaryMastery…` (`secondary_mastery_id` em `phb_weapon` — no-op se a baseline já criou a coluna).
