# Views do catálogo

SSOT: [`adr-read-model-layers.md`](../../../../docs/architecture/adr-read-model-layers.md) · lista: [`read-model-inventory.md`](../../../../docs/plans/read-model-inventory.md).

## Quando usar

| Mecanismo | Quando |
|-----------|--------|
| Tabela `phb_*` | 1:1 / combat mecânico |
| View VALUES | Labels de enum |
| View join | Enriquecimento leve |
| **MV `mv_*`** | Lista/agregado/hot path — **17** no seed |

## MV (consumo)

Ver inventário §4 — feat, background, species choices, economy, bundles, slots, granted spells, CA/PV, heritage choices, spell-by-class.
