# Grim Hollow — mesa (Cap. 2 + Cap. 1)

**Status:** fases A–E **concluídas** (2026-08-31). Este doc só lista **residual aberto** (resumo do feito: Cap. 2 economia/resources/spells/passivos 40/40; Cap. 1 heranças E1–E2; Cap. 4 talentos pronto).  
**Skills:** `rpg-class-mesa-api` · `rpg-class-mesa-front` · `rpg-catalog-model`  
**Auditoria:** `node scripts/archive/_audit-gh-mesa-state.mjs` · `node scripts/verify-gh-heritage-e2.mjs`

---

## Aberto

| # | Item | Notas |
|---|------|-------|
| 1 | **Primordial Companion** (Path of the Primal Spirit) | Stat block + tracker — reusar padrão `primal-companion` do ranger |
| 2 | **Smoke UI heranças** | Personagem GH com 2× traço → aba Ações + trackers |
| 3 | **Sub-escolhas de traço** (E3) | Tipo de dano, arma, skill, truque — só se bloquear mesa |
| 4 | **Skinrider's Trance** | Estado/actor vinculado (opcional pós-MVP) |
| 5 | **Polish editorial** (F) | EN residual Cap. 2 (~166 features); magias Cap. 7 PT; painéis custom além MH |

---

## Cap. 4 e Cap. 6

| Capítulo | Doc | Estado |
|----------|-----|--------|
| Talentos (Cap. 4) | — | **Pronto** (gunslinger feat + Quick Strike) |
| Transformações (Cap. 6) | [`grim-hollow-cap6-transformations.md`](grim-hollow-cap6-transformations.md) | Catálogo **feito**; ficha/mesa **aberto** |

---

## Arquivos-chave

| Área | Caminhos |
|------|----------|
| Passivos subs | `grim-hollow-subclass-combat-notes-data.ts`, `generate-gh-cap2-combat-passives.mjs` |
| Heranças runtime | `heritage-combat-notes.ts`, `loadHeritageResourceSchedule`, seeds `C070`–`C072` |
| Extract | `docs/source/extracts/grim-hollow/cap2-subclasses-en.json`, `cap7-spells.json` |
| Referência NL | `northlands-subclass-combat-notes.ts`, `ranger-actions.handler.ts` |
