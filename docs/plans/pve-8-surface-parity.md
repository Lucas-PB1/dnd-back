# PVE-8 — Paridade superfícies + docs

**Status:** feito · **Dep:** PVE-1c + PVE-5a + PVE-7a · **Tam:** M · **Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md)

## Skills / rules

`nestjs` · `typescript` · `dry` · `testing` · `okf` (se índice)  
Docs: `docs/README.md` · `backlog.md` · `combat-real-deferred.md` · `pvp-1v1-duel.md`

## Escopo

- Encontro: `POST .../cast` via `resolveCombatSpell`; alinhar DTO ataque
- Duelo 100% no motor compartilhado
- Atualizar `combat-real-deferred.md` / duelo: itens feitos vs residual
- Garantir índice PVE refletido no backlog Feature futura

## DoD

- [x] Mesmo cast MM/Fireball: skirmish + duelo + encontro
- [x] Docs sem “só 2 magias tipadas”

## Entrega

- `CampaignEncounterCastService` + `POST .../encounters/:id/cast`
- Doc [`surface-combat-parity.md`](../architecture/surface-combat-parity.md)
- Duelo/docs: magias tipadas = catálogo `phb_spell_combat` (não subset de 3 slugs)
