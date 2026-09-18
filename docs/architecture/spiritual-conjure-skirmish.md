# Arma Espiritual + Conjure 1-actor (PVE-7b)

Skirmish sem mapa: efeitos flutuantes / auras Conjure* viram **1 companion** na iniciativa (PVE-7a).

## Magias

| Slug | Template | Dano (aprox.) | Notas |
|------|----------|---------------|-------|
| `arma-espiritual` | `arma-espiritual` | `1d8+mod` (Energético) | Sem row em `phb_spell_combat`; ataque no turno do actor (após o PC). `NdX+0` → mod no sync. |
| `conjurar-animais` | `bando-animais-espectrais` | `3d10` Cortante | Aura PHB 2024 ≈ 1 bando; HP/CA proxy via `phb_creature_scale_by_slot`. |

Variante única: cast **sem** `spiritVariantKey` (auto).

## Fluxo

1. `castSpell` → `SyncSpellSpiritHandler` (mapa `phb_spell_spirit`)
2. Skirmish `addAlliedActorsToSkirmish` + `ensureActorAttackBonusFromCaster`
3. Turno automático aliado → foe
4. Quebra de concentração → despawn + prune

## Domínio

`inject-caster-damage-mod.ts` — marcador `+0` nos seeds.

OKF: Conjure* permanece `area_effect` nas regras; no skirmish é **proxy 1-actor** (ver [`summon-vs-conjure.md`](../okf/summon-vs-conjure.md)).

Specs: `inject-caster-damage-mod.spec.ts`.
