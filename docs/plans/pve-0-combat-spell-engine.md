# PVE-0 — Motor magia combate

**Status:** aberto · **Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md) · **Dep:** — · **Tam:** M

## Skills / rules

`catalog-sql-first` · `postgresql-sql` · `typeorm` · `nestjs` · `typescript` · `domain-driven-design` · `dry` · `testing`  
Rules: `catalog-sql-first.mdc` · `game-folder-conventions.mdc` · `file-size.mdc` · `typescript-docs.mdc`  
Docs: `adr-effect-engine.md` · `effect-dictionary.md` · `effect-engine-read-path.md`

## Escopo

- `resolveCombatSpell` em `src/game/combat/` (SSOT; skirmish + duelo)
- Satélite SQL tipado: dados, tipo dano, save outcome, heal, upcast
- Seeds piloto: `misseis-magicos`, `raio-de-fogo` via catálogo
- Remover hardcode de slug em `duel-spell-resolve.ts`

## Fora

Seeds em massa (PVE-1*) · concentração · reações · summons

## DoD

- [ ] MM / Fire Bolt iguais ao MVP atual via catálogo
- [ ] Zero `if (slug === 'misseis-magicos'|'raio-de-fogo')` no resolve
- [ ] Kind documentado no dicionário + read-path no mesmo PR
- [ ] Specs + smoke skirmish cast
