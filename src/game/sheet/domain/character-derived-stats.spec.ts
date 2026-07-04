import {
  computeDerivedStats,
  type AbilityModifiers,
} from './character-derived-stats';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';

describe('character-derived-stats', () => {
  const scores: AbilityScores = {
    forca: 15,
    destreza: 14,
    constituicao: 13,
    inteligencia: 10,
    sabedoria: 12,
    carisma: 8,
  };

  it('computes ability modifiers', () => {
    const result = computeDerivedStats({
      abilityScores: scores,
      proficiencyBonus: 2,
      classSkillSlugs: [],
      backgroundSkillSlugs: [],
    });
    expect(result.abilityModifiers).toEqual({
      forca: 2,
      destreza: 2,
      constituicao: 1,
      inteligencia: 0,
      sabedoria: 1,
      carisma: -1,
    });
  });

  it('adds proficiency to passive perception when proficient', () => {
    const without = computeDerivedStats({
      abilityScores: scores,
      proficiencyBonus: 2,
      classSkillSlugs: [],
      backgroundSkillSlugs: [],
    });
    const withPerception = computeDerivedStats({
      abilityScores: scores,
      proficiencyBonus: 2,
      classSkillSlugs: ['perception'],
      backgroundSkillSlugs: [],
    });
    expect(without.passivePerception).toBe(11);
    expect(withPerception.passivePerception).toBe(13);
  });

  it('computes unarmored armor class', () => {
    const result = computeDerivedStats({
      abilityScores: scores,
      proficiencyBonus: 2,
      classSkillSlugs: [],
      backgroundSkillSlugs: [],
    });
    expect(result.armorClass).toBe(12);
  });
});
