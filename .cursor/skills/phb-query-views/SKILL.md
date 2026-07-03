---
name: phb-query-views
description: Queries SQL prontas contra views v_phb_* do catálogo PHB. Use quando escrever queries de API, endpoints ou relatórios sobre magias, classes, equipamento.
---

# Queries via views

## Referências

- [`spells-by-class.md`](references/spells-by-class.md)
- [`class-equipment.md`](references/class-equipment.md)
- [`background-equipment.md`](references/background-equipment.md)

## Princípio

Preferir views em `database/migrations/060_views/` — DRY, contrato estável.
