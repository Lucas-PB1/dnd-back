import { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import { computeUnarmoredArmorClass } from '@game/combat/domain/equipment';
import {
  skillCheckBonus,
  skillProficiencyRank,
} from './character-check-bonuses';

export type AbilityModifiers = AbilityScores;

function abilityModifierValue(score: number): number {
  return Math.floor((score - 10) / 2);
}

export function computeAbilityModifiers(scores: AbilityScores): AbilityModifiers {
  return {
    forca: abilityModifierValue(scores.forca),
    destreza: abilityModifierValue(scores.destreza),
    constituicao: abilityModifierValue(scores.constituicao),
    inteligencia: abilityModifierValue(scores.inteligencia),
    sabedoria: abilityModifierValue(scores.sabedoria),
    carisma: abilityModifierValue(scores.carisma),
  };
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
    classOptions?: readonly { optionKey: string; valueId: string }[];
    classSlug?: string | null;
    level?: number;
  },
): number {
  const rank = skillProficiencyRank('perception', skillSources);
  return (
    10 +
    skillCheckBonus(
      abilityModifierValue(scores.sabedoria),
      proficiencyBonus,
      rank,
    )
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
  classOptions?: readonly { optionKey: string; valueId: string }[];
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
        classOptions: input.classOptions,
        classSlug: input.classSlug,
        level: input.level,
      },
    ),
    armorClass: computeUnarmoredArmorClass(input.abilityScores),
  };
}
