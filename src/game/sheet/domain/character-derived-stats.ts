import { AbilityScores } from '../../shared/infrastructure/player-character.entity';

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
  classSkillSlugs: string[],
  backgroundSkillSlugs: string[],
): number {
  const proficient =
    classSkillSlugs.includes('perception') ||
    backgroundSkillSlugs.includes('perception');
  return (
    10 +
    abilityModifierValue(scores.sabedoria) +
    (proficient ? proficiencyBonus : 0)
  );
}

/** CA base sem armadura (10 + mod Des). */
export function computeUnarmoredArmorClass(scores: AbilityScores): number {
  return 10 + abilityModifierValue(scores.destreza);
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
}): CharacterDerivedStats {
  return {
    abilityModifiers: computeAbilityModifiers(input.abilityScores),
    passivePerception: computePassivePerception(
      input.abilityScores,
      input.proficiencyBonus,
      input.classSkillSlugs,
      input.backgroundSkillSlugs,
    ),
    armorClass: computeUnarmoredArmorClass(input.abilityScores),
  };
}
