# LEG-2 — Combat domain morto

**Status:** aberto · **Pai:** [`legado-cleanup-backlog.md`](legado-cleanup-backlog.md) · **Dep:** LEG-1 · **Tam:** M

## Skills / rules

`nestjs` · `typescript` · `dry` · `testing` · `okf` · `domain-driven-design`  
`game-folder-conventions.mdc` · `file-size.mdc`

## Escopo

- `src/game/combat/domain/<classe>/` — duplicatas, generated, resolvers substituídos por effects/economy
- Specs órfãs que só cobriam mortos
- Não reescrever motor de combate tipado (isso é PVE-*)

## DoD

- [ ] Log OKF + remoções com evidência de zero imports
- [ ] Specs restantes verdes
- [ ] Apagar este `.md`
