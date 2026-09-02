# Grim Hollow Cap. 6 — Transformações

**Status:** A + B (J060) + C + D (read/edit) + E (notes) **concluídas** · E (resources/economy) **aberto**  
**Extract:** `docs/source/extracts/grim-hollow/cap6-transformations.json`  
**Rules:** `docs/source/extracts/grim-hollow/cap6-choice-rules.json`

Transformação ≠ talento ≠ herança: **4 estágios**, boons por estágio, flaws automáticos.

---

## Concluído

### A — Catálogo
- Seeds J019 + J048–J059; extract + overlay PT

### B — J060
- `cap6-choice-rules.json` + `J060_phb_feat_option_ghpg_transformations.sql` (seed versionado)
- Rules TS manuais: `src/game/sheet/domain/transformation/cap6-choice-rules/`
- `validateTransformationChoices` na ficha

### C — Persistência + D read
- `player_character_transformation*` + bundle + DTO
- Front: `TransformationSection` read-only

### D — UI edit
- Front: `EditTransformationForm` (slug / stage / choices) via sheet edit dialog
- PATCH `transformation` (validado pela API)

### E — Mesa notes (MVP)
- Notes data manuais: `src/game/combat/domain/notes/grim-hollow/transformation-combat-notes-data/`
- `transformationCombatNotes` → `classCombatNotes` no combat slice

---

## Aberto

### E — Resources / economy

- `phb_resource_*` + economy/table-action (Marca Demoníaca, Possession, …)
- Painel de usos na mesa

---

## Próximo passo

Economy tipada na mesa (Adiado no backlog).
