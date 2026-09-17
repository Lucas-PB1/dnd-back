# Itens com carga no combate (PVE-6b)

Cast tipado no skirmish/duelo via o mesmo motor de magia (`castSpell` + `resolveCombatSpell`).

## Wire

| Campo DTO | Uso |
|-----------|-----|
| `itemCastResourceSlug` | Pool de cargas do item ativo (ex. `varinhaMisseisCharges`) |
| `itemCastSpendAmount` | Quantas cargas gastar (upcast quando a economy for charge-upcast) |
| `itemCastItemSlug` | Cast gratuito de item (sem pool) |

`pickCombatSurfaceCastCommand` → `CharacterStateRepository.castSpell` (mesa já valida economy/ativo).

`spellCombatBonusesFromCast` aplica `spellSaveDcOverride` / `spellAttackBonusOverride` do Treasure no resolve (ex. Varinha de Relâmpagos CD 15).

## Piloto

**Varinha de Mísseis Mágicos:** `misseis-magicos` + `varinhaMisseisCharges` → `auto_damage` no combatente (escala com cargas/slot).

Economy/seeds: `phb_item.economy-action-dmg-wands.sql` · mesa: [`dmg-item-mesa.md`](dmg-item-mesa.md).

Specs: `skirmish-item-charge-cast.spec.ts` · `pick-combat-surface-cast-command.spec.ts` · `spell-combat-bonuses-from-cast.spec.ts`.
