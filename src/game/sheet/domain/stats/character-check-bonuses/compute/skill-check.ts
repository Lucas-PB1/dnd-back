import { hasJackOfAllTrades } from '../../../validation/class-options/class-expertise-slots';
import {
  collectExpertiseSkillSlugs,
  collectProficientSkillSlugs,
} from '../collect-skill-slugs';
import type { SkillBonusSources, SkillProficiencyRank } from '../types';

export function skillProficiencyRank(
  skillSlug: string,
  input: SkillBonusSources,
): SkillProficiencyRank {
  const expertise = new Set(collectExpertiseSkillSlugs(input));
  if (expertise.has(skillSlug)) return 'expertise';
  const proficient = new Set(collectProficientSkillSlugs(input));
  if (proficient.has(skillSlug)) return 'proficient';
  if (hasJackOfAllTrades(input.classSlug, input.level ?? 0)) return 'jack';
  return 'none';
}

/** Mod + PB (×2 expertise; metade arredondada para baixo se Jack of All Trades). */
export function skillCheckBonus(
  abilityModifier: number,
  proficiencyBonus: number,
  rank: SkillProficiencyRank,
): number {
  if (rank === 'expertise') return abilityModifier + proficiencyBonus * 2;
  if (rank === 'proficient') return abilityModifier + proficiencyBonus;
  if (rank === 'jack') {
    return abilityModifier + Math.floor(proficiencyBonus / 2);
  }
  return abilityModifier;
}
