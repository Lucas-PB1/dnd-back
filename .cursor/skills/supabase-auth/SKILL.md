---
name: supabase-auth
description: Supabase Auth + conexão DB no Nest — JWT, guards, ownership, pooler, env. Use quando autenticar rotas game ou configurar DATABASE_URL/Supabase.
---

# Supabase (Auth + DB) — dnd-api

Infra: [`docs/infrastructure.md`](../../../docs/infrastructure.md)  
Genérico Supabase → skill global `supabase` (shared-ai).

## Referências

- [`jwt-validation-nest.md`](references/jwt-validation-nest.md)
- [`rls-player-data.md`](references/rls-player-data.md)
- [`env-vars.md`](references/env-vars.md)
- [`pooler-and-env.md`](references/pooler-and-env.md)
- [`extensions.md`](references/extensions.md)
- [`rls-future.md`](references/rls-future.md)

## Auth (atual)

1. Login/signup no **dnd-front** (`@supabase/supabase-js`)
2. Nest valida JWT nas rotas game (`SupabaseAuthGuard` + JWKS)
3. Ownership na API (`userId` = `sub` do JWT)
4. Catálogo `phb_*` SELECT público (sem guard)
5. RLS em `player_*` — opcional/futuro (hoje a API filtra)

## Runtime JWT

- Pacote: **`jsonwebtoken`** + `fetch` JWKS + `crypto`
- **Não** usar `jose` / `jwks-rsa` no runtime deste repo

## DB quick setup

1. Habilitar `pg_trgm`
2. Aplicar catálogo (skill `postgres-apply-catalog`)
3. App: `DATABASE_URL` = transaction pooler **6543** + `?pgbouncer=true`
4. Migrations: `SUPABASE_DATABASE_URL` = session/direct **5432**

## Não fazer

- Expor service role no client
- Guard em rotas de catálogo público
