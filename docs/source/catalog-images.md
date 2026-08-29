# Imagens de catálogo — fluxo

Como popular ilustrações no front (`dnd-front/public/catalog/…`), gerar seeds SQL e **descartar** artefatos de scrape sem perder o que o repo precisa.

## Onde cada coisa mora

| Camada | Caminho | Papel |
|--------|---------|--------|
| Fonte (temporária) | `docs/source/montarias/images/*.png` | PNGs extraídos do Beyond — **apagar após import** |
| Fonte (temporária) | `docs/source/phb-equipment-images/07-*.png` | Ilustrações Cap. 7 — mapear → slug, depois apagar |
| SSOT metadados | `docs/source/phb-cap6-mounts-extract.json` | Slugs, custos, `imageUrl` das 8 montarias — **manter** |
| SSOT regra (não é imagem) | `docs/source/phb-cap6-barding-extract.json` | Regra de barding ×4/×2 — **manter** |
| Assets públicos | `dnd-front/public/catalog/mounts/{slug}.png` | Servidos pelo Next — **commitar** |
| DB | `database/seeds/creatures/M006_*.sql`, `phb/S079_*.sql` | `UPDATE … image_url` — **manter** |

A “coisinha minúscula” em `docs/source` é o **`phb-cap6-barding-extract.json`**: só a regra de armadura de montaria (custo ×4, peso ×2), não ilustração.

## Lote 1 — Montarias PHB (Cap. 6) ✅

Estado atual (2026-08-29):

- 8 PNGs em `public/catalog/mounts/`
- `phb-cap6-mounts-extract.json` com `imageUrl` e `imagesImportedAt`
- Seeds `M006_phb_mount_images.sql` + `S079_phb_mount_images.sql`
- `montarias/images/` vazio (fonte já descartada — correto)

### Reimportar / regenerar seeds (sem fonte)

```bash
cd dnd-api
node scripts/import-phb-mount-images.mjs --seeds-only
```

### Novo scrape de montarias

1. Salvar HTML em `docs/source/montarias/` **ou** PNGs nomeados por slug em `montarias/images/`
2. `node scripts/cleanup-docs-source-scrapes.mjs` (se veio HTML + `_files`)
3. `node scripts/import-phb-mount-images.mjs`
4. `node scripts/import-phb-mount-images.mjs --prune-source` — remove PNGs de `montarias/images/`
5. Rodar seeds no DB se `image_url` ainda for `NULL`

## Lote 2 — Equipamento PHB (Cap. 7) 🔜

Sprites do Beyond vêm **agrupados** (ex.: `07-059.simple-range.png` = dardo + besta + funda + arco no mesmo PNG).

### Pipeline (verificação item a item)

Sprites compostos exigem **conferência visual** — não confiar só na ordem do blob.

1. `node scripts/verify-phb-equipment-sprites.mjs init`
2. `node scripts/verify-phb-equipment-sprites.mjs checklist`
3. Conferir PNG em `_review/` ou `public/catalog/equipment/`
4. `node scripts/verify-phb-equipment-sprites.mjs mark <slug> ok|wrong [--note "..."]`
5. Ajustar só `wrong`/`pending`: `node scripts/split-phb-equipment-sprites.mjs --only wrong,pending`

Registro: `phb-cap7-equipment-images-status.json` (`ok` congela crop em `frozen`).

### Recorte

```bash
node scripts/split-phb-equipment-sprites.mjs --review
node scripts/split-phb-equipment-sprites.mjs --skip-verified
node scripts/split-phb-equipment-sprites.mjs --only wrong,pending
node scripts/split-phb-equipment-sprites.mjs --slug battleaxe
```

Manifesto de crops/ordem: `phb-cap7-equipment-sprites-extract.json`

Próximo: seed `image_url` → apagar fonte quando o lote fechar.

### Composites por item

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

### Antigo passo 2–4 (substituído pelo split acima)

## Lote 3+ — Criaturas, veículos, itens DMG

| Fonte | Destino público | SSOT |
|-------|-----------------|------|
| `northlands-stat-blocks.json` | `public/catalog/creatures/` | stat block + `imageUrl` no JSON |
| DMG itens mágicos | `public/catalog/magic-items/` | `dmg-2024-itens-magicos-az.json` |
| Veículos | `public/catalog/vehicles/` | templates em seeds |

Mesmo padrão: **PNG no front + `image_url` no seed + caminho no JSON de extrato**; descartar PNG/fonte em `docs/source` quando o lote estiver fechado.

## O que nunca jogar fora

- JSONs de extrato/regeneração listados em [`README.md`](./README.md)
- Seeds SQL gerados
- PNGs já em `dnd-front/public/catalog/`
- Scrapes HTML/`_files` **depois** de extrair imagens (cleanup remove)

## Checklist por lote

- [ ] PNGs no `public/catalog/…`
- [ ] `imageUrl` no JSON de extrato
- [ ] Seed `UPDATE … image_url`
- [ ] Fonte temporária removida (`--prune-source` ou cleanup)
- [ ] UI: detalhe/stat block mostra imagem (`CatalogMediaImage`)
