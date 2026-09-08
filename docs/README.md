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
| [`architecture/sql-layout.md`](architecture/sql-layout.md) | Schema declarative + seeds por domínio |
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
| [`architecture/adr-effect-engine.md`](architecture/adr-effect-engine.md) | Motor de efeitos (`phb_effect`) |
| [`architecture/effect-dictionary.md`](architecture/effect-dictionary.md) | Dicionário vivo de `effect_kind` |
| [`architecture/effect-engine-read-path.md`](architecture/effect-engine-read-path.md) | DX — seed → load → query → DTO (+ exemplos) |

Contrato REST: Swagger em `/api`.

## Planos

**Política:** plano **concluído = apagado**. O que falta → só [`plans/backlog.md`](plans/backlog.md).

### Checklist único

| Doc | Para quê |
|------|----------|
| [`plans/backlog.md`](plans/backlog.md) | **SSOT mesa** — aberto + polish adiado |
| [`plans/combat-real-deferred.md`](plans/combat-real-deferred.md) | **Feature futura** — combate PC×alvo (fora do backlog mesa) |
| [`plans/pvp-1v1-duel.md`](plans/pvp-1v1-duel.md) | Duelo 1v1 — F0–F4 jogável (armas, magias tipadas, arena); expansões no combate real |

### Ativo (detalhe)

| Doc | Para quê |
|------|----------|
| [`plans/effect-mesa-checklist.md`](plans/effect-mesa-checklist.md) | Checklist — **categoria** (dono/peça) |
| [`plans/effect-mesa-por-fonte.md`](plans/effect-mesa-por-fonte.md) | Matriz — **fonte** (PHB, GH, NL, DMG…) → categorias |

### Feature futura (não polish)

| Doc | Para quê |
|------|----------|
| [`plans/combat-real-deferred.md`](plans/combat-real-deferred.md) | Combate real — dano/alvo/saves/encontro; **não** priorizar no ciclo mesa |
| [`plans/pvp-1v1-duel.md`](plans/pvp-1v1-duel.md) | Duelo 1v1 PvP — F0–F4 (cast, condições, escuridão mágica); mais tipados no combate real |

### Adiado (polish)

| Doc | Para quê |
|------|----------|
| [`plans/mm-cast-options-modal.md`](plans/mm-cast-options-modal.md) | Modal Escudo/Giga no cast de Mísseis |
| [`plans/beast-master-primal-companion.md`](plans/beast-master-primal-companion.md) | Companheiro Primal na mesa |

### Referência (extract / SSOT, mesa feito)

| Doc | Para quê |
|------|----------|
| [`plans/northlands-character-threads.md`](plans/northlands-character-threads.md) | Threads NL — extração + status mesa (MVP feito) |

Padrão de classe jogável (mesa): skills **`rpg-class-mesa-api`** · **`rpg-class-mesa-front`**.

## Ops

- Deploy → [`deploy/DEPLOY.md`](deploy/DEPLOY.md)
- Latência hot paths → [`deploy/measure-latency.md`](deploy/measure-latency.md)
- Catálogo / extracts → [`source/README.md`](source/README.md)
- Glossário → [`glossary/README.md`](glossary/README.md)

## Cursor (agente)

Rules locais: `architecture` · `api-contract` · `phb-data` · `read-model-layers` · `file-size` · `refactor-triggers` · `typescript-quality` · `dry-quality` · `docs-hub` · `class-mesa`  
Skills locais: `dnd-glossary-pt` · `rpg-catalog-model` · `phb-query-views` · `postgres-apply-catalog` · `rpg-class-mesa-api` · `audit-code-health` · `split-large-module` · `unify-game-stats`
