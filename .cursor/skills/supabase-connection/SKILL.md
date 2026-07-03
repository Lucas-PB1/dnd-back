---
name: supabase-connection
description: Configura conexão Supabase com TypeORM — pooler, env vars, extensões pg_trgm, RLS futuro. Use quando configurar DATABASE_URL, Supabase dashboard ou políticas RLS.
---

# Supabase

## Referências

- [`pooler-and-env.md`](references/pooler-and-env.md)
- [`extensions.md`](references/extensions.md)
- [`rls-future.md`](references/rls-future.md)

## Quick setup

1. Criar projeto Supabase
2. Habilitar `pg_trgm`
3. Aplicar catálogo SQL (skill `postgres-apply-catalog`)
4. Copiar connection string **transaction pooler** (6543)
5. Configurar `DATABASE_URL` no `.env` e Vercel dashboard
