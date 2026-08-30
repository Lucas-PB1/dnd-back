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
| `phb-cap6-mounts-extract.json` | Montarias PHB (Cap. 6) — dados + `imageUrl` (lote ✅) |
| `phb-cap6-barding-extract.json` | Regra de barding (Cap. 6) — **não é imagem**; SSOT ×4/×2 |
| `srd-5.2.1-monsters.json` | SRD 5.2.1 (CC-BY) — stat blocks para seeds de criaturas |
| `montarias/images/*.png` | Fonte temporária de montarias — vazio após `--prune-source` |
| `phb-equipment-images/07-*.png` | Sprites compostos Cap. 7 |
| `phb-cap7-equipment-sprites-extract.json` | Manifesto crops / ordem de blob |
| `phb-cap7-equipment-images-status.json` | Verificação item a item (`ok` / `wrong` / `pending`) |
| `ghpg-cap3-backgrounds-extract.json` | Cap. 3 GHPG — antecedentes PHB 2024 (SSOT pós-scrape) |
| `ghpg-cap4-feats-extract.json` | Cap. 4 GHPG — talentos |
| `ghpg-cap6-transformations-extract.json` | Cap. 6 GHPG — transformações opcionais |

HTML de scrape Beyond (`docs/source/new/grim/`, `*.html`, `*_files/`) fica **fora do git** (ver `.gitignore`).

**Imagens de catálogo:** fluxo completo em [`catalog-images.md`](./catalog-images.md).

```bash
node scripts/import-phb-mount-images.mjs              # montarias → public + seeds
node scripts/import-phb-mount-images.mjs --prune-source  # + apaga montarias/images
node scripts/import-phb-mount-images.mjs --seeds-only    # só regenera seeds do public
```

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

- Scrapes Beyond HTML / pastas `_files` (JS/CSS) — rodar `node scripts/cleanup-docs-source-scrapes.mjs` após salvar imagens
- Extratos one-shot de packs **já seedados** (além dos JSON Northlands acima)
- Planos de feature (vão em `docs/plans/` ou `docs/architecture/`)
