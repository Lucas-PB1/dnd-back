# Checklist — Magias de fontes fora da classe

Escopo: magias concedidas por **talento** e **espécie**, com marcação de origem na ficha. Subclasse já entra via lista + `always_prepared` na UI.

**Fora de escopo:**
- Usos sem espaço / 1× por descanso longo (economia de recurso)
- Atributo de conjuração do talento/espécie na CD/ataque mágico
- Troca do truque de Alto Elfo após Descanso Longo (sem choice persistida)
- UI do wizard auto-preencher magias a partir de `featOptions` / espécie (o servidor sincroniza no create/update/level-up)

Smoke: `node scripts/smoke-granted-spells.mjs`

Legenda: `[x]` feito · `[ ]` pendente · `[~]` parcial

---

## Achado (antes do fix)

- `featOptions` / traços de espécie **não** sincronizavam para `characterSpells`
- Validação **só** aceitava lista de classe/subclasse
- DTO sem `source` → aba Magias não distinguia origem

---

## Estado atual

- [x] Sync create/update: magias de talento → `always_prepared`
- [x] Sync create/update/level-up: magias de espécie → `always_prepared`
- [x] Validação aceita slugs concedidos por talento **ou** espécie
- [x] Remoção ao trocar/retirar opções / espécie / nível
- [x] Campo `source` na resposta (`class` | `subclass` | `feat` | `species`)
- [x] Aba Magias mostra rótulo da origem

- [x] Magias de espécie/talento fixo vêm do **banco** (`v_phb_species_granted_spell`, `v_phb_feat_granted_spell`)
- [x] Sem hardcode de L1/gnomo/aasimar/fey-fixed no domínio

---

## Lote 1 — Talentos

- [x] **Iniciado em Magia** (`magic-initiate`) — `cantrip1`, `cantrip2`, `firstLevelSpell`
- [x] **Tocado pelas Fadas** (`fey-touched`) — `bonusSpell` + `passo-nebuloso`
- [x] **Tocado pelas Sombras** (`shadow-touched`) — `bonusSpell` + `invisibilidade`
- [x] **Conjurador Ritualista** (`ritual-caster`) — `ritualSpell1`…`N` (N = PB)
- [x] `listType` = `always_prepared`
- [x] `source` = `feat` na resposta

---

## Lote 2 — Espécie

- [x] **Aasimar** — `luz` (fixo)
- [x] **Tiferino** — `taumaturgia` + legado (`infernal_legacy`) L1/L3/L5
- [x] **Elfo** — linhagem (`elf_lineage`) L1/L3/L5
- [x] **Gnomo** — linhagem (`gnome_lineage`) desde o 1º nível
- [x] Gate por nível (L3 a partir do 3, L5 a partir do 5)
- [x] `source` = `species`

---

## Marcação

| Origem | Como entra | `source` |
|---|---|---|
| Classe | passo Magias / edit | `class` |
| Subclasse | toggle na UI | `subclass` |
| Talento | sync de `featOptions` | `feat` |
| Espécie | sync de espécie + `speciesChoices` | `species` |

Prioridade na marcação: `feat` > `species` > `subclass` > `class`.

---

## Como validar

```powershell
cd dnd-api
npx jest src/game/spellcasting/domain/granted-spells.spec.ts --no-coverage
npx tsc -p tsconfig.json
node scripts/smoke-granted-spells.mjs
```
