# Northlands — pente fino (audit)

**Início:** 2026-08-12 (antes de veículos Cap. 5).  
**Edição:** `northlands-heroes-2024-en`.  
**Skills:** `rpg-class-mesa-api` · `rpg-class-mesa-front` · `rpg-catalog-model`.

Escopo: Waves 1–4 + Cap. 5 seedado (armas/gear/magias/itens + Masterwork + veículos + Leviathan).  
**Fase 2:** Character Threads na mesa (Cursemarked/Fatebound runtime).

---

## Checklist

- [x] Espécies / traits / trait choices (Andari)
- [x] Antecedentes + feat de origem
- [x] Subclasses / features / prepared spells
- [x] Feats + requirements
- [x] Recursos
- [x] Economy / panel / table-actions (C052–C056)
- [x] Passivas lado direito
- [x] Cap. 5 catálogo (armas/gear/magias/itens)
- [x] Veículos / montarias / longships (`M003`)
- [x] Bestiário Northlands + Leviathan Avatar (`M004`)
- [x] Character Threads MVP — schema + seed `N036` + catálogo/ficha/wizard
- [x] Blessings origem + Eir resource/mesa + Greater ASI/grants
- [x] Path of the Titan mesa
- [x] Masterwork (cobertura `obra-prima` / `obra-prima-municao`)
- [ ] Character Threads fase 2 — runtime mesa (Cursemarked brackets, Fatebound morte, resources)

---

## OK

### Pack / create
- Seeds `N001`–`N036` no manifesto; citação Cap. 4 + Cap. 5.
- 7 espécies + option_def/value (`N006`–`N008`); resources espécie (`N009`).
- Andari cantrip: enum + `V057`/`V058` + validator API + front filter.
- 9 antecedentes; `preordained-hero` / `seafarer` com `origin_feat_choice_slugs` + pick no wizard.
- 8 subclasses + features + prepared; Espírito Curador (`N024`) no Spirit Caller L5.
- Feats + benefits + requirements; Greater Blessings ASI + spell grants (`N033`).
- Fighting styles Northlands (`N019`–`N021`).
- Eir: resource `eir-vitality-points` (`N032`) + economy (`C056`).
- Loki: Enganação fixa na ficha (`FIXED_FEAT_SKILL_SLUGS`).
- Giantkin Cloud/Storm: FKs magia (`N035`) + view `V060`.
- Masterwork: itens cobertura (`N034`); attach exige `bonus === 1`; arma mágica pode receber (sem stack do +1).
- Character Threads: catálogo `T085`/`V063`/`N036`; estado `P039`; API + Traços + wizard opcional.

### Cap. 5
- Mastery Pull + 7 armas (`N025`).
- 4 armaduras + 7 gear + Talharpa (`N028`).
- 78 magias PT + listas (`N026`/`N027` — **208** vínculos classe; doc “209” era falso alarme).
- 86 itens mágicos PT (`N029`).
- Masterwork como cobertura (`N034`).
- Veículos Cap. 5 (`M003`); bestiário + Leviathan Avatar (`M004`).

### Mesa
- 7/8 subclasses com trio C052 + C053 + C054; Titan em C052–C054.
- Spirit Caller: alternativas PF (`sorcerer-spirit-*-sp` → `spend-resource` 3 PF).
- Handlers usam economy declarada — sem `Set` hardcoded de subclass Northlands.
- Espécies C055: `spend-resource` + gates de linhagem; filtro de pool (M3).
- Eir: Surto/Canalizar Vitalidade via `spend-resource`.

---

## Residual (baixa / polish)

| # | Problema | Nota |
|---|----------|------|
| M6 | Features jogáveis só texto (Provocação, Regeneração, Pegar e Arremessar, …) | Lembrete em Passivas ou economy futura |
| M7 | Escolhas secundárias de espécie só narrativas (ápice For/Con, casting …) | `choice_kind` se a ficha precisar |
| B2 | Ulfberht dual mastery só em jsonb | Limitação de modelo |
| B3 | Slug item `shadow-blade` vs magia | Cuidado UI |
| B5 | DTO `actionSlug` enums hardcodados | Validar vs catálogo (médio prazo) |
| — | Greater Freyr: `curar-ferimentos` 1×/DL no grant vs texto PB usos/dia | Gap residual de economia |

---

## Adiado — fase 2 / mesa

| Tema | Por quê | Doc |
|------|---------|-----|
| **Character Threads — mesa** | Cursemarked brackets, Fatebound morte, resources 1/LR | [`northlands-character-threads.md`](northlands-character-threads.md) |

---

## Cobertura mesa (resumo)

| Entidade | table-action | economy | panel | resource | Notas |
|----------|--------------|---------|-------|----------|-------|
| skald | sim | sim | sim | sim | Vitalidade aplica tempHp |
| nornbound | sim | sim | sim | sim | |
| circle-of-fenris | sim | sim | sim | sim | |
| viking | sim | sim | sim | sim | Represália aplica tempHp |
| oath-of-valhalla | sim | sim | sim | sim | |
| spirit-caller | sim | sim | sim | sim | Alt. 3 PF catalogada |
| trickster | sim | sim | sim | sim | |
| path-of-the-titan | sim | sim | sim | — | Lembretes (sem pool) |
| blessing-of-eir | spend-resource | C056 | — | N032 | Cura 1d4 na mesa |
| bearfolk | spend-resource | parcial | — | N009 | Hug filtrado por linhagem |
| beastkin / fjord-dwarf | — | — | — | — | Só traits |
| giantkin / trollkin | spend-resource | gated | — | grant + FKs magia | |
| werekin | spend-resource | sim | — | sim | tempHp Força Bestial |
| baugsmidr-dwarf | spend-resource | sim | — | sim | |

---

## Correções feitas

| # | Correção | Onde |
|---|----------|------|
| A1 | Advance wizard: cantrips Alto Elfo / Andari só com lineage | `dnd-front` `advance-wizard-step.ts` |
| A2 | `marauders-reprisal` → PV temp. `floor(nível/2)` | `resolve-declared-economy-table-action.ts` |
| A3 | Titan: C052–C054 + DTO bárbaro | seeds + `table-actions-martial.dto.ts` |
| A4 | Passivas espécie + subclasse Northlands | `northlands-*-combat-notes.ts` |
| A5 origem | Blessings option_def + spell_grant | `N030`/`N031` |
| A5 Eir | Resource + economy Surto/Canalizar | `N032`/`C056` |
| A5 Loki | Enganação (prof./expertise se já tiver) | `character-check-bonuses.ts` |
| A5 Greater | ASI + grants Curar / Alterar-se / Augúrio | `N033` |
| M1 | Fenris L5 → Invocar Animais | `N003` |
| M2 | Giantkin Cloud/Storm spell FKs + view | `N035`/`V060` |
| M3 | Filtro resource espécie por option | `filter-species-resources-by-option.ts` |
| M4 | Bragi / Werekin tempHp | bard + species spend side-effects |
| M5 | Spirit Caller alt. 3 PF | `C053` (`*-sp` → `spend-resource`) |
| B1 | Loki → Zombaria Perversa | `N011` |
| B4 | Contagem listas = **208** (não 209) | `N027` vs doc Cap. 5 |
| — | Masterwork cobertura + attach `bonus=1` | `N034` + `attach-coverage.handler.ts` |

---

## Próximas levas (só com pedido)

1. Character Threads fase 2 (mesa: Cursemarked / Fatebound / resources)
2. M6 features texto → lembrete/economy (opcional)
3. Greater Freyr usos PB/dia (se quiser fidelidade total)
