# Espíritos / companion na iniciativa (PVE-7a)

Aliados (`game_actor.parent_character_id` = PC) entram na fila do skirmish e atacam o inimigo no turno automático.

## Fluxo

| Evento | Comportamento |
|--------|----------------|
| Cast `invocar-fera` (+ `spiritVariantKey`) | `castSpell` spawna espírito → `addAlliedActorsToSkirmish` (init = PC, mod −1) |
| Create skirmish | Companions `actorKind=companion` já existentes entram na iniciativa |
| Cast `arma-espiritual` / `conjurar-animais` | 1 companion proxy (PVE-7b) — ver [`spiritual-conjure-skirmish.md`](spiritual-conjure-skirmish.md) |
| `end-turn` no turno do espírito | Ataca o **foe** (não o PC); bônus de ataque preenchido com ataque mágico do invocador |
| Quebra de concentração | Despawn mesa + prune combatentes órfãos + repara turno atual |

## Domínio

`skirmish-alliance.ts`: `pickAutomaticSkirmishTarget` · `findFoeSkirmishCombatant` · `spiritInitiativeAfterPc`.

Specs: `skirmish-alliance.spec.ts` · `ensure-actor-attack-bonus.spec.ts` · `sync-allied-actors-into-skirmish.spec.ts`.
