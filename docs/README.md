# Docs — dnd-api

Índice único da documentação. **Não** criar Markdown solto fora destas pastas (rule `docs-hub`).

## Pastas

| Pasta | Conteúdo |
|-------|----------|
| [`architecture/`](architecture/) | Arquitetura, ADRs, inventários vivos, padrões de código |
| [`plans/`](plans/) | Backlog ativo + planos **ainda abertos** / polish adiado |
| [`source/`](source/) | Fontes regeneráveis do catálogo (DMG, GH, Northlands, …) |
| [`glossary/`](glossary/) | Glossário EN→PT (JSON) |
| [`deploy/`](deploy/) | Deploy Vercel + Supabase |

## Arquitetura

| Doc | Para quê |
|-----|----------|
| [`architecture/architecture.md`](architecture/architecture.md) | Bounded contexts, camadas |
| [`architecture/infrastructure.md`](architecture/infrastructure.md) | Stack, env, TypeORM |
| [`architecture/data-model.md`](architecture/data-model.md) | Schema `rpg` / PHB |
| [`architecture/catalog-patterns.md`](architecture/catalog-patterns.md) | Padrões DRY SQL do catálogo |
| [`architecture/code-standards.md`](architecture/code-standards.md) | Tamanho, SRP, DRY, testes, barrels |
| [`architecture/game-module-structure.md`](architecture/game-module-structure.md) | Submódulos Game |
| [`architecture/dmg-item-mesa.md`](architecture/dmg-item-mesa.md) | Modelo mesa de itens DMG |
| [`architecture/treasure-rules-vs-sistema.md`](architecture/treasure-rules-vs-sistema.md) | Gaps Treasure × implementação |
| [`architecture/creature-template-field-map.md`](architecture/creature-template-field-map.md) | Campos template criatura/veículo |

### ADRs e inventários

| Doc | Para quê |
|------|----------|
| [`architecture/adr-schema-consolidation.md`](architecture/adr-schema-consolidation.md) | Consolidação A→G (Aceito) |
| [`architecture/schema-equivalence-map.md`](architecture/schema-equivalence-map.md) | Mapa histórico tabela → alvo (lotes DONE) |
| [`architecture/adr-sheet-validation-layers.md`](architecture/adr-sheet-validation-layers.md) | Validators ficha vs `infrastructure/queries` |
| [`architecture/adr-read-model-layers.md`](architecture/adr-read-model-layers.md) | View vs MV vs RPC JSONB |
| [`architecture/read-model-inventory.md`](architecture/read-model-inventory.md) | Lista objetiva — tabela / view / MV / RPC |
| [`architecture/adr-heritage-vs-species.md`](architecture/adr-heritage-vs-species.md) | Heritage GH vs species PHB |

Contrato REST: Swagger em `/api`.

## Planos

**Política:** plano **concluído = apagado**. O que falta → só [`plans/backlog.md`](plans/backlog.md).

### Checklist único

| Doc | Para quê |
|------|----------|
| [`plans/backlog.md`](plans/backlog.md) | **SSOT** — aberto + adiado |

### Ativo (detalhe)

| Doc | Para quê |
|------|----------|
| [`plans/grim-hollow-mesa-audit.md`](plans/grim-hollow-mesa-audit.md) | GH Cap. 2 mesa + Cap. 1 — residual |
| [`plans/grim-hollow-cap6-transformations.md`](plans/grim-hollow-cap6-transformations.md) | GH Cap. 6 — ficha/mesa |
| [`plans/northlands-character-threads.md`](plans/northlands-character-threads.md) | Threads — extração + fase 2 mesa |
| [`plans/northlands-audit.md`](plans/northlands-audit.md) | Northlands — gaps opcionais |

### Adiado (polish)

| Doc | Para quê |
|------|----------|
| [`plans/hard-files-checklist.md`](plans/hard-files-checklist.md) | Inventário hard >200 + pastas >4 (qualidade) |
| [`plans/mm-cast-options-modal.md`](plans/mm-cast-options-modal.md) | Modal Escudo/Giga no cast de Mísseis |
| [`plans/beast-master-primal-companion.md`](plans/beast-master-primal-companion.md) | Companheiro Primal na mesa |

Padrão de classe jogável (mesa): skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**.

## Ops

- Deploy → [`deploy/DEPLOY.md`](deploy/DEPLOY.md)
- Latência hot paths → [`deploy/measure-latency.md`](deploy/measure-latency.md)
- Catálogo / extracts → [`source/README.md`](source/README.md)
- Glossário → [`glossary/README.md`](glossary/README.md)

## Cursor (agente)

Rules locais: `architecture` · `api-contract` · `phb-data` · `read-model-layers` · `file-size` · `refactor-triggers` · `typescript-quality` · `dry-quality` · `docs-hub` · `class-mesa`  
Skills locais: `dnd-glossary-pt` · `rpg-catalog-model` · `phb-query-views` · `postgres-apply-catalog` · `rpg-class-mesa-api` · `audit-code-health` · `split-large-module` · `unify-game-stats`
