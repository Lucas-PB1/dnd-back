# Flags de ataque em combate (`CombatAttackCommand`)

Paridade HTTP ↔ motor de roll (PVE-5a).

| Camada | Onde |
|--------|------|
| Command | `CombatAttackCommand` em `src/game/combat/application/roll-combat-attack.ts` |
| DTO compartilhado | `CombatAttackFlagsDto` em `src/game/combat/dto/combat-attack-flags.dto.ts` |
| Pick | `pickCombatAttackCommand` — strip de IDs HTTP |
| Skirmish | `ResolveSkirmishAttackDto extends CombatAttackFlagsDto` |
| Encontro | `ResolveEncounterAttackDto extends CombatAttackFlagsDto` |

## Flags (command = DTO)

`advantage` · `itemSlug` · `mode` · `actionId` · `spentInspiration` · `automatic` · `studiedAttack` · `doorKick` · `steadyAim` · `strokeOfLuck` · `assassinate` · `preciseHunter` · `brutalStrike` · `targetCover` · `longRange` · `meleeWithRanged` · `graze` · `sneakAttack` · `cunningStrikeEffects` · **`divineSmite` / `smiteSlotLevel` / `smiteVsUndeadOrFiend`** · `huntersMark` · `colossusSlayer` · `dreadfulStrikes` · `dreadAmbusher` · `divineStrike` · `savageAttacker` · `chargerStrike` · `poisonousSneak` · `assassinSurprise` · `psiStrike` · `monsterSlayer` · `divineFury` · `quickStrike`

**Smite:** `divineSmite` no skirmish/encontro → `rollDamage` → `apply-paladin` gasta o slot (`consumeSpellSlotLevel`). Spec: `roll-damage.class-rules.spec.ts`.

**Battle Master (PVE-5b):** `battleMasterManeuverSlug` no ataque skirmish → `resolveBattleMasterOnHit` + gasto `superiority-dice` (`trip-attack` / `menacing-attack` / `pushing-attack`).

Fora deste pacote: estilos GWF/TWF (PVE-5c), Eldritch Smite (PVE-6a), precision-attack on miss.

Relacionado: [`pve-skirmish-index.md`](../plans/pve-skirmish-index.md) · [`combat-real-deferred.md`](../plans/combat-real-deferred.md).
