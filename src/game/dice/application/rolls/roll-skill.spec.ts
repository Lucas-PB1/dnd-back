jest.mock('@game/dice/domain/dice', () => ({
  rollD20Check: jest.fn().mockReturnValue({
    expression: '1d20+7',
    total: 11,
    modifier: 7,
    mode: 'normal',
    d20: { rolls: [4], kept: [4] },
  }),
}));

jest.mock('./roll-weapon-context', () => ({
  loadAccessibleCharacter: jest.fn().mockResolvedValue({
    id: 'rogue-1',
    classSlug: 'rogue',
    subclassSlug: 'thief',
    backgroundSlug: 'criminal',
    level: 7,
    abilityScores: {
      forca: 8,
      destreza: 18,
      constituicao: 12,
      inteligencia: 12,
      sabedoria: 10,
      carisma: 10,
    },
  }),
}));

import { executeRollSkill } from './roll-skill';

describe('executeRollSkill', () => {
  it('treats a proficient Rogue d20 result below 10 as 10', async () => {
    const result = await executeRollSkill({
      access: {} as never,
      sheet: {
        load: jest.fn().mockResolvedValue({
          classSkillSlugs: ['stealth'],
          backgroundSkillSlugs: [],
          speciesChoices: [],
          featOptions: [],
          classOptions: [],
        }),
      } as never,
      domain: {
        getProficiencyBonus: jest.fn().mockResolvedValue(3),
      } as never,
      dataSource: {
        query: jest.fn().mockResolvedValue([
          {
            slug: 'stealth',
            name: 'Furtividade',
            ability_slug: 'destreza',
          },
        ]),
      } as never,
      resourceSpender: {
        spendClassResource: jest.fn(),
        consumeSpellSlotLevel: jest.fn(),
      },
      userId: 'user-1',
      characterId: 'rogue-1',
      dto: { skillSlug: 'stealth' },
    });

    expect(result.total).toBe(17);
    expect(result.kept).toEqual([10]);
    expect(result.note).toContain('Talento Confiável');
  });
});
