# Docs — dnd-api

Índice único da documentação. **Não** criar Markdown solto fora destas pastas (rule `docs-hub`).

## Pastas

| Pasta | Conteúdo |
|-------|----------|
| [`architecture/`](architecture/) | Arquitetura, infra, modelo de dados, Game BC, **padrões de código** |
| [`plans/`](plans/) | Roadmap, planos REST/ficha/equipamento/mesa/**code health** |
| [`checklists/`](checklists/) | Checklists mecânicos (HP, AC, feats, magias…) |
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

## Planos

| Doc | Para quê |
|-----|----------|
| [`plans/product-roadmap.md`](plans/product-roadmap.md) | Roadmap vivo |
| [`plans/api-plan.md`](plans/api-plan.md) | Contrato REST / Swagger / testes |
| [`plans/code-health-plan.md`](plans/code-health-plan.md) | Enxugar arquivos gordos e legado |
| [`plans/sheet-readiness-plan.md`](plans/sheet-readiness-plan.md) | Prontidão da ficha |
| [`plans/equipment-catalog-plan.md`](plans/equipment-catalog-plan.md) | Gear / truncados |
| [`plans/game-advanced-plan.md`](plans/game-advanced-plan.md) | Mesa / sessão avançada |
| [`plans/rpg-web-plan.md`](plans/rpg-web-plan.md) | Visão produto web |

## Checklists

| Doc | Mecânica |
|-----|----------|
| [`checklists/hit-points-checklist.md`](checklists/hit-points-checklist.md) | HP |
| [`checklists/armor-class-checklist.md`](checklists/armor-class-checklist.md) | CA |
| [`checklists/attack-bonus-checklist.md`](checklists/attack-bonus-checklist.md) | Ataque |
| [`checklists/feat-options-checklist.md`](checklists/feat-options-checklist.md) | Opções de talento |
| [`checklists/feat-options-audit.md`](checklists/feat-options-audit.md) | Auditoria feat options |
| [`checklists/granted-spells-checklist.md`](checklists/granted-spells-checklist.md) | Magias concedidas |

## Ops / fontes

- Deploy → [`deploy/DEPLOY.md`](deploy/DEPLOY.md)
- Fontes → [`sources/README.md`](sources/README.md)
- Valda Spire → [`sources/valda-spire-of-secrets/`](sources/valda-spire-of-secrets/)
- Valda Gunslinger → [`sources/valda-gunslinger/`](sources/valda-gunslinger/)

## Cursor (agente)

Rules locais: `architecture` · `api-contract` · `phb-data` · `file-size` · `refactor-triggers` · `docs-hub`  
Skills locais: `dnd-glossary-pt` · `rpg-catalog-model` · `phb-query-views` · `postgres-apply-catalog` · `audit-code-health` · `split-large-module`
