# `docs/source` — catálogo DMG (extração)

Pasta **só** para artefatos de regeneração do catálogo Cap. 7 (A–Z) e extratos Northlands já processados.  
Wiring de mesa, economy e gaps de regra **não** moram aqui.

## O que fica

| Arquivo | Papel |
|---------|--------|
| `dmg-2024-itens-magicos-az.txt` | Texto-fonte (tradução comunitária) |
| `dmg-2024-itens-magicos-az.json` | Intermediário do gerador |
| `dmg-2024-itens-magicos-az-index.md` | Índice humano dos ~338 itens |
| `dmg-wiring-status.md` | Status dos lotes de wiring → seeds |
| `northlands-cap5-extract.json` | Cap. 5 Northlands (itens/magias/equip.) — SSOT pós-scrape |
| `northlands-cap5-spells-pt.json` / `northlands-cap5-magic-items-pt.json` | Overlay PT Cap. 5 |
| `northlands-stat-blocks.json` | Stat blocks criaturas/veículos Northlands — SSOT pós-scrape |

Scrape Beyond e scripts `extract-northlands-*` / dicionário PT de scrape foram **descartados** após seed.  
Editar JSON → regenerar seeds com `gen-northlands-*.mjs`; checar com `audit-northlands-*.mjs`.

## Regenerar seeds

```bash
# Na pasta dnd-api:
node scripts/generate-dmg-item-seeds.mjs      # → D010 + json + index
node scripts/generate-dmg-consumable-lote.mjs # → D011 + C016
node scripts/generate-dmg-coverage-lote.mjs   # → D013
node scripts/gen-northlands-stat-block-seeds.mjs       # → M003/M004
node scripts/gen-northlands-cap5-spell-seeds.mjs       # → N026/N027
node scripts/gen-northlands-cap5-magic-item-seeds.mjs  # → N029
```

Lista completa de seeds: [`database/seeds/dmg/README.md`](../../database/seeds/dmg/README.md).

## Docs relacionados (fora desta pasta)

- Modelo mesa: [`docs/architecture/dmg-item-mesa.md`](../architecture/dmg-item-mesa.md)
- Regras Treasure × gaps: [`docs/architecture/treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md)
- Backlog: [`docs/plans/backlog.md`](../plans/backlog.md)

## Não colocar aqui

- Scrapes Beyond HTML / pastas `_files` (JS/CSS/imagens)
- Extratos one-shot de packs **já seedados** (além dos JSON Northlands acima)
- Planos de feature (vão em `docs/plans/` ou `docs/architecture/`)
