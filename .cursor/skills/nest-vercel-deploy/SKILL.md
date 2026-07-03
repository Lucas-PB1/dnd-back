---
name: nest-vercel-deploy
description: Deploy NestJS na Vercel — zero-config, serverless, diferenças vs Nest tradicional, TypeORM com Supabase pooler. Use quando o usuário mencionar Vercel, deploy, serverless, cold start, ou diferenças entre Nest normal e Vercel.
---

# NestJS na Vercel

## Quando usar

- Deploy ou dev local simulando produção Vercel
- Dúvidas sobre serverless vs processo long-running
- Configurar TypeORM + Supabase para Vercel

## Workflow

1. Ler [`vercel-vs-traditional.md`](references/vercel-vs-traditional.md) — **obrigatório** antes de sugerir arquitetura
2. Confirmar entrypoint → [`entrypoint-and-build.md`](references/entrypoint-and-build.md)
3. Configurar DB → [`database-on-vercel.md`](references/database-on-vercel.md)
4. CORS/sessões → [`cors-sessions-proxy.md`](references/cors-sessions-proxy.md)
5. Dev local → [`local-dev.md`](references/local-dev.md)
6. Restrições → [`serverless-constraints.md`](references/serverless-constraints.md)

## Checklist deploy

- [ ] `src/main.ts` com `bootstrap()` + `app.listen(process.env.PORT ?? 3000)`
- [ ] `DATABASE_URL` com pooler Supabase (6543) no dashboard Vercel
- [ ] TypeORM pool mínimo / singleton
- [ ] `vercel dev` testado localmente
- [ ] Env vars no dashboard (nunca commitadas)
