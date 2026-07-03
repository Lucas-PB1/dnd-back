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
│   └── data-model.md        # clusters, FKs, views
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
PORT=3000
```

Endpoints piloto:

- `GET /classes` — lista classes (`rpg.v_phb_class`)
- `GET /classes/:slug` — detalhe por slug

## Stack

| Camada | Tecnologia |
|--------|------------|
| Dados | PostgreSQL 15+, schema `rpg` |
| Hosting DB | Supabase (transaction pooler, porta 6543) |
| API | NestJS + TypeORM |
| Deploy API | Vercel (zero-config Nest, Fluid compute) |

## Cursor — rules e skills

| Tipo | Onde | Uso |
|------|------|-----|
| Rules | `.cursor/rules/*.mdc` | Padrões SQL, Nest, TypeORM, Vercel |
| Skills | `.cursor/skills/*/SKILL.md` | Workflows detalhados |
| Referências | `.cursor/skills/*/references/` | Specs por tema |

Orquestrador: `.cursor/rules/00-orchestrator.mdc`

Modelo de dados: [`docs/data-model.md`](docs/data-model.md)
