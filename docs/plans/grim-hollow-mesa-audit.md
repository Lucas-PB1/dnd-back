# Grim Hollow — mesa (Cap. 2 + Cap. 1)

**Status:** fases A–E **concluídas**; residual de mesa Cap. 2/1 **fechado** (2026-09-02).  
**Skills:** `rpg-class-mesa-api` · `rpg-class-mesa-front` · `rpg-catalog-model`

---

## Feito (residual)

| # | Item | Notas |
|---|------|-------|
| 1 | **Primordial Companion** | Tracker + summon/restore/command (padrão ranger) |
| 2 | **Smoke UI heranças** | API `C070`–`C072` + filtro front; QA manual |
| — | **Forma do Selvagem** | Uso = sync companheiro a PV cheio; recuperar gastando 1 Fúria (`shape-of-the-wild-rage-recover`) |

---

## Adiado (não bloqueia mesa)

| # | Item | Notas |
|---|------|-------|
| 3 | **Sub-escolhas de traço** (E3) | Tipo de dano, arma, skill, truque |
| 4 | **Skinrider's Trance** | Estado/actor vinculado |
| 5 | **Polish editorial** (F) | EN residual Cap. 2; magias Cap. 7 PT; painéis custom além MH |

---

## Cap. 4 e Cap. 6

| Capítulo | Doc | Estado |
|----------|-----|--------|
| Talentos (Cap. 4) | — | **Pronto** (gunslinger feat + Quick Strike) |
| Transformações (Cap. 6) | [`effect-mesa-checklist.md`](effect-mesa-checklist.md) §A · fonte GH | **§A fechado** (mesa). Combate/alvo → [`combat-real-deferred.md`](combat-real-deferred.md) |

---

## Arquivos-chave

| Área | Caminhos |
|------|----------|
| Passivos subs | `grim-hollow-subclass-combat-notes-data.ts`, `generate-gh-cap2-combat-passives.mjs` |
| Heranças runtime | `heritage-combat-notes.ts`, `loadHeritageResourceSchedule`, seeds `C070`–`C072` |
| Forma do Selvagem | `primal-spirit-actions.ts`, seed `C077` |
| Extract | `docs/source/extracts/grim-hollow/cap2-subclasses-en.json`, `cap7-spells.json` |
| Referência NL | `northlands-subclass-combat-notes.ts`, `ranger-actions.handler.ts` |
