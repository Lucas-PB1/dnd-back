---
name: api-consumer-next
description: Contrato entre API Nest (este repo) e frontend Next.js separado — CORS, slugs, JWT, env vars. Use quando documentar integração frontend ou configurar CORS/FRONTEND_URL.
---

# API ↔ Next.js (repo separado)

Este repo **não** contém Next.js. Ver [`docs/infrastructure.md`](../../../docs/infrastructure.md).

## Referências

- [`cors-setup.md`](references/cors-setup.md)
- [`api-endpoints.md`](references/api-endpoints.md)
- [`frontend-env.md`](references/frontend-env.md)

## Contrato

- Base URL prod: `https://rpg-api.vercel.app` (exemplo)
- Recursos por slug: `/classes/:slug`, `/spells/:slug`
- Auth: Supabase no Next; Bearer token nas rotas protegidas (futuro)
- Catálogo: fetch sem auth
