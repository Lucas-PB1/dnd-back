# Imagens de catálogo — fluxo

Como as ilustrações chegam ao front (`dnd-front/public/catalog/…`) e aos seeds SQL. Geradores de import/split **não** ficam no repo — assets e seeds já versionados são a SSOT.

## Onde cada coisa mora

| Camada | Caminho | Papel |
|--------|---------|--------|
| Fonte (temporária) | `docs/source/_assets/…` | PNGs de scrape — **apagar após import** (gitignored) |
| SSOT metadados | `docs/source/extracts/…` | JSON com `imageUrl` / slugs — **manter** |
| Assets públicos | `dnd-front/public/catalog/…` | Servidos pelo Next — **commitar** |
| DB | `database/seeds/**` (`image_url`) | **manter** |

## Lotes fechados (estado)

| Lote | Público | Extract / seed |
|------|---------|----------------|
| Montarias PHB Cap. 6 | `public/catalog/mounts/` | `extracts/phb/cap6-mounts.json` · `M006` / `S079` |
| Subclasses GH Cap. 2 | `public/catalog/subclasses/` | `cap2-subclasses-en.json` · `J034` |
| Equipamento GH Cap. 5 | (front + fallbacks PHB) | `cap5-advanced-equipment-images.json` · `J008` |
| Equipamento PHB Cap. 7 | `public/catalog/equipment/` | `cap7-equipment-sprites.json` + status JSON |

## Lote 2 — Equipamento PHB (Cap. 7) — composites

Sprites do Beyond vêm **agrupados**. Manifesto de crops/ordem: `extracts/phb/cap7-equipment-sprites.json`. Status: `extracts/phb/cap7-equipment-images-status.json`.

| Arquivo | Itens no sprite |
|---------|-----------------|
| `07-058.simple-melee.png` | 10 armas corpo a corpo simples |
| `07-059.simple-range.png` | 4 armas à distância simples |
| `07-060.martial-range.png` | 6 armas à distância marciais |
| `07-061.martial-melee.png` | 18 armas corpo a corpo marciais |
| `07-062.light-armor-and-shields.png` | 3 armaduras leves + 1 escudo |
| `07-063.medium-armor.png` | 5 armaduras médias |
| `07-064.heavy-armor.png` | 4 armaduras pesadas |
| `07-004.lamp-net.png` | lanterna + rede |

Ilustrações de **cena** (`07-001`, `07-003`, `07-005`, `07-006`) — não recortar por item.

## Lote 3+ — Criaturas, veículos, itens DMG

| Fonte | Destino público | SSOT |
|-------|-----------------|------|
| `extracts/northlands/stat-blocks.json` | `public/catalog/creatures/` | stat block + `imageUrl` |
| DMG itens mágicos | `public/catalog/magic-items/` | `extracts/dmg/items-az.json` |
| Veículos | `public/catalog/vehicles/` | templates em seeds |

## Regeneração

Não há scripts `import-*` / `split-*` no repo. Para reabrir um pipeline, histórico git de `scripts/`. Aplicar seeds: `npm run db:seed` — [`scripts/README.md`](../../scripts/README.md).

## O que nunca jogar fora

- JSONs em `extracts/` listados em [`README.md`](./README.md)
- Seeds SQL e PNGs já em `dnd-front/public/catalog/`

## Checklist por lote

- [ ] PNGs no `public/catalog/…`
- [ ] `imageUrl` no JSON de extrato
- [ ] Seed `UPDATE … image_url`
- [ ] Fonte temporária removida
- [ ] UI mostra imagem (`CatalogMediaImage`)
