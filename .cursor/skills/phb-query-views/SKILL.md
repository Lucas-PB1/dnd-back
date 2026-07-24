---
name: phb-query-views
description: Queries SQL contra views v_phb_* / v_spell_by_class do catálogo PHB. Use ao escrever queries de API ou relatórios.
---

# Queries via views

## Referências

- [`spells-by-class.md`](references/spells-by-class.md) — `class_slug` EN (`wizard`)
- [`class-equipment.md`](references/class-equipment.md) — `class_slug` EN (`fighter`)
- [`background-equipment.md`](references/background-equipment.md)

## Princípio

Preferir views em `database/migrations/` (pasta de views) — DRY, contrato estável.  
Slugs: skill `dnd-glossary-pt`.
