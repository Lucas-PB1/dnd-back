# Code health — plano de enxugamento

Skills: `audit-code-health` · `split-large-module`  
Standards: [`../architecture/code-standards.md`](../architecture/code-standards.md)

## Inventário (2026-08-06, pós reorg `combat/domain`)

### Feito

| Item | Resultado |
|------|-----------|
| Catálogo mecânico → DB | tabelas + views + `LoadCombatMechanicalCatalog` |
| GET catálogo mecânico | `GET /combat-mechanical-catalog` (Catalog BC) |
| `character-state.repository.ts` | ~178 soft; `martial` + `resources` facades |
| `fighter-actions.handler` | facade ≤100 + `actions/fighter/{core,battle-master,psi-warrior,dungeoneer}` |
| Handlers HARD (bard, druid, monk, ranger, sorcerer) | facades + `actions/<classe>/` ≤150 |
| Softs paladin / warlock | mesmo padrão (`actions/paladin/`, `actions/warlock/`) |
| `combat/domain` em subpastas | pastas por classe + `equipment/` + `weapon-attacks/` + `catalog/`; barrel = `index.ts` em cada pasta |

### Ainda soft / próximo

| Arquivo | Nota |
|---------|------|
| `cleric/subclass-actions.ts` (~185) | soft OK; fatiar só se crescer |
| Softs de notas de combate | OK se ≤200 |

## Próximos PRs (máx 3)

1. ~~Expor GET catálogo mecânico no BC Catalog~~ → `GET /combat-mechanical-catalog` (2026-08-06)
2. Softs ≤150 só se crescerem (cleric subclass-actions)
3. — 

## Histórico curto

| Data | Estado |
|------|--------|
| 2026-07-27 | Pós P0–P5: **0** críticos |
| 2026-08-06 | Session + weapon-attacks + catálogo mecânico + MartialFacade + fighter + handlers + reorg `combat/domain` |
