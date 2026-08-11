---
name: postgres-apply-catalog
description: Aplica catálogo PHB ao PostgreSQL — dev-reset, migrations granulares e seeds. Use quando subir banco local, Supabase ou reaplicar schema e dados.
---

# Aplicar catálogo SQL

## Referências

- [`dev-reset-flow.md`](references/dev-reset-flow.md)
- [`migration-order.md`](references/migration-order.md)
- [`seed-order.md`](references/seed-order.md)

## Ordem

1. `dev-reset.sql` (só dev)
2. Migrations recursivas ordenadas
3. Seeds recursivos ordenados

## Preferir npm

```powershell
npm run db:setup              # local: reset → migrate → seed
npm run db:setup:all          # local + Supabase (wipe remoto com --confirm; OK sem dados reais)
```

Equivalente manual local:

```powershell
psql $env:DATABASE_URL -f database/dev-reset.sql
Get-ChildItem database/migrations -Recurse -Filter *.sql | Sort-Object FullName | ForEach-Object { psql $env:DATABASE_URL -f $_.FullName }
Get-ChildItem database/seeds -Recurse -Filter *.sql | Sort-Object FullName | ForEach-Object { psql $env:DATABASE_URL -f $_.FullName }
```

Não use scripts `apply-*` / `reseed-*` avulsos — SSOT = `database/seeds/` via `run-seeds.mjs`.

## Supabase (remoto)

Configure `SUPABASE_DATABASE_URL` (direct, porta 5432) no `.env`:

```bash
npm run db:migrate:all        # local + Supabase (incremental schema)
npm run db:seed:supabase      # só se o banco remoto estiver vazio / truncável
npm run db:setup:all          # wipe+migrate+seed local e remoto (exige --confirm no reset)
```

**Cuidado:** wipe no Supabase apaga tudo. Sem dados reais de jogador, preferir `db:setup:all` para alinhar o catálogo.
