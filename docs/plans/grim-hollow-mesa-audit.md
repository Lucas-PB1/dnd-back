# Grim Hollow — plano mesa (Cap. 2 subclasses + Cap. 1 heranças)

**Início:** 2026-08-31  
**Edição:** `grim-hollow-players-guide-2024-en`  
**Skills:** `rpg-class-mesa-api` · `rpg-class-mesa-front` · `rpg-catalog-model`  
**Auditoria viva:** `node scripts/_audit-gh-mesa-state.mjs` (Supabase/local)

Escopo: fechar o gap entre **catálogo/listagem** e **efeito real na ficha/mesa** para subclasses Cap. 2 e traços de herança Cap. 1.

---

## Snapshot (Supabase, 2026-08-31)

| Métrica | Cap. 2 | Cap. 1 heranças |
|---------|--------|-----------------|
| Catálogo | 40 subs · 218 features | ~107 traços + builds tradicionais |
| Economy (`phb_class_economy_action`) | **192** | **44** |
| Economy com `resource_slug` | **53** | — |
| `phb_combat_modifier` | **1** (`sangromancer` HP) | **1** (`extra-tough`) |
| Notas combate GH (`grim-hollow-subclass-combat-notes`) | **40/40** subs + MH L9/L14 | — |
| J029 prepared spells | **157** rows · **24** subs | — |
| Magias Cap. 7 no catálogo | **101** (+ 29 tag Sangromancia) | — |
| Migrations heritage (`018`/`T091`–`T093`) | — | **aplicadas** ✓ |
| Seeds heritage (`C070`–`C072`) | — | **aplicados** ✓ (44 economy · 31 resources) |
| EN residual (heurística features) | **~166** / 218 | overlay PT ok |

**16 subclasses sem J029** — esperado (sem spell grant fixo no extract):  
`bulwark-warrior`, `carver-guild`, `circleof-entropy`, `circleof-mutation`, `collegeof-adventurers`, `devourer-guild`, `living-crucible`, `misfortune-bringer`, `nightwatcher`, `pathofthe-fractured`, `plague-doctor`, `sangromancer`, `sanguine-thief`, `trapper-guild`, `warriorof-pride`, `warriorof-regret`.

---

## Feito ✓

| Fase | Entrega |
|------|---------|
| **A** | Economia Cap. 2: guildas MH, inquisition, sangromante (`C063`–`C069`, `J030`, `J033b`) |
| **B** | Resources Cap. 2: `J041` + wire `C073` (**53** AEs com `resource_slug`) |
| **C** | Spells: Cap. 7 `J042`–`J044`; J029 **157**/24; mapa EN→`S014` |
| **E1** | Heranças deploy: `018`/`T093` + `C070`–`C072` em Supabase |
| **E2** | Validação automática: `verify-gh-heritage-e2.mjs` + testes API/front |
| **D3** | `grim-hollow-subclass-combat-notes.ts` + wire em `aggregate-class-combat` (**17** subs) |
| **D4** | Bulk: **40/40** subs + MH classe; gerador + `C074`; manifest JSON |

---

## Fase D — passivos tipados Cap. 2

**Meta:** número ou nota tipada na ficha para CA/HP/resist/speed/sense/prof fixos (hoje ~**205** hints no extract, **1** modifier no banco).

### D1 — Inventário ✓

- [x] Regenerar `_audit-cap2-coverage.json` / TSV (`node scripts/_audit-gh-cap2-coverage.mjs`)
- [x] Classificar hints do extract (snapshot no JSON: HP 52, resist 26, prof 14, spell 37, other 39, AC 2, speed 3, sense 5)
- [x] Decisão por kind: **HP fixo** → `phb_combat_modifier`; **condicional/ativação** → `classCombatNotes`; escolha do jogador → skip

### D2 — Pilotos ✓ (notas + C069)

- [x] **`circleof-entropy`** — Ironskin como nota (CA 17+Sab durante Ruína Incarnate; não cabe em `unarmored_defense`)
- [x] **HP por nível** — `C069` sangromante no banco; nota na ficha complementa
- [x] **Resistências fixas** — amostra em notas: eldritch, haunted, green-reaper, pathofthe-fractured, vampire, daemonologist, etc.

### D3 — Wiring runtime ✓

- [x] Módulo `grim-hollow-subclass-combat-notes.ts` (+ `grimHollowClassCombatNotes` para MH L14)
- [x] Integrar em `aggregate-class-combat.ts`
- [x] Front: `classCombatNotes` já exibido em `class-combat-panel` / coluna esquerda

### D4 — Bulk ✓

- [x] Gerador `scripts/generate-gh-cap2-combat-passives.mjs` + manifest `_gh-cap2-combat-notes-manifest.json`
- [x] Dados em `grim-hollow-subclass-combat-notes-data.ts` — **40/40** subclasses GH
- [x] `C074` — sem hp_bonus extra incondicional (só `C069` sangromante); resist/CA → notas
- [x] MH classe: Defesa Erudita L9 + Senso do Covil L14

**Comando:** `node scripts/generate-gh-cap2-combat-passives.mjs`

---

## Fase E — Cap. 1 heranças (deploy + mesa)

**Meta:** traços com ação/cota na aba Ações e resources heritage funcionando (hoje quase tudo só prosa).

### E1 — Banco ✓

- [x] Aplicar migration `010_types/018_resource_owner_kind_heritage.sql`
- [x] Aplicar migration `020_tables/T093_phb_resource_definition_heritage.sql`
- [x] Migration `T091_phb_class_economy_action_heritage.sql` (já em prod)
- [x] Apply seeds: `C070` → `C071` → `C072` — **44** economy · **31** resources (`30` `gh-*` + `potentBreath`)

### E2 — Validação ✓ (auto) · smoke UI opcional

- [x] **2× mesmo truque** — `min_trait_takes` no catálogo + filtro `resolveClassEconomyActions` (`potent-breath`, `damage-immunity`)
- [x] **Resource grant** por takes — 31 grants no banco; `loadHeritageResourceSchedule` filtra `take_count >= min_trait_takes`
- [x] **HP `extra-tough`** — `loadHeritageHitPointsBonus`: 1× nv.5 → +5 PV; 2× → +10 PV
- [x] **Passivos nota** — `heritageCombatNotes`: darkvision, damage-immunity, extra-tough
- [ ] Smoke manual na UI (personagem GH com 2× traço → aba Ações + trackers)

**Comando:** `node scripts/verify-gh-heritage-e2.mjs`

### E3 — Residual (só se bloquear mesa)

- [ ] Sub-escolhas de traço (tipo de dano, arma, skill, truque) — schema + UI + persistência

---

## Fase F — polish editorial (não bloqueia mesa)

- [ ] Cap. 2 features: reduzir EN residual (**~166** → meta <30 óbvios)
- [ ] Summaries/descriptions de subclass ainda híbridas
- [ ] Cap. 7 magias: overlay PT (hoje EN + ranges SI)
- [ ] Painéis custom: só MH tem `C065`; avaliar 2–3 subs de alto uso antes de bulk

---

## Wiring mesa (spellcasting / companions)

Itens fora de J029 — comportamento de ficha, não prepared_spell.

### Sangromante + Sangromancia

- [x] **Sangromancy Savant:** picks de grimório bônus (2 no nv. 3, +1 por faixa de slot L5–L17) via `J045` + opções `sangromancySavant*`
- [x] Catálogo Cap. 7 filtrado por `GET /spells?sangromancy=true`; grimório do mago mescla tag `[Sangromancia]`
- [x] **Sanguine Thief:** `J046` spellcasting 1/3 + lista mago/Sangromancia na ficha; recurso `stolen-power` (J041)

### Caminho do Espírito Primal

- [ ] Companion “Primordial Companion” — stat block + tracker na ficha (reusar padrão `primal-companion` do ranger)
- [ ] Skinrider’s Trance: estado/actor vinculado (opcional pós-MVP)

---

## Top gaps (prioridade atual)

| # | Área | Bloqueio |
|---|------|----------|
| 1 | **Primal spirit** | Sem companion tracker |
| 2 | **PT editorial** | ~166 features com inglês residual |

---

## Arquivos-chave

| Área | Caminhos |
|------|----------|
| Audit vivo | `scripts/_audit-gh-mesa-state.mjs` · `scripts/verify-gh-heritage-e2.mjs` |
| Extract Cap. 2 | `docs/source/extracts/grim-hollow/cap2-subclasses-en.json`, `_audit-cap2-*.json/tsv` |
| Extract Cap. 7 | `docs/source/extracts/grim-hollow/cap7-spells.json` |
| Spell map | `scripts/lib/ghpg-cap2-spell-slug-map.mjs` |
| Seeds Cap. 2 | `J029`, `J041`, `J042`–`J044`, `C063`–`C069`, `C073`, `C074` |
| Passivos GH | `grim-hollow-subclass-combat-notes-data.ts`, `scripts/generate-gh-cap2-combat-passives.mjs` |
| Seeds Cap. 1 | `J037`–`J040`, `C070`–`C072` |
| Classificador herança | `scripts/classify-gh-heritage-trait-mechanics.mjs` |
| Runtime API | `resolve-character-combat-slice.ts`, `aggregate-class-combat.ts`, `grim-hollow-subclass-combat-notes.ts`, `heritage-combat-notes.ts` |
| Runtime front | `beyond-actions-tab.tsx`, `heritage-traditional-traits-panel.tsx` |
| Referência NL | `northlands-subclass-combat-notes.ts`, `ranger-actions.handler.ts` (`primal-companion`) |

---

## Critério de pronto

| Fase | Status |
|------|--------|
| A — economia Cap. 2 | ✓ |
| B — resources Cap. 2 | ✓ |
| C — spells + J029 | ✓ |
| D — passivos Cap. 2 | D1–D4 ✓ |
| E — heranças | E1–E2 ✓ (auto); smoke UI opcional |
| F — polish | EN residual baixo; magias Cap. 7 PT |

---

## Fora de escopo

- Painel UI dedicado para cada uma das 40 subclasses
- Re-tradução literária completa sem pedido explícito
- Sub-escolhas de herança com persistência total (até bloquear mesa)
