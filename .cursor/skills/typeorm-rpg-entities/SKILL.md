---
name: typeorm-rpg-entities
description: Mapeia entidades TypeORM para schema rpg.phb_* e views v_phb_*. Use quando criar entities, relations ou ViewEntity para o catálogo PHB.
---

# TypeORM — entities PHB

## Referências

- [`entity-template.md`](references/entity-template.md) — template base
- [`relations-by-cluster.md`](references/relations-by-cluster.md) — relations por domínio
- [`view-entities.md`](references/view-entities.md) — @ViewEntity para API

## Regras

- `schema: 'rpg'`, `synchronize: false`
- Colunas snake_case com `@Column({ name: 'class_id' })`
- Views para endpoints read-only; entities para relations complexas
