# PVE-7b — Arma Espiritual + Conjure (1 actor)

**Status:** feito · **Dep:** PVE-7a · **Tam:** M · **Índice:** [`pve-skirmish-index.md`](pve-skirmish-index.md)

## Skills / rules

`catalog-sql-first` · `postgresql-sql` · `nestjs` · `typescript` · `testing`  
`catalog-sql-first.mdc`

## Escopo

- `arma-espiritual` tipada (actor leve ou ataque bônus no turno do PC)
- `conjurar-animais` (e similares) = **1 actor** template com HP/dano equivalente (sem mapa / sem N tokens)

## DoD

- [x] Spiritual Weapon usável no skirmish
- [x] Conjure 1-actor + spec

## Entrega

- Seed [`seed.spiritual-conjure.sql`](../../database/seeds/creature/phb/seed.spiritual-conjure.sql)
- Removido one-shot `arma-espiritual` de `phb_spell_combat`
- `injectCasterDamageMod` + wire em `SyncSpellSpiritHandler`
- Doc [`spiritual-conjure-skirmish.md`](../architecture/spiritual-conjure-skirmish.md)
