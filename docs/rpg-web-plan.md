# Referência — `dnd-front` (bootstrap)

Stack, workspace e env do frontend. **Status de entrega e próximos passos:** [`product-roadmap.md`](product-roadmap.md) (Fase 5).

**Última revisão:** 2026-07-04

---

## Repositórios

| Nome | Pasta | Papel |
|------|-------|-------|
| **dnd-api** | `dnd-work/dnd-api/` | Nest + Postgres PHB |
| **dnd-front** | `dnd-work/dnd-front/` | Next.js UI |

Workspace: `dnd-work/dnd-workspace.code-workspace`

---

## Stack

| Camada | Escolha |
|--------|---------|
| Next.js 16 + Turbopack | ✅ |
| pnpm, Tailwind v4, shadcn | ✅ |
| TanStack Query, Zod, RHF | ✅ |
| Supabase SSR (auth) | ✅ |
| HTTP client | `src/shared/api/dnd-api/` |

---

## Portas locais

| Serviço | URL |
|---------|-----|
| dnd-api | http://localhost:3000 |
| dnd-front | http://localhost:3001 |
| Swagger | http://localhost:3000/api |

---

## Princípios

1. **API calcula, front exibe** — sem regras PHB no client
2. Catálogo: `catalogFetch` (sem auth)
3. Game: `gameFetch(path, token)`

---

## Env

**dnd-front `.env.local`:**

```env
NEXT_PUBLIC_SUPABASE_URL=...
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=...
NEXT_PUBLIC_API_URL=http://localhost:3000
```

**dnd-api `.env`:** `FRONTEND_URL=http://localhost:3001`

Integração detalhada: [`../dnd-front/docs/API-INTEGRATION.md`](../dnd-front/docs/API-INTEGRATION.md)

---

## Rotas principais (front)

| Rota | Uso |
|------|-----|
| `/compendium`, `/classes`, `/species`, `/backgrounds`, `/spells` | Catálogo público |
| `/login`, `/signup` | Auth Supabase |
| `/characters`, `/characters/new`, `/characters/[id]` | Fichas (auth) |

---

## Comandos

```bash
# API
cd dnd-work/dnd-api && npm run start:dev

# Front (após mudanças: lint → test → build)
cd dnd-work/dnd-front && pnpm dev
```

Skills Cursor: `dnd-front/.cursor/skills/` · `dnd-api/.cursor/skills/`
