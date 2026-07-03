---
name: api-consumer-next
description: Contrato entre API Nest (repo dnd-api) e frontend Next.js (dnd-front) — CORS, slugs, JWT, env, plano mestre. Use ao integrar front, configurar CORS/FRONTEND_URL ou documentar endpoints.
---

# API ↔ Next.js (`dnd-front`)

- **Plano mestre frontend:** [`docs/rpg-web-plan.md`](../../../docs/rpg-web-plan.md)
- **Infra:** [`docs/infrastructure.md`](../../../docs/infrastructure.md)

## Repos

| Nome | Papel |
|------|-------|
| **dnd-api** | Este repo — Nest + Postgres |
| **dnd-front** | Next.js — pasta irmã |

## Referências

- [`cors-setup.md`](references/cors-setup.md)
- [`api-endpoints.md`](references/api-endpoints.md)
- [`frontend-env.md`](references/frontend-env.md)

## Contrato

- Base URL: `NEXT_PUBLIC_API_URL` (local `:3000`, prod Vercel)
- Recursos por slug: `/classes/:slug`, `/spells/:slug`, `/characters/:uuid`
- Auth: Supabase no Next; `Authorization: Bearer` em `/characters/*`
- Catálogo: fetch sem auth (RSC recomendado)
- Erros: `{ statusCode, message, path, timestamp }`
- Regras D&D: **nunca** recalcular no front — API é fonte de verdade

## Skills no repo `rpg-web`

Ver §8 de [`rpg-web-plan.md`](../../../docs/rpg-web-plan.md): `rpg-web-api-client`, `rpg-web-supabase-auth`, etc.
