# Grim Hollow Cap. 6 — Transformações

**Status:** fase A (catálogo) **concluída** · fases B–E **abertas**  
**Extract:** `docs/source/extracts/grim-hollow/cap6-transformations.json`  
**Auditoria:** `node scripts/audit-ghpg-cap6.mjs`

Transformação ≠ talento ≠ herança: **4 estágios**, boons por estágio, flaws automáticos. Compêndio = referência; ficha precisa de persistência dedicada.

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

## Aberto

### B — Opções estruturadas (J060)

- `phb_option_def`: `stage1Boon`, `stage2Boon`, … + sub-opções (`fiendDamageType`, `vampireBloodline`, …)
- Validador espelhando `heritage-choices.validator.ts` (regras 1 de N, 2 de 4, flaws automáticos)

### C — Persistência ficha

- Migration `player_character_transformation` + `player_character_transformation_choice`
- DTO sheet: `transformation: { slug, stage, choices[] }`
- **Não** usar `characterFeats[]` para transformação

### D — UI read

- `TransformationSection` em `beyond-traits-tab.tsx` (padrão `SheetReadSection`)
- Edição: wizard/painel separado para avançar estágio / trocar boon

### E — Mesa (pós-ficha)

- `phb_resource_*` + economy para ações ativas (Marca Demoníaca, Possession, …)
- Combat notes por boon ativo

---

## Próximo passo

1. Aplicar J019 + J048–J059 no Supabase (se ainda pendente no ambiente).
2. Esboçar migration fase C + `TransformationSection` mock (só read).
3. J060 após persistência definida.

Cap. 4: [`grim-hollow-cap4-feats.md`](grim-hollow-cap4-feats.md)
