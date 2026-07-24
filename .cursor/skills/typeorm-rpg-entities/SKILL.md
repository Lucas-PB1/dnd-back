---
name: typeorm-rpg-entities
description: Overlay TypeORM do catálogo PHB — schema rpg, phb_*, v_phb_*, slugs. Use quando mapear entities/views do dnd-api (além da skill global typeorm).
---

# TypeORM — entities PHB (dnd-api)

Genérico TypeORM / Nest → skills **shared-ai** `typeorm` + `nestjs`.  
Modelo de dados → `rpg-catalog-model`. Postgres → `postgres`.

## Deltas deste repo

- `schema: 'rpg'`, tabelas `phb_*`, views `v_phb_*` / `v_spell_by_class`
- Paths: entities `src/entities/`, views `src/entities/views/`
- `synchronize: false` — DDL em `database/`
- Slug de classe nas views: EN (`fighter`); magias muitas em PT
- BIGINT → `string` em TS

## Referências locais

- [`entity-template.md`](references/entity-template.md)
- [`relations-by-cluster.md`](references/relations-by-cluster.md)
- [`view-entities.md`](references/view-entities.md)
