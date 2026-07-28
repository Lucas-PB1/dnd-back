import {
  collectExpertiseSkillSlugs,
  collectProficientSkillSlugs,
  skillCheckBonus,
  skillProficiencyRank,
} from './character-check-bonuses';

describe('character-check-bonuses expertise sources', () => {
  it('applies class option expertise', () => {
    const input = {
      classSkillSlugs: ['stealth', 'sleight-of-hand'],
      backgroundSkillSlugs: [] as string[],
      classOptions: [
        { optionKey: 'expertiseSkill1', valueId: 'stealth' },
        { optionKey: 'expertiseSkill2', valueId: 'sleight-of-hand' },
      ],
    };
    expect(skillProficiencyRank('stealth', input)).toBe('expertise');
    expect(collectExpertiseSkillSlugs({
      classOptions: input.classOptions,
    })).toEqual([
      'stealth',
      'sleight-of-hand',
    ]);
  });

  it('Observant grants proficiency or expertise if already proficient', () => {
    const withoutPrior = {
      classSkillSlugs: [] as string[],
      backgroundSkillSlugs: [] as string[],
      featOptions: [
        {
          featSlug: 'observant',
          optionKey: 'attentiveSkill',
          valueId: 'perception',
        },
      ],
    };
    expect(skillProficiencyRank('perception', withoutPrior)).toBe('proficient');
    expect(collectProficientSkillSlugs(withoutPrior)).toContain('perception');

    const withPrior = {
      classSkillSlugs: ['perception'],
      backgroundSkillSlugs: [] as string[],
      featOptions: [
        {
          featSlug: 'observant',
          optionKey: 'attentiveSkill',
          valueId: 'perception',
        },
      ],
    };
    expect(skillProficiencyRank('perception', withPrior)).toBe('expertise');
  });

  it('applies Jack of All Trades for Bard when not proficient', () => {
    expect(
      skillProficiencyRank('athletics', {
        classSlug: 'bard',
        level: 2,
        classSkillSlugs: [],
        backgroundSkillSlugs: [],
      }),
    ).toBe('jack');
    expect(skillCheckBonus(2, 3, 'jack')).toBe(3);
  });
});
