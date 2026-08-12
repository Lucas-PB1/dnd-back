# Docs — dnd-api

Índice único da documentação. **Não** criar Markdown solto fora destas pastas (rule `docs-hub`).

## Pastas

| Pasta | Conteúdo |
|-------|----------|
| [`architecture/`](architecture/) | Arquitetura, infra, modelo de dados, Game BC, padrões de código |
| [`plans/`](plans/) | Backlog ativo + polish adiado |
| [`source/`](source/) | Fontes regeneráveis do catálogo DMG (A–Z) |
| [`glossary/`](glossary/) | Glossário EN→PT (JSON) |
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
| [`architecture/dmg-item-mesa.md`](architecture/dmg-item-mesa.md) | Modelo mesa de itens DMG |
| [`architecture/treasure-rules-vs-sistema.md`](architecture/treasure-rules-vs-sistema.md) | Gaps Treasure × implementação |

Contrato REST: Swagger em `/api`.

## Planos

| Doc | Para quê |
|-----|----------|
| [`plans/backlog.md`](plans/backlog.md) | Checklist — o que ainda falta |
| [`plans/northlands-character-threads.md`](plans/northlands-character-threads.md) | Extração Character Threads — **adiado** (sistema novo) |
| [`plans/northlands-magic-and-miscellany.md`](plans/northlands-magic-and-miscellany.md) | Cap. 5 — catálogo seedado; veículos/montarias **adiados** |
| [`plans/northlands-audit.md`](plans/northlands-audit.md) | Pente fino Northlands — gaps críticos fechados; residual M6/M7 |
| [`plans/mm-cast-options-modal.md`](plans/mm-cast-options-modal.md) | Adiado: modal Escudo/Giga no cast de Mísseis |
| [`plans/beast-master-primal-companion.md`](plans/beast-master-primal-companion.md) | Adiado: Companheiro Primal na mesa |

Padrão de classe jogável (mesa): skills Cursor **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**.

## Ops

- Deploy → [`deploy/DEPLOY.md`](deploy/DEPLOY.md)
- Catálogo DMG (regen) → [`source/README.md`](source/README.md)
- Glossário → [`glossary/README.md`](glossary/README.md)

## Cursor (agente)

Rules locais: `architecture` · `api-contract` · `phb-data` · `file-size` · `refactor-triggers` · `docs-hub` · `class-mesa`  
Skills locais: `dnd-glossary-pt` · `rpg-catalog-model` · `phb-query-views` · `postgres-apply-catalog` · `rpg-class-mesa-api` · `audit-code-health` · `split-large-module`
