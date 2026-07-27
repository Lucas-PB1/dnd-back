# Valda’s Spire of Secrets — Player Pack

Fonte salva (compra D&D Beyond / Mage Hand Press) para ingestão no catálogo Grimoire.

## Conteúdo desta pasta

| Arquivo / pasta | Uso |
|-----------------|-----|
| [`page.html`](page.html) | Página salva do Beyond |
| [`images/`](images/) | Arte do pack |
| [`extracted.json`](extracted.json) | Extração estruturada (fonte dos seeds) |
| [`INVENTORY.md`](INVENTORY.md) | Inventário legível |

## Escopo do pack (2024)

| Tipo | Extraído | No DB |
|------|----------|-------|
| Subclasses | 6 | ✅ seeds `database/seeds/valda/` |
| Features | 31 | ✅ |
| Espécies | 2 | ✅ Geppettin, Mandrake |
| Feats | 4 | ✅ Brutal Grip, Field Commander, Focused Critical, Iron Hero |
| Magias | 15 | ✅ `V009` + `V010` (listas de classe) |
| Itens mágicos | 5 | ✅ `V011` (`properties.requiresAttunement` / raridade) |

Edição: `valda-spire-2024-en` · citação: `valda-spire-2024-en:player-pack`

## Pipeline

```bash
node scripts/extract-valda-source.mjs   # HTML → extracted.json + INVENTORY.md
node scripts/generate-valda-seeds.mjs   # JSON → D018 + seeds/valda/*.sql
npm run db:migrate                      # aplica D018 se pendente
# seeds Valda (sem truncate): aplicar database/seeds/valda/*.sql
```

Uso interno do projeto; respeitar direitos do publisher.
