# Valda's Spire of Secrets — The Gunslinger Class

Fonte do catálogo Grimoire (classe Pistoleiro, regras 2024). Uso interno; respeitar direitos do publisher.

## Organização

| Arquivo | Papel |
|---------|--------|
| `page.html` + `images/` | Arquivo bruto EN (Beyond) — referência, não editar para o catálogo |
| **`extracted.json`** | **Fonte canônica do catálogo (PT-BR)** — editar textos aqui |
| `INVENTORY.md` | Inventário legível (gerado/auxiliar) |

Seeds em `database/seeds/valda-gunslinger/` são **artefatos gerados** a partir do JSON. Não editar SQL à mão.

## Escopo

| Tipo | No DB |
|------|-------|
| Classe Pistoleiro | `G001`–`G007` |
| Features + manobras | `G008` |
| Creeds (subclasses) | `G009`–`G010` |
| Props / masteries | `G011` / `G011b` |
| Firearms + munição | `G012`–`G013` |
| Feats | `G014`–`G015` |
| Magias | `G016`–`G017` |
| Equipamento / casting | `G018`–`G024` |

Edição: `valda-spire-2024-en` · citação: `valda-spire-2024-en:gunslinger`

### Jogável (resumo)

- Create: skills, mastery (armas com proficiência), Estilo de Luta L1, pacotes A/B
- Proficiência: Simple + Martial Ranged
- Risk (nv.2+): usos + `dieLabel`; 6 manobras de classe conhecidas
- Spellslinger (nv.3+): slots `third`, lista Wizard, Finger Guns `always_prepared`

## Pipeline

```bash
# Só se precisar re-extrair do HTML EN (depois traduza de novo o JSON):
# npm run db:extract:gunslinger

npm run db:generate:gunslinger
npm run db:migrate:schema
npm run db:seed:gunslinger
node scripts/smoke-gunslinger.mjs
```
