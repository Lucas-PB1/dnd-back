# Docs — dnd-api

Índice único da documentação. **Não** criar Markdown solto fora destas pastas (rule `docs-hub`).

## Pastas

| Pasta | Conteúdo |
|-------|----------|
| [`architecture/`](architecture/) | Arquitetura, infra, modelo de dados, Game BC, padrões de código |
| [`plans/`](plans/) | Backlog geral + acompanhamento de mecânica por classe |
| [`deploy/`](deploy/) | Deploy Vercel + Supabase |

## Arquitetura

| Doc | Para quê |
|-----|----------|
| [`architecture/architecture.md`](architecture/architecture.md) | Bounded contexts, camadas |
| [`architecture/infrastructure.md`](architecture/infrastructure.md) | Stack, env, TypeORM |
| [`architecture/data-model.md`](architecture/data-model.md) | Schema `rpg` / PHB |
| [`architecture/catalog-patterns.md`](architecture/catalog-patterns.md) | Padrões DRY SQL do catálogo |
| [`architecture/game-module-structure.md`](architecture/game-module-structure.md) | Submódulos Game |
| [`architecture/code-standards.md`](architecture/code-standards.md) | Tamanho de arquivo, SRP, DRY, legado |

Contrato REST: Swagger em `/api`.

## Planos

| Doc | Para quê |
|-----|----------|
| [`plans/backlog.md`](plans/backlog.md) | Checklist geral — o que ainda falta (API + front + gaps) |
| [`plans/class-mechanics.md`](plans/class-mechanics.md) | Mecânica por classe/subclasse (feito / parcial / pendente) |
| [`plans/code-health-plan.md`](plans/code-health-plan.md) | Inventário de arquivos gordos / hardcodes / próximos PRs |
| [`plans/combat-mechanical-catalog.md`](plans/combat-mechanical-catalog.md) | Migrar catálogos mecânicos de combate (TS → tabelas tipadas) |

## Ops

- Deploy → [`deploy/DEPLOY.md`](deploy/DEPLOY.md)

## Cursor (agente)

Rules locais: `architecture` · `api-contract` · `phb-data` · `file-size` · `refactor-triggers` · `docs-hub`  
Skills locais: `dnd-glossary-pt` · `rpg-catalog-model` · `phb-query-views` · `postgres-apply-catalog` · `audit-code-health` · `split-large-module`
