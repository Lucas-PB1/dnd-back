# Dev reset

Arquivo: `database/dev-reset.sql`

```sql
DROP SCHEMA IF EXISTS rpg CASCADE;
CREATE SCHEMA rpg;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
```

**Só desenvolvimento local** (`DATABASE_URL` = localhost).

## Quando usar

- Banco local limpo (`npm run db:up` + `npm run db:reset`)
- Reaplicar catálogo do zero após mudanças em schema/seeds

## Nunca no loop de debug remoto

Se `DATABASE_URL` for Supabase cloud, o script **aborta** (use `SUPABASE_DATABASE_URL` + `--target=supabase --confirm`).

## Cloud (raro)

```bash
node scripts/dev-reset.mjs --target=supabase --confirm
```

Apaga o schema `rpg` no projeto remoto.
