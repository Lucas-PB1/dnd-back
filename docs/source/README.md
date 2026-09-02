# `docs/source` — dados de catálogo

Pasta para **artefatos versionados** (extracts) e scrapes locais. Wiring de mesa e regras de jogo ficam em `docs/architecture/`.

Seeds SQL já commitados em `database/seeds/`. Aplicar com `npm run db:seed` / `db:setup` — ver [`scripts/README.md`](../../scripts/README.md).

## Estrutura

```
docs/source/
  README.md
  catalog-images.md          # onde moram PNGs / seeds de imagem
  extracts/                  # JSON/MD versionados (SSOT pós-scrape)
    dmg/
    grim-hollow/
    griffons-saddlebag/
    northlands/
    phb/
    srd/
  _scrapes/                  # HTML Beyond temporário (gitignored)
  scrap/                     # HTML Beyond manual (Cap. 2 GH, etc.)
  _assets/                   # PNGs temporários de import (gitignored)
```

## `extracts/` — o que fica no git

| Pasta | Arquivos | Seeds / uso |
|-------|----------|-------------|
| `dmg/` | `items-az.txt`, `items-az.json`, `items-az-index.md`, `wiring-status.md` | `D010+`, economy |
| `grim-hollow/` | `cap1-heritages.json` … `cap7-spells.json`, overlays PT | pack `grim-hollow` |
| `griffons-saddlebag/` | `book-one-part-ii.json` | pack `griffons-saddlebag` |
| `northlands/` | `cap5.json`, overlays PT, `stat-blocks.json` | N026–N029, M003–M004 |
| `phb/` | `cap6-mounts.json`, `cap6-barding.json`, sprites Cap. 7 | M005–M006, S079 |
| `srd/` | `monsters-5.2.1.json` | criaturas SRD (CC-BY) |

## `_scrapes/` / `_assets/`

HTML Beyond e PNGs temporários — **não** commitar (`.gitignore`). Após popular `extracts/` e `public/catalog/`, apagar fontes locais.

## Regeneração

Não há geradores extract/generate no repo. Seeds e extracts são a SSOT versionada. Se precisar reabrir um pipeline antigo, use o **histórico git** do diretório `scripts/`.

Imagens: ver [`catalog-images.md`](./catalog-images.md).

## Não colocar aqui

- Scrapes HTML / `_files` no git
- Planos de feature (`docs/plans/`)

## Docs relacionados

- Modelo mesa DMG: [`docs/architecture/dmg-item-mesa.md`](../architecture/dmg-item-mesa.md)
- Seeds DMG: [`database/seeds/dmg/README.md`](../../database/seeds/dmg/README.md)
- Scripts essenciais: [`scripts/README.md`](../../scripts/README.md)
