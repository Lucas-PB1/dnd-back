# Grim Hollow Cap. 4 — Talentos (feats)

**Status:** concluído (2026-09-01).  
**Auditoria:** `node scripts/audit-ghpg-cap4.mjs` · `node scripts/verify-ghpg-cap4-compendium.mjs`

---

## Concluído (resumo)

| Fase | Entrega |
|------|---------|
| 0–E | Extract, overlay PT, pré-requisitos J014b, economy C075, passivos 38/41, compêndio + ficha |
| Smoke | `audit-ghpg-cap4` ✓ · `verify-ghpg-cap4-compendium` ✓ · `classify-ghpg-cap4-mechanics` ✓ · `grim-hollow-feat-combat-notes.spec` ✓ |
| J047 | Opção `bloodMagicSpell` sangromantic-initiate |
| Residual | `blackpowder-pistol-expert` ↔ `reload-firearm`/`fire-chamber` (não-gunslinger com feat + pistola BP); proficiência, Recarga Rápida, Olho de Águia nos ataques |
| Residual | `resolutionofthe-syndicate` Golpe Rápido — toggle `quickStrike` no `POST …/roll/damage` |

---

## Comandos

```bash
node scripts/audit-ghpg-cap4.mjs
node scripts/verify-ghpg-cap4-compendium.mjs
node scripts/classify-ghpg-cap4-mechanics.mjs
npm test -- --testPathPattern="grim-hollow|weapon-attack|gunslinger-actions|roll-damage"
```

Cap. 6: [`grim-hollow-cap6-transformations.md`](grim-hollow-cap6-transformations.md)
