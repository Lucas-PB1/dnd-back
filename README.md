# dnd-api — Catálogo PHB 2024 + API NestJS

Massa de dados PostgreSQL do **Player's Handbook 2024 (PT-BR)** + API NestJS.

Frontend irmão: **dnd-front** (Next.js) — ver [`docs/rpg-web-plan.md`](docs/rpg-web-plan.md).

## O que é

- **`database/`** — schema, migrations granulares e seeds prontos (391 magias, 12 classes, 48 subclasses, …)
- **`src/`** — API NestJS + TypeORM consumindo o catálogo via views
- **Deploy alvo:** Supabase (Postgres) + Vercel (Nest serverless)

Contagens: [`database/seed-manifest.json`](database/seed-manifest.json)

## Estrutura

```
dnd-work/dnd-api/             # este repo
├── database/
│   ├── schema.sql           # DDL completo
│   ├── dev-reset.sql        # DROP SCHEMA (só dev)
│   ├── migrations/          # 84 arquivos granulares
│   └── seeds/               # 66 arquivos (PHB + subclass)
├── docs/
│   ├── data-model.md        # clusters, FKs, views
│   ├── infrastructure.md    # stack Supabase + Vercel
│   ├── architecture.md      # bounded contexts, CQRS, DDD
│   ├── api-plan.md          # checklist REST, Swagger, testes
│   └── product-roadmap.md   # marcos API + app Next.js
├── src/                     # NestJS API
├── .cursor/
│   ├── rules/               # regras por contexto
│   └── skills/              # workflows + references/
└── package.json
```

## Banco de dados

Dev local (reset completo):

```bash
npm run db:setup
```

Migrations incrementais (local + Supabase):

```bash
# .env: DATABASE_URL (local) + SUPABASE_DATABASE_URL (direct 5432)
npm run db:migrate:all
```

Primeira carga no Supabase (após configurar `SUPABASE_DATABASE_URL`):

```bash
npm run db:migrate:supabase
npm run db:seed:supabase
```

Detalhes: [`database/migrations/README.md`](database/migrations/README.md) · [`docs/infrastructure.md`](docs/infrastructure.md)

## API (NestJS)

```bash
npm install
npm run start:dev          # desenvolvimento local
npm run vercel:dev         # simula runtime Vercel
npm test                   # unit tests
npm run test:e2e           # E2E (requer DATABASE_URL + catálogo aplicado)
```

Swagger (dev): **http://localhost:3000/api**

Variáveis (`.env`):

```
DATABASE_URL=postgresql://...:6543/postgres?pgbouncer=true
SUPABASE_URL=https://xxx.supabase.co
FRONTEND_URL=http://localhost:3001
PORT=3000
```

Endpoints (catálogo P0):

| Rota | Descrição |
|------|-----------|
| `GET /health` | Status da API e conexão DB |
| `GET /classes` | Lista classes (paginado: `{ data, meta }`) |
| `GET /classes/:slug` | Detalhe por slug (ex.: `fighter`) |
| `GET /classes/:slug/subclasses` | Subclasses da classe (paginado) |
| `GET /classes/:slug/spells` | Magias da classe (`?maxLevel=0–9`) |
| `GET /classes/:slug/spell-slots` | Tabela de slots por nível |
| `GET /classes/:slug/equipment` | Equipamento inicial da classe |
| `GET /spells` | Lista de magias (paginado, 391+) |
| `GET /spells/:slug` | Detalhe da magia (ex.: `alarme`) |
| `GET /backgrounds/:slug/equipment` | Equipamento inicial do antecedente |
| `GET /feats`, `/feats/:slug` | Talentos PHB |
| `GET /skills`, `/skills/:slug` | Perícias + atributo |
| `GET /abilities` | Atributos (FOR, DES, …) |
| `GET /weapons`, `/weapons/:slug` | Armas |
| `GET /armor`, `/armor/:slug` | Armaduras |
| `GET /classes/:slug/skills` | Pool de perícias da classe |
| `GET /species/:slug/traits` | Traços raciais |
| `GET /species/:slug/trait-choices` | Opções de linhagem/ancestralidade |
| `GET /alignments` | Tendências (9 alinhamentos) |
| `GET /languages` | Idiomas PHB |
| `GET /character-levels` | Nível, PB e XP (1–20) |

### Game (requer auth)

Header: `Authorization: Bearer <supabase_access_token>`

| Rota | Descrição |
|------|-----------|
| `GET /characters` | Lista fichas do usuário |
| `GET /characters/:id` | Detalhe da ficha (UUID) |
| `POST /characters` | Criar ficha (valida slugs PHB) |
| `PATCH /characters/:id` | Atualizar ficha |
| `DELETE /characters/:id` | Remover ficha |
| `GET /species` | Lista espécies (paginado) |
| `GET /species/:slug` | Detalhe por slug (ex.: `dwarf`) |
| `GET /backgrounds` | Lista antecedentes (paginado) |
| `GET /backgrounds/:slug` | Detalhe por slug (ex.: `acolyte`) |

Query de paginação: `?page=1&limit=20` (default 20, max 100). Slugs em **inglês** (como no seed).

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
