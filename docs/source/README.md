# `docs/source` — catálogo DMG (extração)

Pasta **só** para artefatos de regeneração do catálogo Cap. 7 (A–Z).  
Wiring de mesa, economy e gaps de regra **não** moram aqui.

## O que fica

| Arquivo | Papel |
|---------|--------|
| `dmg-2024-itens-magicos-az.txt` | Texto-fonte (tradução comunitária) |
| `dmg-2024-itens-magicos-az.json` | Intermediário do gerador |
| `dmg-2024-itens-magicos-az-index.md` | Índice humano dos ~338 itens |
| `dmg-wiring-status.md` | Status dos lotes de wiring → seeds |
| `phb-2024-equipment-prices-audit.md` | Audit histórico preços Cap. 6 vs S031 |
| `phb-2024-equipment-gaps-catalog.md` | Audit histórico gaps Cap. 6 vs S031 |

## Regenerar seeds

```bash
# Na pasta dnd-api:
node scripts/generate-dmg-item-seeds.mjs      # → D010 + json + index
node scripts/generate-dmg-consumable-lote.mjs # → D011 + C016
node scripts/generate-dmg-coverage-lote.mjs   # → D013
```

Lista completa de seeds: [`database/seeds/dmg/README.md`](../database/seeds/dmg/README.md).

## Docs relacionados (fora desta pasta)

- Modelo mesa: [`docs/architecture/dmg-item-mesa.md`](../architecture/dmg-item-mesa.md)
- Regras Treasure × gaps: [`docs/architecture/treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md)
- Auditoria artefatos: [`docs/plans/audit-dmg-artifacts.md`](../../docs/plans/audit-dmg-artifacts.md) (repo root)

## Não colocar aqui

- Scrapes HTML do D&D Beyond / pastas `_files`
- Taxonomias YAML de planejamento (substituídas por `dmg-wiring-status.md`)
- Extratos automáticos gigantes do HTML
- Planos de feature (vão em `docs/plans/` ou `docs/architecture/`)
