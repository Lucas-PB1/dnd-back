import {
  collectProficientSkillSlugs,
  collectSaveProficiencyAbilities,
  initiativeBonus,
  skillCheckBonus,
  skillProficiencyRank,
} from './character-check-bonuses';
import type { CatalogEffect } from '@game/effects';

function featEffect(overrides: Partial<CatalogEffect>): CatalogEffect {
  return {
    id: 'effect-1',
    kind: 'grant_proficiency',
    ownerKind: 'feat',
    ownerId: 'feat-1',
    ownerSlug: 'skilled',
    trigger: 'on_build',
    unlockLevel: 1,
    sortOrder: 0,
    minTraitTakes: 1,
    actionSlug: null,
    resourceSlug: null,
    label: null,
    requiresOptionKey: null,
    requiresOptionValue: null,
    spell: null,
    castEconomy: null,
    numeric: null,
    note: null,
    resource: null,
    combatMod: null,
    proficiency: null,
    purchaseDiscount: null,
    damageDie: null,
    weapon: null,
    feat: null,
    saveAdvantage: null,
    sense: null,
    damageType: null,
    language: null,
    checkAdvantage: null,
    reach: null,
    restQuirk: null,
    environmentalImmunity: null,
    ...overrides,
  };
}

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
      featEffects: [
        featEffect({
          ownerSlug: 'skill-expert',
          proficiency: { optionKey: 'newSkill', proficiencyKind: 'skill' },
        }),
        featEffect({
          ownerSlug: 'skilled',
          proficiency: { optionKey: 'proficiency1', proficiencyKind: 'skill' },
        }),
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

  it('does not grant Alert PB without initiative_pb effect', () => {
    expect(initiativeBonus(3, 2, [{ featSlug: 'alert' }])).toBe(3);
  });

  it('adds proficiency bonus to initiative via initiative_pb', () => {
    expect(
      initiativeBonus(3, 2, [{ featSlug: 'alert' }], {
        featEffects: [
          featEffect({
            kind: 'initiative_pb',
            ownerSlug: 'alert',
            proficiency: null,
          }),
        ],
      }),
    ).toBe(5);
  });

  it('uses grant_proficiency option keys when available', () => {
    const slugs = collectProficientSkillSlugs({
      featOptions: [
        { featSlug: 'skilled', optionKey: 'skill1', valueId: 'arcana' },
        { featSlug: 'skilled', optionKey: 'proficiency1', valueId: 'stealth' },
      ],
      featEffects: [
        featEffect({
          proficiency: { optionKey: 'skill1', proficiencyKind: 'skill' },
        }),
      ],
    });
    expect(slugs).toEqual(['arcana']);
  });

  it('uses initiative_pb effect without relying on Alert slug', () => {
    expect(
      initiativeBonus(3, 2, [{ featSlug: 'custom-alert' }], {
        featEffects: [
          featEffect({
            kind: 'initiative_pb',
            ownerSlug: 'custom-alert',
            proficiency: null,
          }),
        ],
      }),
    ).toBe(5);
  });

  it('grants deception from blessing-of-loki via grant_proficiency effect', () => {
    const lokiEffects = [
      featEffect({
        ownerSlug: 'blessing-of-loki',
        proficiency: { optionKey: 'deception', proficiencyKind: 'skill' },
      }),
    ];
    expect(
      collectProficientSkillSlugs({
        characterFeats: [{ featSlug: 'blessing-of-loki' }],
        featEffects: lokiEffects,
      }),
    ).toContain('deception');
    expect(
      skillProficiencyRank('deception', {
        characterFeats: [{ featSlug: 'blessing-of-loki' }],
        featEffects: lokiEffects,
      }),
    ).toBe('proficient');
    expect(
      skillProficiencyRank('deception', {
        classSkillSlugs: ['deception'],
        characterFeats: [{ featSlug: 'blessing-of-loki' }],
        featEffects: lokiEffects,
      }),
    ).toBe('expertise');
  });

  it('grants expertise from grant_expertise effect when already proficient', () => {
    expect(
      skillProficiencyRank('athletics', {
        classSkillSlugs: ['athletics'],
        characterFeats: [{ featSlug: 'boon-of-skill-proficiency' }],
        featEffects: [
          featEffect({
            kind: 'grant_expertise',
            ownerSlug: 'boon-of-skill-proficiency',
            proficiency: {
              optionKey: 'athletics',
              proficiencyKind: 'skill',
            },
          }),
        ],
      }),
    ).toBe('expertise');
  });

  it('grants all skills from grant_all_skill_proficiencies', () => {
    expect(
      collectProficientSkillSlugs({
        characterFeats: [{ featSlug: 'boon-of-skill-proficiency' }],
        featEffects: [
          featEffect({
            kind: 'grant_all_skill_proficiencies',
            ownerSlug: 'boon-of-skill-proficiency',
            proficiency: null,
          }),
        ],
      }),
    ).toEqual(
      expect.arrayContaining(['athletics', 'stealth', 'arcana', 'perception']),
    );
  });
});
