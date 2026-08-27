import {
  abilityModifier,
  AbilityScores,
  computeAbilityModifiers,
  type AbilityModifiers,
} from '@game/shared/domain/ability-scores';
import { computeUnarmoredArmorClass } from '@game/combat/domain/equipment';
import { classOrderSkillCheckBonus } from '../validation/class-options/class-order-effects';
import {
  skillCheckBonus,
  skillProficiencyRank,
} from './character-check-bonuses';

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
  armorClass: number;
};

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
        classOptions: input.classOptions,
        subclassOptions: input.subclassOptions,
        classSlug: input.classSlug,
        level: input.level,
      },
    ),
    armorClass: computeUnarmoredArmorClass(input.abilityScores),
  };
}
