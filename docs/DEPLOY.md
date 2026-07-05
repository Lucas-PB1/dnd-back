# Deploy — Vercel + Supabase

Guia para publicar **dnd-api** e **dnd-front** com Supabase já populado.

**Stack:** Supabase (Postgres + Auth) · API Nest na Vercel · Front Next na Vercel

---

## Como a Vercel executa NestJS (zero-config)

Fontes: [NestJS on Vercel](https://vercel.com/docs/frameworks/backend/nestjs) · [Ship a NestJS app](https://vercel.com/kb/guide/ship-a-nestjs-app-on-vercel) · [Changelog out/2025](https://vercel.com/changelog/zero-configuration-support-for-nestjs)

| O quê | Comportamento |
|-------|----------------|
| **Detecção** | Vercel procura `src/main.ts` (ou `app` / `index` / `server`) |
| **Runtime** | O app inteiro vira **uma Vercel Function** (Fluid compute) |
| **Entrypoint** | `bootstrap()` + `await app.listen(process.env.PORT ?? 3000)` — **não alterar** |
| **Build** | Automático — **não** definir `outputDirectory` (`public`, `dist`) |
| **Framework** | Preset **NestJS** — **não** usar `framework: null` nem "Other" |
| **CLI mínima** | Vercel CLI **≥ 48.4** |

```mermaid
flowchart LR
  subgraph git [Git push]
    Repo[dnd-api]
  end

  subgraph vercel [Vercel]
    Detect[Detecta NestJS]
    Build[Build + bundle]
    Fn[Uma serverless function]
  end

  subgraph runtime [Request]
    HTTP[GET /health]
    Nest[src/main.ts → AppModule]
  end

  Repo --> Detect --> Build --> Fn
  HTTP --> Fn --> Nest
```

### O que **não** fazer

| Erro | Sintoma |
|------|---------|
| `framework: null` ou Preset "Other" | Build procura pasta `public` |
| `outputDirectory: dist` ou `public` | Mesmo erro ou function quebrada |
| Dependência **ESM-only** com `require()` | `ERR_REQUIRE_ESM` (ex.: `jose@6`, `jwks-rsa@4`) |
| `DATABASE_URL` direct 5432 na Vercel | `[TypeOrmModule] Unable to connect` |
| `packageManager: pnpm` sem `pnpm-lock` | `node_modules` incorreto |

### JWT / dependências neste projeto

A API **não usa `jose` nem `jwks-rsa`**. Auth Supabase:

- `fetch` → JWKS (`/auth/v1/.well-known/jwks.json`)
- `crypto.createPublicKey` (JWK → chave)
- `jsonwebtoken.verify` (CJS, compatível com bundle Vercel)

Isso evita `ERR_REQUIRE_ESM` documentado em [jwks-rsa#507](https://github.com/auth0/node-jwks-rsa/issues/507).

---

## Pré-requisitos

- Schema `rpg` migrado + seeds no Supabase (`npm run db:migrate:supabase` + `npm run db:seed:supabase`)
- Conta Vercel · CLI ≥ 48.4 (`npm i -g vercel` ou `devDependency` no projeto)
- Supabase: Project URL + Publishable key

---

## 1. API (`dnd-api`)

### Vercel — configuração do projeto

| Campo | Valor |
|-------|-------|
| **Root Directory** | `dnd-api` (monorepo `dnd-work`) |
| **Framework Preset** | **NestJS** |
| **Output Directory** | *(vazio)* |
| **Build Command** | *(vazio — detecção automática)* |
| **Install Command** | `npm ci` (`vercel.json`) |
| **Node.js** | 20.x |

`vercel.json` mínimo:

```json
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "installCommand": "npm ci",
  "regions": ["gru1"]
}
```

### Variáveis de ambiente (Production + Preview)

| Variável | Obrigatória | Valor |
|----------|-------------|-------|
| `DATABASE_URL` | Sim | Transaction pooler **6543** + `?pgbouncer=true` |
| `SUPABASE_URL` | Sim (auth) | `https://[ref].supabase.co` |
| `FRONTEND_URL` | Recomendado | URL do front (CORS) |
| `NODE_ENV` | Sim | `production` |

Exemplo pooler (usuário `postgres.[ref]`, não só `postgres`):

```env
DATABASE_URL=postgresql://postgres.[ref]:[password]@aws-0-[region].pooler.supabase.com:6543/postgres?pgbouncer=true
```

Senha com caracteres especiais → **URL-encode**. A API adiciona `sslmode=require` automaticamente.

**Não** use `SUPABASE_DATABASE_URL` (5432) como `DATABASE_URL` na Vercel.

---

## 2. Testar localmente (obrigatório antes do deploy)

### A) Dev normal

```bash
cd dnd-api
npm run start:dev
npm run smoke:health
```

### B) Simular `VERCEL=1` + produção

```powershell
npm run build
$env:VERCEL = "1"
$env:NODE_ENV = "production"
$env:DATABASE_URL = "postgresql://postgres.[ref]:...@....pooler.supabase.com:6543/postgres?pgbouncer=true"
$env:SUPABASE_URL = "https://[ref].supabase.co"
node dist/main.js
# outro terminal:
npm run smoke:health
```

Logs esperados: `[database] connecting host=....pooler.... port=6543 pooler=true`

### C) `vercel dev` — runtime idêntico à Vercel (recomendado)

```bash
cd dnd-api
npm install

# 1ª vez: linkar projeto (interativo)
npx vercel link

# Puxar env do dashboard (opcional)
npx vercel env pull .env.vercel.local

# Garantir DATABASE_URL no .env ou .env.vercel.local
npm run vercel:dev
# → http://localhost:3000

# outro terminal:
npm run smoke:health
```

**Smoke automatizado** (sobe `vercel dev`, testa `/health`, encerra):

```bash
npm run vercel:smoke
```

Requisitos: `.env` com `DATABASE_URL` válido; projeto linkado ou `vercel link` feito.

### D) Após deploy

```bash
npm run smoke:health -- https://sua-api.vercel.app
curl https://sua-api.vercel.app/classes?limit=1
```

---

## 3. Erros comuns

| Sintoma | Causa | Correção |
|---------|-------|----------|
| `No Output Directory named 'public'` | Preset Other / `framework: null` | Preset **NestJS**, Output vazio |
| `ERR_REQUIRE_ESM` + `jose` / `jwks-rsa` | Bundle CJS + pacote ESM | Stack atual: `jsonwebtoken` + `fetch` JWKS (sem `jose`) |
| `The server does not support SSL` (teste local) | `VERCEL=1` + Postgres local | SSL só em URLs Supabase; use pooler 6543 na Vercel real |
| `[TypeOrmModule] Unable to connect` | Pooler errado / senha / migrations | 6543, `postgres.[ref]`, encode, migrations Supabase |
| `FUNCTION_INVOCATION_FAILED` | Boot falhou (env ou DB) | Logs → `[bootstrap] failed` ou `[database]` |
| `db: disconnected` em `/health` | DB inacessível | Mesmo que acima |

---

## 4. Front (`dnd-front`)

| Variável | Valor |
|----------|-------|
| `NEXT_PUBLIC_SUPABASE_URL` | = `SUPABASE_URL` |
| `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY` | Supabase → API |
| `NEXT_PUBLIC_API_URL` | `https://sua-api.vercel.app` |

Root Directory: `dnd-front` · Framework: **Next.js**

Detalhes: [`dnd-front/docs/DEPLOY.md`](../../dnd-front/docs/DEPLOY.md)

---

## 5. Ordem de deploy

```text
1. Migrations + seeds Supabase
2. npm run vercel:smoke  (local)
3. Deploy API → smoke /health
4. Deploy front → NEXT_PUBLIC_API_URL
5. FRONTEND_URL na API + redirect URLs Supabase Auth
```

---

## Referências

- [NestJS on Vercel](https://vercel.com/docs/frameworks/backend/nestjs)
- [infrastructure.md](infrastructure.md)
- Skill: `.cursor/skills/nest-vercel-deploy/`
