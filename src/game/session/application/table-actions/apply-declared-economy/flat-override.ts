import type { CatalogEffect } from '@game/effects';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { isBardClass } from '@game/combat/domain/bard';
import { isMonkClass } from '@game/combat/domain/monk';
import { isWizardClass } from '@game/combat/domain/wizard';
import { spellcastingAbilityModifier } from '../feat/apply-feat-economy-executed-effect';

type FlatOverrideInput = {
  effect: CatalogEffect;
  character: PlayerCharacter;
  actionSlug: string;
  strMod: number;
  intMod: number;
  castingMod: number;
  scheduleDieFaces?: number;
};

/**
 * Resolve flatOverride based on effect formula, class, and action context.
 */
export function resolveFlatOverride(input: FlatOverrideInput): { flatOverride?: number } {
  const { effect, character, actionSlug, strMod, intMod, castingMod } = input;
  const dexMod = abilityModifier(character.abilityScores?.destreza ?? 10);

  const usesEightPlusModPb =
    effect.numeric?.amountFormula === 'eight_plus_mod_plus_pb';
  const needsIntFlat =
    effect.numeric?.amountFormula === 'schedule_die_plus_flat' &&
    !isBardClass(character.classSlug);
  const usesScheduleDieFormula =
    effect.numeric?.amountFormula === 'schedule_die_plus_flat' ||
    effect.numeric?.amountFormula === 'schedule_die_double_plus_flat';
  const wardIntFlat =
    isWizardClass(character.classSlug) &&
    actionSlug === 'arcane-ward' &&
    effect.kind === 'temp_hp';
  const needsRogueFeatureDcFlat =
    usesEightPlusModPb && character.classSlug === 'rogue';
  const needsCastingFlat =
    !needsIntFlat &&
    !usesScheduleDieFormula &&
    !wardIntFlat &&
    !usesEightPlusModPb &&
    (effect.kind === 'heal' ||
      effect.kind === 'temp_hp' ||
      effect.kind === 'table_roll' ||
      (effect.kind === 'table_note' &&
        effect.numeric?.amountFormula === 'ability_mod') ||
      effect.numeric?.amountFormula === 'ability_mod' ||
      effect.numeric?.amountFormula === 'ability_mod_d8' ||
      effect.numeric?.amountFormula === 'dice_divine_spark_plus_flat' ||
      effect.numeric?.amountFormula === 'dice_2d6_plus_flat');
  const needsFeatureDcCastingFlat =
    usesEightPlusModPb &&
    !needsRogueFeatureDcFlat &&
    character.classSlug !== 'monk' &&
    character.classSlug !== 'barbarian';
  const needsFeatureDcMonkFlat =
    usesEightPlusModPb && isMonkClass(character.classSlug);
  const needsFeatureDcStrFlat =
    usesEightPlusModPb && character.classSlug === 'barbarian';
  const needsStrFlat =
    !needsIntFlat &&
    !needsCastingFlat &&
    !usesEightPlusModPb &&
    character.classSlug === 'barbarian' &&
    effect.numeric?.amountFormula === 'ability_mod';
  const needsDexFlat =
    !needsIntFlat &&
    !needsCastingFlat &&
    isBardClass(character.classSlug) &&
    actionSlug === 'unarmed-dance' &&
    effect.numeric?.amountFormula === 'schedule_die_plus_flat';
  const needsMonkDexFlat =
    isMonkClass(character.classSlug) &&
    actionSlug === 'guard-breaker' &&
    effect.numeric?.amountFormula === 'ability_mod';
  const heroicSoulDice =
    actionSlug === 'heroic-soul' && effect.dice?.die === '1d6';
  const needsScheduleCastingFlat =
    usesScheduleDieFormula &&
    (effect.kind === 'heal' ||
      (effect.kind === 'temp_hp' && isMonkClass(character.classSlug)));

  if (heroicSoulDice) {
    return { flatOverride: character.level };
  }
  if (needsRogueFeatureDcFlat) {
    return {
      flatOverride: actionSlug === 'spell-thief' ? intMod : dexMod,
    };
  }
  if (needsFeatureDcMonkFlat) {
    return { flatOverride: dexMod };
  }
  if (needsFeatureDcStrFlat) {
    return { flatOverride: strMod };
  }
  if (needsFeatureDcCastingFlat) {
    return { flatOverride: castingMod };
  }
  if (needsScheduleCastingFlat) {
    return { flatOverride: castingMod };
  }
  if (needsIntFlat || wardIntFlat) {
    return {
      flatOverride: wardIntFlat ? Math.max(1, intMod) : intMod,
    };
  }
  if (needsCastingFlat) {
    return {
      flatOverride: character.classSlug === 'barbarian' ? strMod : castingMod,
    };
  }
  if (needsStrFlat) {
    return { flatOverride: strMod };
  }
  if (needsDexFlat || needsMonkDexFlat) {
    return { flatOverride: dexMod };
  }
  return {};
}

/**
 * Compute ability modifiers from character ability scores.
 */
export function computeAbilityMods(character: PlayerCharacter): {
  strMod: number;
  intMod: number;
  castingMod: number;
} {
  return {
    strMod: abilityModifier(character.abilityScores?.forca ?? 10),
    intMod: abilityModifier(character.abilityScores?.inteligencia ?? 10),
    castingMod: spellcastingAbilityModifier(character.abilityScores),
  };
}
