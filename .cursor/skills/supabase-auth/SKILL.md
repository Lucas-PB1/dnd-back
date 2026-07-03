---
name: supabase-auth
description: Integra Supabase Auth com NestJS na Vercel — validação JWT, guards, RLS futuro. Use quando implementar autenticação, proteger rotas ou configurar auth.uid() no Postgres.
---

# Supabase Auth

Infra: [`docs/infrastructure.md`](../../../docs/infrastructure.md)

## Referências

- [`jwt-validation-nest.md`](references/jwt-validation-nest.md)
- [`rls-player-data.md`](references/rls-player-data.md)
- [`env-vars.md`](references/env-vars.md)

## Workflow

1. Login/signup no **repo Next.js** — não neste repo
2. Nest valida JWT nas rotas protegidas (fase futura)
3. RLS no Supabase com `auth.uid()` para tabelas de jogador
4. Catálogo `phb_*` permanece SELECT público

## Fase atual

Sem auth — endpoints catálogo públicos. Preparar env vars e skill para fase 2.
