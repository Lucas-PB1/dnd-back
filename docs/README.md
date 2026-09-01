# Docs — dnd-api

Índice único da documentação. **Não** criar Markdown solto fora destas pastas (rule `docs-hub`).

## Pastas

| Pasta | Conteúdo |
|-------|----------|
| [`architecture/`](architecture/) | Arquitetura, infra, modelo de dados, Game BC, padrões de código |
| [`plans/`](plans/) | Backlog ativo, planos por fonte, polish adiado |
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

### Checklist único

| Doc | Para quê |
|-----|----------|
| [`plans/backlog.md`](plans/backlog.md) | **SSOT** — o que ainda falta (ativo + adiado) |

### Ativo (por fonte)

| Doc | Para quê |
|-----|----------|
| [`plans/grim-hollow-mesa-audit.md`](plans/grim-hollow-mesa-audit.md) | GH Cap. 2 mesa + Cap. 1 — residual |
| [`plans/grim-hollow-cap4-feats.md`](plans/grim-hollow-cap4-feats.md) | GH Cap. 4 — residual gunslinger/Quick Strike |
| [`plans/grim-hollow-cap6-transformations.md`](plans/grim-hollow-cap6-transformations.md) | GH Cap. 6 — ficha/mesa (catálogo feito) |
| [`plans/northlands-character-threads.md`](plans/northlands-character-threads.md) | Threads — extração + fase 2 mesa |
| [`plans/code-health-audit.md`](plans/code-health-audit.md) | Auditoria clean code / DRY / SOLID / infra |

### Referência (concluído)

| Doc | Para quê |
|-----|----------|
| [`plans/northlands-audit.md`](plans/northlands-audit.md) | Northlands — gaps opcionais residuais |
| [`plans/northlands-magic-and-miscellany.md`](plans/northlands-magic-and-miscellany.md) | Cap. 5 — extração + seeds (feito) |
| [`plans/measure-latency.md`](plans/measure-latency.md) | Medir hot paths (cursor + X-Response-Time) |

### Adiado (polish)

| Doc | Para quê |
|-----|----------|
| [`plans/mm-cast-options-modal.md`](plans/mm-cast-options-modal.md) | Modal Escudo/Giga no cast de Mísseis |
| [`plans/beast-master-primal-companion.md`](plans/beast-master-primal-companion.md) | Companheiro Primal na mesa |

Padrão de classe jogável (mesa): skills Cursor **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**.

## Ops

- Deploy → [`deploy/DEPLOY.md`](deploy/DEPLOY.md)
- Catálogo DMG (regen) → [`source/README.md`](source/README.md)
- Glossário → [`glossary/README.md`](glossary/README.md)

## Cursor (agente)

Rules locais: `architecture` · `api-contract` · `phb-data` · `file-size` · `refactor-triggers` · `docs-hub` · `class-mesa`  
Skills locais: `dnd-glossary-pt` · `rpg-catalog-model` · `phb-query-views` · `postgres-apply-catalog` · `rpg-class-mesa-api` · `audit-code-health` · `split-large-module`
