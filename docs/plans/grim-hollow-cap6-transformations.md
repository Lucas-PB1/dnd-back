# Grim Hollow Cap. 6 — Transformações

**Status:** fases A + C + D (read) **concluídas** · B (J060) + D (edit) + E (mesa) **abertas**  
**Extract:** `docs/source/extracts/grim-hollow/cap6-transformations.json`  
**Auditoria:** `node scripts/audit-ghpg-cap6.mjs`

Transformação ≠ talento ≠ herança: **4 estágios**, boons por estágio, flaws automáticos. Compêndio = referência; ficha usa tabelas dedicadas (`player_character_transformation*`).

---

## Concluído — fase A (catálogo)

- Seeds J019 (shell) + J048–J059 (benefícios 12 transformações)
- Extract com listas/tabelas/apêndices; overlay PT 12/12
- Gerador: `generate-ghpg-cap6-seeds.mjs`

```bash
node scripts/extract-ghpg-cap6.mjs
node scripts/build-ghpg-cap6-transformations-pt-overlay.mjs
node scripts/generate-ghpg-cap6-seeds.mjs
node scripts/audit-ghpg-cap6.mjs
```

---

## Concluído — fase C (persistência) + D read

- Migration `090_player/P001_player_character_transformation.sql` (+ mirror no baseline)
- Bundle `get_character_sheet_bundle` → `transformation: { slug, stage, choices[] } | null`
- Sync / load / DTO sheet; **não** usar `characterFeats[]` (`gh-transformation-*` rejeitado)
- Choices **opacas** até J060
- Front: `TransformationSection` read-only em `beyond-traits-tab.tsx`

---

## Aberto

### B — Opções estruturadas (J060)

- `phb_option_def`: `stage1Boon`, `stage2Boon`, … + sub-opções (`fiendDamageType`, `vampireBloodline`, …)
- Validador espelhando `heritage-choices.validator.ts` (regras 1 de N, 2 de 4, flaws automáticos)

### D — UI edit

- Wizard/painel para avançar estágio / trocar boon (após J060)

### E — Mesa (pós-ficha)

- `phb_resource_*` + economy para ações ativas (Marca Demoníaca, Possession, …)
- Combat notes por boon ativo

---

## Próximo passo

1. J060 `phb_option_def` + validator de boons/flaws.
2. UI edit (wizard) no front.
3. Mesa / economy.
