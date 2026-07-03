# RPG — Catálogo PHB 2024

Massa de dados PostgreSQL do **Player's Handbook 2024 (PT-BR)** + API NestJS read-only.

## O que é

- **`database/`** — schema, migrations granulares e seeds prontos (391 magias, 12 classes, 48 subclasses, …)
- **`src/`** — API NestJS + TypeORM consumindo o catálogo via views
- **Deploy alvo:** Supabase (Postgres) + Vercel (Nest serverless)

Contagens: [`database/seed-manifest.json`](database/seed-manifest.json)

## Estrutura

```
rpg/
├── database/
│   ├── schema.sql           # DDL completo
│   ├── dev-reset.sql        # DROP SCHEMA (só dev)
│   ├── migrations/          # 84 arquivos granulares
│   └── seeds/               # 66 arquivos (PHB + subclass)
├── docs/
│   ├── data-model.md        # clusters, FKs, views
│   ├── infrastructure.md    # stack Supabase + Vercel
│   ├── architecture.md      # bounded contexts, CQRS, DDD
│   └── api-plan.md          # checklist REST, Swagger, testes
├── src/                     # NestJS API
├── .cursor/
│   ├── rules/               # regras por contexto
│   └── skills/              # workflows + references/
└── package.json
```

## Banco de dados

Aplicar catálogo (dev):

```powershell
psql $env:DATABASE_URL -f database/dev-reset.sql
Get-ChildItem database/migrations -Recurse -Filter *.sql | Sort-Object FullName | ForEach-Object { psql $env:DATABASE_URL -f $_.FullName }
Get-ChildItem database/seeds -Recurse -Filter *.sql | Sort-Object FullName | ForEach-Object { psql $env:DATABASE_URL -f $_.FullName }
```

Detalhes: [`database/migrations/README.md`](database/migrations/README.md)

## API (NestJS)

```bash
npm install
npm run start:dev          # desenvolvimento local
npm run vercel:dev         # simula runtime Vercel
```

Variáveis (`.env`):

```
DATABASE_URL=postgresql://...:6543/postgres?pgbouncer=true
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_JWT_SECRET=
FRONTEND_URL=http://localhost:3001
PORT=3000
```

Endpoints piloto:

- `GET /classes` — lista classes (`rpg.v_phb_class`)
- `GET /classes/:slug` — detalhe por slug

## Stack (decisão de infra)

Documento completo: [`docs/infrastructure.md`](docs/infrastructure.md) · Arquitetura: [`docs/architecture.md`](docs/architecture.md)

| Camada | Tecnologia |
|--------|------------|
| Dados | PostgreSQL 15+, schema `rpg` |
| DB + Auth | **Supabase** (pooler 6543, Supabase Auth, RLS futuro) |
| API | NestJS + TypeORM — **modular monolith**, 3 bounded contexts |
| Padrão | CQRS leve (views = read); DDD tático só em `game/` |
| Deploy API | **Vercel** (serverless Nest) |
| Frontend | **Next.js em repo separado** |

## Cursor — rules e skills

| Tipo | Onde | Uso |
|------|------|-----|
| Rules | `.cursor/rules/*.mdc` | SQL, Nest, Supabase, Auth, Vercel, contrato API |
| Skills | `.cursor/skills/*/SKILL.md` | Workflows detalhados |
| Referências | `.cursor/skills/*/references/` | Specs por tema |
| Infra | [`docs/infrastructure.md`](docs/infrastructure.md) | Stack Supabase + Vercel |
| Arquitetura | [`docs/architecture.md`](docs/architecture.md) | BC, CQRS, DDD |
| **Plano API** | [`docs/api-plan.md`](docs/api-plan.md) | Módulos, rotas, Swagger, testes |

Orquestrador: `.cursor/rules/00-orchestrator.mdc`

Modelo de dados: [`docs/data-model.md`](docs/data-model.md)
