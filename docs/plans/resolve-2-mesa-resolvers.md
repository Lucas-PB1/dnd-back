# RES-2 — Resolvers de mesa mortos

**Status:** aberto · **Pai:** [`resolve-pattern-backlog.md`](resolve-pattern-backlog.md) · **Dep:** RES-1 · **Tam:** M  
**Overlap:** executar junto ou dentro de [`legado-2-combat-domain.md`](legado-2-combat-domain.md) (LEG-1 fechado)

## Skills / rules

`nestjs` · `typescript` · `dry` · `testing` · `okf` · `/legado`  
`game-folder-conventions.mdc`

## Escopo

- `session/application/actions/**` — confirmar zero resolvers de classe órfãos
- `combat/domain/<classe>/` — table-actions / generated / notes mortos pós-economy
- Remover só com evidência de zero imports de produção

## Fora

- `resolveBattleMasterTableRoll` vivo (→ RES-4)
- `maneuver-resolve` vivo (→ RES-4)
- `duel-spell-resolve` (→ RES-3 / PVE-0)

## DoD

- [ ] Log OKF com tabela path/status
- [ ] Specs verdes
- [ ] Apagar este `.md` (ou fundir nota em LEG-2 e apagar)
