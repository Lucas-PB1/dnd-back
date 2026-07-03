# Infraestrutura — decisão

Documento de referência para rules, skills e implementação.

**Arquitetura (BC, CQRS, DDD):** [`architecture.md`](architecture.md)

**Plano REST API (checklist mestre):** [`api-plan.md`](api-plan.md)

## Decisão (2026-07)

| Camada | Escolha | Motivo |
|--------|---------|--------|
| **Banco** | Supabase (Postgres) | Catálogo PHB + Auth + RLS para fichas futuras |
| **API** | NestJS na Vercel | Serverless, zero-config Nest, escala por request |
| **ORM** | TypeORM | Mapeamento `rpg.phb_*`, views, `synchronize: false` |
| **Auth** | Supabase Auth | JWT; RLS no Postgres para dados de jogador |
| **Frontend** | Next.js em **repo separado** | Este repo = SQL + API apenas |

## Diagrama

```mermaid
flowchart LR
  subgraph client [Repo frontend]
    Next[Next.js]
  end

  subgraph vercel [Vercel]
    Nest[NestJS API]
  end

  subgraph supabase [Supabase]
    PG[(Postgres rpg)]
    Auth[Supabase Auth]
  end

  Next -->|HTTPS + JWT| Nest
  Next -->|login signup| Auth
  Nest -->|pooler 6543| PG
  Auth -->|JWT claims| Nest
  PG -->|RLS auth.uid| PG
```

## Repositórios

| Repo | Conteúdo |
|------|----------|
| **rpg** (este) | `database/`, `src/` Nest, `.cursor/` |
| **rpg-web** (futuro) | Next.js, consome API, Supabase Auth client-side |

## Conexões

### Nest → Postgres (Supabase)

- **Produção / Vercel:** transaction pooler, porta **6543**, `?pgbouncer=true` → `DATABASE_URL`
- **Migrations / seeds:** conexão **direct** porta **5432** → `SUPABASE_DATABASE_URL`
- **Dev local:** `DATABASE_URL` aponta para Postgres local; API continua local enquanto migrations podem ir também ao Supabase
- TypeORM: `synchronize: false`, pool `max: 1` em prod serverless, SSL automático se URL contiver `supabase`

### Scripts de banco (`npm run db:*`)

| Comando | O que faz |
|---------|-----------|
| `db:migrate` | Migrations pendentes em `DATABASE_URL` (local) |
| `db:migrate:supabase` | Migrations pendentes só no Supabase |
| `db:migrate:all` | Local **e** Supabase (incremental, rastreia `rpg.schema_migration`) |
| `db:seed` / `db:seed:all` | Seeds PHB (após reset ou banco vazio) |
| `db:reset` | `dev-reset.sql` — **só local**, nunca Supabase |
| `db:setup` | reset + migrate + seed local |
| `db:setup:all` | setup local + migrate + seed no Supabase (primeira carga remota) |

### Nest → Supabase Auth

- Validar JWT do header `Authorization: Bearer <token>`
- **JWKS** (`SUPABASE_URL/auth/v1/.well-known/jwks.json`) — tokens ES256 do Supabase Auth
- Rotas catálogo `phb_*`: **públicas** (sem auth)
- Rotas jogador (fase futura): guard JWT + RLS com `auth.uid()`

### Frontend → API

- CORS: `FRONTEND_URL` no Nest (domínio do Next na Vercel)
- Contrato: JSON, slugs na URL, sem expor `id` BIGINT
- Auth: Next usa `@supabase/supabase-js`; API valida mesmo JWT

## Ambientes

| Ambiente | API | DB | Auth |
|----------|-----|-----|------|
| Local | `nest start --watch` :3000 | Postgres local ou Supabase dev | Supabase project dev |
| Preview | Vercel preview URL | Supabase (branch ou dev) | Supabase dev |
| Prod | Vercel production | Supabase prod | Supabase prod |

## Variáveis (API — Vercel)

```
DATABASE_URL=postgresql://...@...pooler.supabase.com:6543/postgres?pgbouncer=true
SUPABASE_DATABASE_URL=postgresql://postgres.[ref]:[pass]@db.[ref].supabase.co:5432/postgres
SUPABASE_URL=https://xxx.supabase.co
FRONTEND_URL=https://seu-app.vercel.app
NODE_ENV=production
PORT=3000
```

## Fases

| Fase | Escopo |
|------|--------|
| **Atual** | Catálogo read-only (`GET /classes`, …), sem auth |
| **Próxima** | Supabase Auth guard, RLS em tabelas de jogador |
| **Depois** | Repo Next.js consumindo API + login Supabase |

## Rules / skills derivadas

Ver [`README.md`](../README.md#cursor--rules-e-skills) e `.cursor/rules/00-orchestrator.mdc`.

| Tema | Rule | Skill |
|------|------|-------|
| Infra geral | `00-orchestrator` | — |
| Postgres catálogo | `postgres-sql`, `phb-data-model` | `postgres-apply-catalog`, `rpg-catalog-model` |
| Supabase DB | `supabase-sql` | `supabase-connection` |
| Supabase Auth | `supabase-auth` | `supabase-auth` |
| API Vercel | `nestjs-vercel` | `nest-vercel-deploy` |
| Nest + TypeORM | `nestjs-core`, `nestjs-typeorm` | `typeorm-rpg-entities`, `nest-phb-api` |
| Contrato frontend | `api-contract` | `api-consumer-next` |
| **Arquitetura / BC** | `bounded-contexts`, `catalog-thin-layer`, `game-domain` | `nestjs-bounded-context`, `cqrs-catalog-vs-game` |
