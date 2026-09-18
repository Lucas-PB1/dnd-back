# RES-4 — Maneuver / BM resolve → catálogo tipado

**Status:** aberto · **Pai:** [`resolve-pattern-backlog.md`](resolve-pattern-backlog.md) · **Dep:** RES-2 · idealmente PVE-5b · **Tam:** L

## Skills / rules

`catalog-sql-first` · `postgresql-sql` · `nestjs` · `typescript` · `dry` · `testing`  
`catalog-sql-first.mdc` · `effect-dictionary.md` · `adr-effect-engine.md`

## Escopo

- `session/domain/maneuver-resolve.ts` (Gunslinger `resolveManeuverEffect` / `rollRiskDie`)
- `combat/domain/fighter/table-actions.ts` (`resolveBattleMasterTableRoll`) usado por `apply-catalog-maneuver-table-action`
- Preferir kinds/satélites tipados; handler só orquestra
- Gunslinger `descriptive` fino pode residual → [`combat-real-deferred.md`](combat-real-deferred.md) (PVE-10a defer)

## DoD

- [ ] Sem lógica de manobra “por slug” espalhada fora do catálogo/structured kind
- [ ] Specs BM + ≥1 manobra gunslinger
- [ ] Apagar este `.md`
