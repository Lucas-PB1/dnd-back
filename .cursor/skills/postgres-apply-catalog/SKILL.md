# Aplicar catálogo SQL

## Referências

- [`dev-reset-flow.md`](references/dev-reset-flow.md)
- [`migration-order.md`](references/migration-order.md)
- [`seed-order.md`](references/seed-order.md)
- Doc: [`docs/architecture/sql-layout.md`](../../../docs/architecture/sql-layout.md)

## Iterar no local (obrigatório)

`DATABASE_URL` deve ser **localhost** (Docker / Postgres / `supabase start`).  
Cloud = `SUPABASE_DATABASE_URL` + `--target=supabase` / `db:setup:all` — **não** no loop de debug.

```powershell
npm run db:supabase:start    # Supabase local (precisa Docker Desktop verde)
# .env → DATABASE_URL da saída de: npm run db:supabase:status  (porta ~54322)
npm run db:setup              # reset → migrate → seed LOCAL
npm run db:seed -- --from=path/relativo.sql --skip-truncate   # resume após falha
```

Alternativa só Postgres: `npm run db:up` (porta 5432).

Se `DATABASE_URL` for `*.supabase.co`, reset/seed local **recusam** (use `--allow-remote` só se souber o custo).

## Ordem

1. `dev-reset.sql` (só dev local)
2. Schema declarative (`database/schema/**`)
3. Seeds (`SEED_ORDER.txt` / domínios; `effect/` por último)

## Preferir npm

```powershell
npm run db:setup              # só local
npm run db:setup:all          # local OK + wipe/seed cloud (raro)
```

Não use scripts `apply-*` / `reseed-*` avulsos — SSOT = `database/seeds/` via `run-seeds.mjs`.

## Supabase (remoto / alinhamento)

```bash
npm run db:migrate:supabase
npm run db:seed:supabase
npm run db:setup:all          # exige --confirm no reset remoto
```

**Cuidado:** wipe no cloud apaga o schema `rpg`. Só depois do seed local verde.
