---
name: nest-vercel-deploy
description: Deltas Nest+TypeORM+Supabase para deploy Vercel deste repo. Use quando configurar vercel.json, pooler, cold start ou smoke health.
---

# Nest na Vercel — deltas dnd-api

Genérico Vercel → skill global `vercel` (shared-ai).  
Detalhes longos ainda em `references/` deste skill (entrypoint, pooler, CORS).

## Quando usar

- Env / `DATABASE_URL` pooler 6543 neste projeto
- Cold start + TypeORM + SSL Supabase
- `vercel.json` / `npm run smoke:health`

## Checklist deste repo

- [x] `src/main.ts` — `bootstrap()` + `app.listen(process.env.PORT ?? 3000)`
- [x] `reflect-metadata` em `main.ts`
- [x] JWT: `jsonwebtoken` + JWKS `fetch` — **zero** `jose` no runtime
- [x] `DATABASE_URL` pooler 6543 + `?pgbouncer=true` em prod
- [x] `vercel.json` sem `framework: null`
- [x] `npm run smoke:health` → `/health`
- [ ] Env vars no dashboard Vercel
- [ ] `FRONTEND_URL` = URL do dnd-front em prod

## Workflow

1. Shared-ai `vercel` para preview/deploy genérico
2. [`database-on-vercel.md`](references/database-on-vercel.md) — pooler TypeORM
3. [`cors-sessions-proxy.md`](references/cors-sessions-proxy.md) — `FRONTEND_URL`
4. [`serverless-constraints.md`](references/serverless-constraints.md) se cold start / conexões
