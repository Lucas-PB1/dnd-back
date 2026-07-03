# Dev reset

Arquivo: `database/dev-reset.sql`

```sql
DROP SCHEMA IF EXISTS rpg CASCADE;
CREATE SCHEMA rpg;
CREATE EXTENSION IF NOT EXISTS pg_trgm;
```

**Só desenvolvimento.** Apaga todo o schema `rpg`.

## Quando usar

- Banco local limpo
- Reaplicar catálogo do zero após mudanças em migrations/seeds

## Nunca em prod

Supabase produção: migrations incrementais apenas.
