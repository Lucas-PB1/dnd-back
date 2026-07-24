---
name: api-consumer-next
description: Contrato entre API Nest (dnd-api) e frontend Next.js (dnd-front) — CORS, slugs, JWT, env. Use ao integrar front ou documentar endpoints.
---

# API ↔ Next.js (`dnd-front`)

- **Plano frontend:** [`docs/rpg-web-plan.md`](../../../docs/rpg-web-plan.md)
- **Infra:** [`docs/infrastructure.md`](../../../docs/infrastructure.md)
- Workspace: `dnd-work/` — pastas irmãs `dnd-api` + `dnd-front`

## Referências

- [`cors-setup.md`](references/cors-setup.md)
- [`api-endpoints.md`](references/api-endpoints.md)
- [`frontend-env.md`](references/frontend-env.md)

## Contrato

- Base URL: `NEXT_PUBLIC_API_URL` (local `:3000`)
- Recursos por slug: `/classes/:slug`, `/spells/:slug`, `/characters/:uuid`
- Auth: Supabase no Next; `Authorization: Bearer` em `/characters/*`
- Catálogo: fetch sem auth
- Erros: `{ statusCode, message, path, timestamp }`
- Regras D&D: **nunca** recalcular no front — API é fonte de verdade

## Skills no front

No repo `dnd-front`: `dnd-api-client`, `dnd-api-contract`, `supabase-auth` (não skills `rpg-web-*` legadas).
