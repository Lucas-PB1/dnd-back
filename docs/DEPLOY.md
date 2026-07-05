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
| **Framework Preset** | **NestJS** (detecção automática — não use "Other") |
| **Output Directory** | **vazio** (não `public`, não `dist`) |
| **Install Command** | `npm ci` (já em `vercel.json`) |
| **Build Command** | *(deixar em branco — Vercel detecta `src/main.ts`)* |
| **Node.js** | 20.x |

> **Importante:** o `dnd-api` usa **npm** (`package-lock.json`). Não use pnpm neste projeto.  
> **Não** coloque `"framework": null` no `vercel.json` — isso faz a Vercel procurar pasta `public` e o build falha.

### Variáveis de ambiente (Production + Preview)

| Variável | Valor | Onde obter |
|----------|-------|------------|
| `DATABASE_URL` | Transaction pooler **6543** com `?pgbouncer=true` | Supabase → Settings → Database → **Transaction pooler** |
| `SUPABASE_URL` | `https://[ref].supabase.co` | Supabase → Settings → API |
| `FRONTEND_URL` | `https://seu-front.vercel.app` | URL do projeto Next (atualizar após deploy do front) |
| `NODE_ENV` | `production` | — |

**Não** use `SUPABASE_DATABASE_URL` (porta 5432) como `DATABASE_URL` na Vercel — essa URL é só para migrations locais.

Exemplo de pooler (note o usuário `postgres.[ref]` — não só `postgres`):

```env
DATABASE_URL=postgresql://postgres.[ref]:[password]@aws-0-[region].pooler.supabase.com:6543/postgres?pgbouncer=true
```

Se a senha tiver caracteres especiais (`@`, `#`, `'`, etc.), use **URL encoding** na connection string.

A API adiciona automaticamente `sslmode=require` e `pgbouncer=true` quando detecta Supabase pooler.

### Verificar após deploy

```bash
curl https://SUA-API.vercel.app/health
# {"status":"ok","db":"connected"}
```

Swagger: `https://SUA-API.vercel.app/api`

### Erros comuns

| Sintoma | Causa | Correção |
|---------|-------|----------|
| `No Output Directory named 'public' found` | Framework = Other / `framework: null` | Preset **NestJS**; Output Directory vazio; ver `vercel.json` |
| `FUNCTION_INVOCATION_FAILED` / 500 | `DATABASE_URL` ausente ou URL direct 5432 | Pooler 6543 + `pgbouncer=true` |
| `ERR_REQUIRE_ESM` + `jwks-rsa` / `jose/dist/webapi` | `jwks-rsa@4` puxa `jose@6` (ESM); Vercel CJS não suporta | **Não usar `jwks-rsa`** — API usa `jose@5.10.0` direto + `overrides` no `package.json` |
| `[TypeOrmModule] Unable to connect to the database` | `DATABASE_URL` errada ou senha sem URL-encode | Pooler 6543, user `postgres.[ref]`, ver logs `[database]` |
| `FUNCTION_INVOCATION_FAILED` | `SUPABASE_URL` ausente | Adicionar no dashboard Vercel |
| Build falha no install | pnpm vs npm | Usar `npm ci` (ver `vercel.json`) |
| `db: disconnected` no `/health` | Pooler errado ou migrations não aplicadas | Rodar migrations no Supabase |
| CORS no browser | `FRONTEND_URL` não bate com o domínio | Ajustar URL ou usar `*.vercel.app` (já permitido) |

### Testar localmente (antes do deploy)

Há três níveis — do mais rápido ao mais fiel à Vercel:

#### A) Desenvolvimento normal

```bash
cd dnd-api
npm run start:dev
npm run smoke:health
# GET http://localhost:3000/health → {"status":"ok","db":"connected"}
```

Usa `DATABASE_URL` do `.env` (Postgres local ou pooler Supabase).

#### B) Simular produção (sem Vercel CLI)

Útil para validar env de produção e conexão com pooler:

```bash
cd dnd-api
npm run build

# PowerShell — cole a DATABASE_URL do pooler Supabase (6543)
$env:VERCEL = "1"
$env:NODE_ENV = "production"
$env:DATABASE_URL = "postgresql://postgres.[ref]:[senha]@....pooler.supabase.com:6543/postgres?pgbouncer=true"
$env:SUPABASE_URL = "https://[ref].supabase.co"
$env:FRONTEND_URL = "http://localhost:3001"
node dist/main.js
```

Em outro terminal:

```bash
npm run smoke:health
# ou: npm run smoke:health -- https://sua-api.vercel.app
```

Nos logs deve aparecer `[database] connecting host=....pooler.supabase.com port=6543 pooler=true`.

#### C) Runtime idêntico à Vercel (`vercel dev`)

```bash
npm i -g vercel   # CLI ≥ 48.4
cd dnd-api
vercel link       # primeira vez
vercel env pull .env.vercel.local
# Confira DATABASE_URL (pooler 6543) em .env.vercel.local
vercel dev
npm run smoke:health
```

Referência: [jwks-rsa #507](https://github.com/auth0/node-jwks-rsa/issues/507) — `jwks-rsa@4` + `jose@6` quebra em CJS; por isso usamos **`jose@5.10.0` fixo** (campo `overrides` no `package.json`).

### Dev local simulando Vercel (resumo)

Ver seção **B** ou **C** acima. O atalho `npm run vercel:dev` equivale a `vercel dev`.

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
