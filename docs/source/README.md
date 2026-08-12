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

## Regenerar seeds

```bash
# Na pasta dnd-api:
node scripts/generate-dmg-item-seeds.mjs      # → D010 + json + index
node scripts/generate-dmg-consumable-lote.mjs # → D011 + C016
node scripts/generate-dmg-coverage-lote.mjs   # → D013
```

Lista completa de seeds: [`database/seeds/dmg/README.md`](../../database/seeds/dmg/README.md).

## Docs relacionados (fora desta pasta)

- Modelo mesa: [`docs/architecture/dmg-item-mesa.md`](../architecture/dmg-item-mesa.md)
- Regras Treasure × gaps: [`docs/architecture/treasure-rules-vs-sistema.md`](../architecture/treasure-rules-vs-sistema.md)
- Backlog: [`docs/plans/backlog.md`](../plans/backlog.md)

## Não colocar aqui

- Scrapes HTML do D&D Beyond / pastas `_files`
- Extratos one-shot de packs já seedados (Steinhardt, Northlands, …)
- Planos de feature (vão em `docs/plans/` ou `docs/architecture/`)
