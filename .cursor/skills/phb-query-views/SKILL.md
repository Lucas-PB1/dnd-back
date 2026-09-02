---
name: phb-query-views
description: Queries SQL e TypeORM contra read models do catálogo PHB. Use ao escrever queries de API, relatórios ou validação — após checar se cabe tabela direta ou MV.
---

# Queries — read models catálogo

## SSOT

- Camadas e decisões: [`docs/architecture/adr-read-model-layers.md`](../../../docs/architecture/adr-read-model-layers.md)
- Rule: [`read-model-layers.mdc`](../../../.cursor/rules/read-model-layers.mdc)

## Escolher mecanismo (ordem)

1. **Tabela `phb_*`** — espelho 1:1 ou join mínimo (`subclass.slug`). Preferir `@Entity` + relations.
2. **View VALUES** — label de enum (`v_phb_feat_category`, `v_phb_condition`, `v_phb_weapon_proficiency`).
3. **View join/agregado** — enriquecimento real (`v_phb_armor`, `v_phb_class_equipment`).
4. **MV `mv_*`** — listagem pesada; consumir MV, não view viva (`mv_spell_by_class`, `mv_phb_feat`, …). Inventário: [`read-model-inventory.md`](../../../docs/plans/read-model-inventory.md).
5. **RPC JSONB** — **não** usar aqui; só runtime ficha/mesa.

## Referências SQL

- [`spells-by-class.md`](references/spells-by-class.md) — `mv_spell_by_class`
- [`class-equipment.md`](references/class-equipment.md)
- [`background-equipment.md`](references/background-equipment.md)

## Views removidas (espelho — ler tabela)

Não queryar — usar entity: `phb_battle_master_maneuver`, `phb_gunslinger_maneuver`, `phb_class_panel_action`, etc. Lista completa: [`read-model-mirror-refactor.md`](../../../docs/plans/read-model-mirror-refactor.md).

Slugs: skill `dnd-glossary-pt`.
