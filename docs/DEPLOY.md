# Deploy — Vercel + Supabase

Guia para publicar **dnd-api** e **dnd-front** com Supabase já populado.

**Stack:** Supabase (Postgres + Auth) · API Nest na Vercel · Front Next na Vercel

---

## Pré-requisitos

- Projeto Supabase com schema `rpg` migrado e com seeds (`npm run db:migrate:supabase` + `npm run db:seed:supabase` no `dnd-api`)
- Conta Vercel com dois projetos (ou um monorepo com root directories distintos)
- URLs do Supabase: **Project URL** e **Publishable key** (Settings → API)

---

## 1. API (`dnd-api`)

### Vercel — configuração do projeto

| Campo | Valor |
|-------|-------|
| **Root Directory** | `dnd-api` (se o repo é `dnd-work`) |
| **Framework Preset** | Other (zero-config Nest) |
| **Install Command** | `npm ci` (já em `vercel.json`) |
| **Build Command** | `npm run build` |
| **Node.js** | 20.x |

> **Importante:** o `dnd-api` usa **npm** (`package-lock.json`). Não use pnpm neste projeto.

### Variáveis de ambiente (Production + Preview)

| Variável | Valor | Onde obter |
|----------|-------|------------|
| `DATABASE_URL` | Transaction pooler **6543** com `?pgbouncer=true` | Supabase → Settings → Database → **Transaction pooler** |
| `SUPABASE_URL` | `https://[ref].supabase.co` | Supabase → Settings → API |
| `FRONTEND_URL` | `https://seu-front.vercel.app` | URL do projeto Next (atualizar após deploy do front) |
| `NODE_ENV` | `production` | — |

**Não** use `SUPABASE_DATABASE_URL` (porta 5432) como `DATABASE_URL` na Vercel — essa URL é só para migrations locais.

Exemplo de pooler:

```env
DATABASE_URL=postgresql://postgres.[ref]:[password]@aws-0-[region].pooler.supabase.com:6543/postgres?pgbouncer=true
```

### Verificar após deploy

```bash
curl https://SUA-API.vercel.app/health
# {"status":"ok","db":"connected"}
```

Swagger: `https://SUA-API.vercel.app/api`

### Erros comuns

| Sintoma | Causa | Correção |
|---------|-------|----------|
| `FUNCTION_INVOCATION_FAILED` / 500 | `DATABASE_URL` ausente ou URL direct 5432 | Pooler 6543 + `pgbouncer=true` |
| `FUNCTION_INVOCATION_FAILED` | `SUPABASE_URL` ausente | Adicionar no dashboard Vercel |
| Build falha no install | pnpm vs npm | Usar `npm ci` (ver `vercel.json`) |
| `db: disconnected` no `/health` | Pooler errado ou migrations não aplicadas | Rodar migrations no Supabase |
| CORS no browser | `FRONTEND_URL` não bate com o domínio | Ajustar URL ou usar `*.vercel.app` (já permitido) |

### Dev local simulando Vercel

```bash
npm i -g vercel   # CLI ≥ 48.4
cd dnd-api
vercel env pull .env.local
vercel dev
```

---

## 2. Front (`dnd-front`)

### Vercel — configuração do projeto

| Campo | Valor |
|-------|-------|
| **Root Directory** | `dnd-front` |
| **Framework Preset** | Next.js |
| **Install Command** | `pnpm install` (padrão) |
| **Build Command** | `pnpm build` |

### Variáveis de ambiente

| Variável | Valor |
|----------|-------|
| `NEXT_PUBLIC_SUPABASE_URL` | Igual ao `SUPABASE_URL` da API |
| `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` | Supabase → Settings → API |
| `NEXT_PUBLIC_API_URL` | `https://SUA-API.vercel.app` |

### Supabase Auth — redirect URLs

No dashboard Supabase → Authentication → URL Configuration:

- **Site URL:** `https://seu-front.vercel.app`
- **Redirect URLs:** `https://seu-front.vercel.app/**`, `http://localhost:3001/**`

### Atualizar CORS na API

Depois do deploy do front, defina `FRONTEND_URL` na API com a URL de produção do Next e redeploy a API.

---

## 3. Ordem recomendada

```text
1. Migrations + seeds no Supabase (local, uma vez)
2. Deploy dnd-api → testar GET /health
3. Deploy dnd-front com NEXT_PUBLIC_API_URL apontando para a API
4. Ajustar FRONTEND_URL na API + redirect URLs no Supabase
5. Smoke: login → criar ficha → abrir /characters
```

---

## 4. Smoke test rápido

```bash
# API
curl -s https://SUA-API.vercel.app/health
curl -s https://SUA-API.vercel.app/classes?limit=1

# Front (browser)
# - /compendium carrega classes
# - /login funciona
# - /characters/new cria ficha (autenticado)
```

---

## Referências

- [`infrastructure.md`](infrastructure.md) — diagrama e conexões
- [`product-roadmap.md`](product-roadmap.md) — Fase 6
- Skill Cursor: `.cursor/skills/nest-vercel-deploy/`
- Vercel NestJS: https://vercel.com/docs/frameworks/backend/nestjs
