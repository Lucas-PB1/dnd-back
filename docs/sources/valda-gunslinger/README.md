# Valda’s Spire of Secrets — The Gunslinger Class

Fonte salva (compra D&D Beyond / Mage Hand Press) para ingestão no catálogo Grimoire.

## Conteúdo desta pasta

| Arquivo / pasta | Uso |
|-----------------|-----|
| [`page.html`](page.html) | Página salva do Beyond |
| [`images/`](images/) | Arte do pack |
| [`extracted.json`](extracted.json) | Extração estruturada (fonte dos seeds) |
| [`INVENTORY.md`](INVENTORY.md) | Inventário legível |

## Escopo (2024)

| Tipo | Extraído | No DB |
|------|----------|-------|
| Classe | Gunslinger | ✅ `G001`–`G007` |
| Features | 16 + 6 maneuvers | ✅ `G008` |
| Subclasses (Creeds) | 6 | ✅ `G009`–`G010` |
| Props / masteries Valda | Firearm, Recoil, Reload, Automatic… | ✅ `G011` / `G011b` |
| Firearms + munição | 14 armas + 5 ammo | ✅ `G012`–`G013` |
| Feats do pack | Marksman’s Luck, Gun-Mage Adept | ✅ `G014`–`G015` |
| Magias do pack | 8 (sem Finger Guns) | ✅ `G016`–`G017` |
| Equipamento A/B | A + B 175 GP | ✅ `G018` |
| Weapon Mastery + Risk | progressão + recurso | ✅ `G019` |
| Fighting Style allowlist | amplitude do fighter | ✅ `G020` |
| **Spellslinger casting** | pattern `third`, cotas, lista Wizard, Finger Guns | ✅ `G021`–`G024` |

Edição: `valda-spire-2024-en` · citação: `valda-spire-2024-en:gunslinger`

### Jogável

- Create: skills, mastery, Estilo de Luta L1, pacotes A/B
- Risk (nv.2+): usos + `dieLabel` (d8/d10/d12) no combat hub
- **Spellslinger (nv.3+):** slots `third`, prepared da lista Wizard, Finger Guns `always_prepared`; passo Magias no create quando Creed = Spellslinger
- Reload/Recoil: só catálogo/texto (engine não automatiza)

### Ainda fora

- Maneuvers como subset escolhido
- Proficiência estrita “Martial Ranged only”

## Pipeline

```bash
npm run db:extract:gunslinger
npm run db:generate:gunslinger
npm run db:migrate:schema   # inclui T084/T085 + V041 + casting_type third
npm run db:seed:gunslinger
node scripts/smoke-gunslinger.mjs
node scripts/smoke-spellslinger.mjs
```

Uso interno do projeto; respeitar direitos do publisher.
