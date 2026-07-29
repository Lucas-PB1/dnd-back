# Valda's Spire of Secrets — Player Pack

Fonte do catálogo Grimoire (regras 2024). Uso interno; respeitar direitos do publisher.

## Organização

| Arquivo | Papel |
|---------|--------|
| `page.html` + `images/` | Arquivo bruto EN (Beyond) — referência, não editar para o catálogo |
| **`extracted.json`** | **Fonte canônica do catálogo (PT-BR)** — editar textos aqui |
| `INVENTORY.md` | Inventário legível (gerado/auxiliar) |

Seeds em `database/seeds/valda/` são **artefatos gerados** a partir do JSON. Não editar SQL à mão.

## Escopo

| Tipo | No DB |
|------|-------|
| Subclasses | 6 → `V001`–`V002` |
| Espécies | Geppettin, Mandrake → `V003`–`V006` |
| Feats | 4 → `V007`–`V008` |
| Magias | 15 → `V009`–`V010` |
| Itens mágicos | 5 → `V011` |

Edição: `valda-spire-2024-en` · citação: `valda-spire-2024-en:player-pack`

## Pipeline

```bash
# Só se precisar re-extrair do HTML EN (depois traduza de novo o JSON):
# node scripts/extract-valda-source.mjs

node scripts/generate-valda-seeds.mjs   # JSON PT → D018 + seeds/valda/*.sql
npm run db:migrate                      # aplica D018 se pendente
npm run db:seed:valda                   # aplica seeds
```
