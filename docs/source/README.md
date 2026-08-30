# `docs/source` — dados de catálogo

Pasta para **artefatos de regeneração de seeds**. Wiring de mesa e regras de jogo ficam em `docs/architecture/`.

## Estrutura

```
docs/source/
  README.md
  catalog-images.md          # fluxo de imagens → public/catalog
  extracts/                  # JSON/MD versionados (SSOT pós-scrape)
    dmg/
    grim-hollow/
    griffons-saddlebag/
    northlands/
    phb/
    srd/
  _scrapes/                  # HTML Beyond temporário (gitignored)
  _assets/                   # PNGs temporários de import (gitignored)
```

**Caminhos nos scripts:** `scripts/lib/docs-source.mjs` (`extracts`, `scrapes`, `assets`).

## `extracts/` — o que fica no git

| Pasta | Arquivos | Seeds / uso |
|-------|----------|-------------|
| `dmg/` | `items-az.txt`, `items-az.json`, `items-az-index.md`, `wiring-status.md` | `D010+`, economy |
| `grim-hollow/` | `cap1-heritages.json` … `cap6-transformations.json` | pack `grim-hollow` J009–J021 |
| `griffons-saddlebag/` | `book-one-part-ii.json` | pack `griffons-saddlebag` R001–R009 |
| `northlands/` | `cap5.json`, overlays PT, `stat-blocks.json` | N026–N029, M003–M004 |
| `phb/` | `cap6-mounts.json`, `cap6-barding.json`, sprites Cap. 7 | M005–M006, S079, equipamento |
| `srd/` | `monsters-5.2.1.json` | criaturas SRD (CC-BY) |

## `_scrapes/` — scrape Beyond (local, não commitar)

Salvar HTML exportado do D&D Beyond em subpastas por livro:

| Subpasta | Conteúdo |
|----------|----------|
| `_scrapes/grim-hollow/` | Capítulos GHPG (`Chapter 1` … `Chapter 6`) |
| `_scrapes/griffons-saddlebag/` | Part II Book One, Book Two, etc. |
| `_scrapes/phb/` | Equipamento, montarias |
| `_scrapes/northlands/` | Worldbook |
| `_scrapes/dmg/` | DMG |

Depois de extrair: `node scripts/cleanup-docs-source-scrapes.mjs` (remove HTML/`_files`).

Para apagar **toda** a pasta de scrapes: `--purge-all-scrapes`.

## `_assets/` — imagens temporárias

| Subpasta | Uso |
|----------|-----|
| `_assets/montarias/images/` | PNGs antes de `import-phb-mount-images.mjs` |
| `_assets/phb-equipment/` | Sprites `07-*.png` antes do split |

Após import para `public/catalog/`: `--prune-source` ou apagar manualmente.

## Pipeline típico

```bash
# 1. Salvar HTML em _scrapes/<livro>/
# 2. Extrair JSON
node scripts/extract-ghpg-cap1.mjs          # → extracts/grim-hollow/cap1-heritages.json
node scripts/extract-gsb-part-ii.mjs        # → extracts/griffons-saddlebag/book-one-part-ii.json

# 3. Limpar lixo de scrape
node scripts/cleanup-docs-source-scrapes.mjs

# 4. Gerar seeds
node scripts/generate-ghpg-cap1-seeds.mjs
node scripts/generate-gsb-part-ii-seeds.mjs

# 5. Aplicar no DB
node scripts/apply-seed-pack.mjs grim-hollow --target=supabase
```

## Regenerar por edição

```bash
node scripts/generate-dmg-item-seeds.mjs
node scripts/gen-northlands-stat-block-seeds.mjs
node scripts/gen-northlands-cap5-spell-seeds.mjs
node scripts/gen-northlands-cap5-magic-item-seeds.mjs
node scripts/import-phb-mount-images.mjs --seeds-only
```

Imagens: ver [`catalog-images.md`](./catalog-images.md).

## Não colocar aqui

- Scrapes HTML / `_files` no git (`.gitignore`)
- Planos de feature (`docs/plans/`)
- JSON one-shot já seedado sem script de regeneração

## Docs relacionados

- Modelo mesa DMG: [`docs/architecture/dmg-item-mesa.md`](../architecture/dmg-item-mesa.md)
- Seeds DMG: [`database/seeds/dmg/README.md`](../../database/seeds/dmg/README.md)
