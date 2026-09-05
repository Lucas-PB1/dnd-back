import {
  abilityModifier,
  AbilityScores,
  computeAbilityModifiers,
  type AbilityModifiers,
} from '@game/shared/domain/ability-scores';
import { classOrderSkillCheckBonus } from '../validation/class-options/class-order-effects';
import {
  skillCheckBonus,
  skillProficiencyRank,
} from './character-check-bonuses';
import type { CatalogEffect } from '@game/effects';

export { computeAbilityModifiers };
export type { AbilityModifiers };

function abilityModifierValue(score: number): number {
  return abilityModifier(score);
}

export function computePassivePerception(
  scores: AbilityScores,
  proficiencyBonus: number,
  skillSources: {
    classSkillSlugs?: readonly string[];
    backgroundSkillSlugs?: readonly string[];
    speciesChoices?: readonly { choiceKind: string; choiceSlug: string }[];
    featOptions?: readonly {
      featSlug: string;
      optionKey: string;
      valueId: string;
    }[];
    characterFeats?: readonly { featSlug: string }[];
    featEffects?: readonly CatalogEffect[];
    classOptions?: readonly { optionKey: string; valueId: string }[];
    subclassOptions?: readonly { optionKey: string; valueId: string }[];
    classSlug?: string | null;
    level?: number;
  },
): number {
  const rank = skillProficiencyRank('perception', skillSources);
  const wisdomMod = abilityModifierValue(scores.sabedoria);
  return (
    10 +
    skillCheckBonus(wisdomMod, proficiencyBonus, rank) +
    classOrderSkillCheckBonus('perception', skillSources.classOptions, wisdomMod)
  );
}

export type CharacterDerivedStats = {
  abilityModifiers: AbilityModifiers;
  passivePerception: number;
};

/**
 * Stats derivados de atributos + perícias (sem equipamento).
 * CA: SSOT em `ResolveEquippedArmorClass` / `resolveCharacterCombatSlice` — não calcular aqui.
 */
export function computeDerivedStats(input: {
  abilityScores: AbilityScores;
  proficiencyBonus: number;
  classSkillSlugs: string[];
  backgroundSkillSlugs: string[];
  speciesChoices?: readonly { choiceKind: string; choiceSlug: string }[];
  featOptions?: readonly {
    featSlug: string;
    optionKey: string;
    valueId: string;
  }[];
  characterFeats?: readonly { featSlug: string }[];
  featEffects?: readonly CatalogEffect[];
  classOptions?: readonly { optionKey: string; valueId: string }[];
  subclassOptions?: readonly { optionKey: string; valueId: string }[];
  classSlug?: string | null;
  level?: number;
}): CharacterDerivedStats {
  return {
    abilityModifiers: computeAbilityModifiers(input.abilityScores),
    passivePerception: computePassivePerception(
      input.abilityScores,
      input.proficiencyBonus,
      {
        classSkillSlugs: input.classSkillSlugs,
        backgroundSkillSlugs: input.backgroundSkillSlugs,
        speciesChoices: input.speciesChoices,
        featOptions: input.featOptions,
        characterFeats: input.characterFeats,
        featEffects: input.featEffects,
        classOptions: input.classOptions,
        subclassOptions: input.subclassOptions,
        classSlug: input.classSlug,
        level: input.level,
      },
    ),
  };
}
