---
name: supabase-auth
description: Integra Supabase Auth com NestJS — validação JWT, guards, ownership; RLS opcional no futuro. Use quando autenticar, proteger rotas game ou configurar JWT.
---

# Supabase Auth

Infra: [`docs/infrastructure.md`](../../../docs/infrastructure.md)

## Referências

- [`jwt-validation-nest.md`](references/jwt-validation-nest.md)
- [`rls-player-data.md`](references/rls-player-data.md)
- [`env-vars.md`](references/env-vars.md)

## Workflow (atual)

1. Login/signup no **dnd-front** (`@supabase/supabase-js`)
2. Nest valida JWT nas rotas game (`SupabaseAuthGuard` + JWKS)
3. Ownership na API (`userId` do personagem = `sub` do JWT)
4. Catálogo `phb_*` permanece SELECT público (sem guard)
5. RLS no Postgres para `player_*` — opcional / futuro (hoje a API filtra)

## Não fazer

- Expor service role no client
- Guard em rotas de catálogo público
