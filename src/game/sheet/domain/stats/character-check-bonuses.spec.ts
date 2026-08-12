import {
  collectProficientSkillSlugs,
  collectSaveProficiencyAbilities,
  initiativeBonus,
  skillCheckBonus,
  skillProficiencyRank,
} from './character-check-bonuses';

describe('character-check-bonuses', () => {
  it('merges class, background, species and feat skill proficiencies', () => {
    const slugs = collectProficientSkillSlugs({
      classSkillSlugs: ['athletics'],
      backgroundSkillSlugs: ['insight'],
      speciesChoices: [{ choiceKind: 'human_skill', choiceSlug: 'perception' }],
      featOptions: [
        {
          featSlug: 'skill-expert',
          optionKey: 'newSkill',
          valueId: 'stealth',
        },
        {
          featSlug: 'skilled',
          optionKey: 'proficiency1',
          valueId: 'arcana',
        },
      ],
    });
    expect(slugs.sort()).toEqual([
      'arcana',
      'athletics',
      'insight',
      'perception',
      'stealth',
    ]);
  });

  it('includes primordial knowledge extra skill', () => {
    expect(
      collectProficientSkillSlugs({
        classSkillSlugs: ['athletics'],
        backgroundSkillSlugs: [],
        classOptions: [
          { optionKey: 'primordialKnowledgeSkill', valueId: 'survival' },
        ],
      }),
    ).toEqual(['athletics', 'survival']);
  });

  it('applies expertise as double proficiency bonus', () => {
    const input = {
      classSkillSlugs: ['perception'],
      backgroundSkillSlugs: [] as string[],
      featOptions: [
        {
          featSlug: 'skill-expert',
          optionKey: 'expertiseSkill',
          valueId: 'perception',
        },
      ],
    };
    expect(skillProficiencyRank('perception', input)).toBe('expertise');
    expect(skillCheckBonus(2, 3, 'expertise')).toBe(8);
    expect(skillCheckBonus(2, 3, 'proficient')).toBe(5);
    expect(skillCheckBonus(2, 3, 'none')).toBe(2);
  });

  it('adds Resilient ability as save proficiency', () => {
    expect(
      collectSaveProficiencyAbilities(['forca', 'constituicao'], [
        {
          featSlug: 'resilient',
          optionKey: 'abilityIncrease',
          valueId: 'sabedoria',
        },
      ]).sort(),
    ).toEqual(['constituicao', 'forca', 'sabedoria']);
  });

  it('adds proficiency bonus to initiative with Alert', () => {
    expect(initiativeBonus(3, 2, [])).toBe(3);
    expect(initiativeBonus(3, 2, [{ featSlug: 'alert' }])).toBe(5);
  });
});
