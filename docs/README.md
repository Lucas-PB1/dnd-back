# Docs — dnd-api

Índice único da documentação. **Não** criar Markdown solto fora destas pastas (rule `docs-hub`).

## Pastas

| Pasta | Conteúdo |
|-------|----------|
| [`architecture/`](architecture/) | Arquitetura, infra, modelo de dados, Game BC, padrões de código |
| [`plans/`](plans/) | **Plano ativo:** [`backlog.md`](plans/backlog.md) |
| [`deploy/`](deploy/) | Deploy Vercel + Supabase |
| [`sources/`](sources/) | Fontes de conteúdo (ex.: Valda) para ingestão no catálogo |

## Arquitetura

| Doc | Para quê |
|-----|----------|
| [`architecture/architecture.md`](architecture/architecture.md) | Bounded contexts, camadas |
| [`architecture/infrastructure.md`](architecture/infrastructure.md) | Stack, env, TypeORM |
| [`architecture/data-model.md`](architecture/data-model.md) | Schema `rpg` / PHB |
| [`architecture/catalog-patterns.md`](architecture/catalog-patterns.md) | Padrões DRY SQL do catálogo |
| [`architecture/game-module-structure.md`](architecture/game-module-structure.md) | Submódulos Game |
| [`architecture/code-standards.md`](architecture/code-standards.md) | Tamanho de arquivo, SRP, DRY, legado |

Contrato REST: Swagger em `/api` · `npm run openapi:export`.

## Planos

| Doc | Para quê |
|-----|----------|
| [`plans/backlog.md`](plans/backlog.md) | **Único checklist ativo** — o que ainda falta (API + front + gaps PHB) |

## Ops / fontes

- Deploy → [`deploy/DEPLOY.md`](deploy/DEPLOY.md)
- Fontes → [`sources/README.md`](sources/README.md)
- Valda Spire → [`sources/valda-spire-of-secrets/`](sources/valda-spire-of-secrets/)
- Valda Gunslinger → [`sources/valda-gunslinger/`](sources/valda-gunslinger/)

## Cursor (agente)

Rules locais: `architecture` · `api-contract` · `phb-data` · `file-size` · `refactor-triggers` · `docs-hub`  
Skills locais: `dnd-glossary-pt` · `rpg-catalog-model` · `phb-query-views` · `postgres-apply-catalog` · `audit-code-health` · `split-large-module`
