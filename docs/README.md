# Docs — dnd-api

Índice único da documentação. **Não** criar Markdown solto fora destas pastas (rule `docs-hub`).

## Pastas

| Pasta | Conteúdo |
|-------|----------|
| [`architecture/`](architecture/) | Arquitetura, infra, modelo de dados, Game BC, padrões de código |
| [`plans/`](plans/) | Backlog ativo |
| [`deploy/`](deploy/) | Deploy Vercel + Supabase |

## Arquitetura

| Doc | Para quê |
|-----|----------|
| [`architecture/architecture.md`](architecture/architecture.md) | Bounded contexts, camadas |
| [`architecture/infrastructure.md`](architecture/infrastructure.md) | Stack, env, TypeORM |
| [`architecture/data-model.md`](architecture/data-model.md) | Schema `rpg` / PHB |
| [`architecture/catalog-patterns.md`](architecture/catalog-patterns.md) | Padrões DRY SQL do catálogo (+ catálogo mecânico) |
| [`architecture/adr-schema-consolidation.md`](architecture/adr-schema-consolidation.md) | ADR — consolidação A→G (Aceito) |
| [`architecture/schema-equivalence-map.md`](architecture/schema-equivalence-map.md) | Mapa tabela atual → alvo consolidado |
| [`architecture/game-module-structure.md`](architecture/game-module-structure.md) | Submódulos Game |
| [`architecture/code-standards.md`](architecture/code-standards.md) | Tamanho de arquivo, SRP, DRY, legado |

Contrato REST: Swagger em `/api`.

## Planos

| Doc | Para quê |
|-----|----------|
| [`plans/backlog.md`](plans/backlog.md) | Checklist geral — o que ainda falta (API + front + gaps) |
| [`plans/mm-cast-options-modal.md`](plans/mm-cast-options-modal.md) | Adiado: modal Escudo/Giga no cast de Mísseis |

Padrão de classe jogável (mesa): skills Cursor **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**.

## Ops

- Deploy → [`deploy/DEPLOY.md`](deploy/DEPLOY.md)

## Cursor (agente)

Rules locais: `architecture` · `api-contract` · `phb-data` · `file-size` · `refactor-triggers` · `docs-hub` · `class-mesa`  
Skills locais: `dnd-glossary-pt` · `rpg-catalog-model` · `phb-query-views` · `postgres-apply-catalog` · `rpg-class-mesa-api` · `audit-code-health` · `split-large-module`
