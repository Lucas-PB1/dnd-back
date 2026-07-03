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

## PowerShell (legado — preferir npm)

```powershell
npm run db:setup
```

Equivalente manual:

```powershell
psql $env:DATABASE_URL -f database/dev-reset.sql
Get-ChildItem database/migrations -Recurse -Filter *.sql | Sort-Object FullName | ForEach-Object { psql $env:DATABASE_URL -f $_.FullName }
Get-ChildItem database/seeds -Recurse -Filter *.sql | Sort-Object FullName | ForEach-Object { psql $env:DATABASE_URL -f $_.FullName }
```

## Supabase (remoto)

Configure `SUPABASE_DATABASE_URL` (direct, porta 5432) no `.env`:

```bash
npm run db:migrate:all    # local + Supabase (incremental)
npm run db:migrate:supabase
npm run db:seed:supabase  # só em banco vazio
```

**Não** rodar `db:reset` no Supabase.
