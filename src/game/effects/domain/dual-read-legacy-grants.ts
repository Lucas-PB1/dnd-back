import type { CatalogEffect } from '../domain/catalog-effect';

export type EffectResourceGrantView = {
  effectId: string;
  ownerKind: CatalogEffect['ownerKind'];
  ownerId: string;
  ownerSlug: string | null;
  resourceId: string;
  unlockLevel: number;
  maxFormula: string;
  fixedMax: number | null;
  recoverOneOnShort: boolean;
  recoverAllOnShort: boolean;
  recoverAllOnLong: boolean;
  recoverOnLongDice: string | null;
  minTraitTakes: number;
};

export function catalogEffectsToResourceGrants(
  effects: readonly CatalogEffect[],
): EffectResourceGrantView[] {
  return effects
    .filter((effect) => effect.kind === 'grant_resource' && effect.resource)
    .map((effect) => ({
      effectId: effect.id,
      ownerKind: effect.ownerKind,
      ownerId: effect.ownerId,
      ownerSlug: effect.ownerSlug,
      resourceId: effect.resource!.resourceId,
      unlockLevel: effect.unlockLevel,
      maxFormula: effect.resource!.maxFormula,
      fixedMax: effect.resource!.fixedMax,
      recoverOneOnShort: effect.resource!.recoverOneOnShort,
      recoverAllOnShort: effect.resource!.recoverAllOnShort,
      recoverAllOnLong: effect.resource!.recoverAllOnLong,
      recoverOnLongDice: effect.resource!.recoverOnLongDice,
      minTraitTakes: effect.minTraitTakes,
    }));
}

export type EffectCombatModView = {
  effectId: string;
  ownerKind: CatalogEffect['ownerKind'];
  ownerId: string;
  ownerSlug: string | null;
  modKind: 'hp_bonus' | 'unarmored_defense';
  flatBonus: number;
  perLevelBonus: number;
  fromLevel: number;
  secondAbilitySlug: string | null;
  allowsShield: boolean;
  minTraitTakes: number;
  unlockLevel: number;
};

export function catalogEffectsToCombatMods(
  effects: readonly CatalogEffect[],
): EffectCombatModView[] {
  return effects
    .filter((effect) => effect.kind === 'combat_mod' && effect.combatMod)
    .map((effect) => ({
      effectId: effect.id,
      ownerKind: effect.ownerKind,
      ownerId: effect.ownerId,
      ownerSlug: effect.ownerSlug,
      modKind: effect.combatMod!.modKind,
      flatBonus: effect.combatMod!.flatBonus,
      perLevelBonus: effect.combatMod!.perLevelBonus,
      fromLevel: effect.combatMod!.fromLevel,
      secondAbilitySlug: effect.combatMod!.secondAbilitySlug,
      allowsShield: effect.combatMod!.allowsShield,
      minTraitTakes: effect.minTraitTakes,
      unlockLevel: effect.unlockLevel,
    }));
}
