jest.mock('@game/dice/domain/dice', () => ({
  rollD20Check: jest.fn((modifier: number, mode = 'normal') => ({
    expression: `1d20+${modifier}`,
    total: 8 + modifier,
    modifier,
    mode,
    d20: { rolls: [8], kept: [8] },
  })),
}));

jest.mock('./roll-weapon-context', () => ({
  loadAccessibleCharacter: jest.fn().mockResolvedValue({
    id: 'fighter-1',
    classSlug: 'fighter',
    subclassSlug: 'champion',
    backgroundSlug: 'soldier',
    level: 9,
    abilityScores: {
      forca: 16,
      destreza: 12,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 8,
    },
  }),
}));

jest.mock('./stroke-of-luck', () => ({
  applyStrokeOfLuckIfRequested: jest.fn(async ({ result }) => result),
  spendStrokeOfLuck: jest.fn(),
  turnCheckIntoNaturalTwenty: jest.fn((result) => result),
}));

jest.mock('./apply-cursemarked-bracket', () => ({
  applyCursemarkedBracketIfTriggered: jest.fn().mockResolvedValue(undefined),
}));

jest.mock('@game/sheet/infrastructure/load-class-ability-boosts', () => ({
  resolveEffectiveAbilityScores: jest.fn(
    async (_ds: unknown, _classSlug: string, _level: number, scores: unknown) =>
      scores,
  ),
}));

import { BadRequestException } from '@nestjs/common';
import { executeRollSavingThrow } from './roll-saving-throw';
import { applyStrokeOfLuckIfRequested } from './stroke-of-luck';
import {
  asRollDep,
  mockEffectCatalog,
  mockResourceSpender,
} from './roll-damage.spec.helpers';

describe('executeRollSavingThrow', () => {
  const sheet = {
    load: jest.fn().mockResolvedValue({
      classSkillSlugs: [],
      backgroundSkillSlugs: [],
      speciesChoices: [],
      featOptions: [],
      classOptions: [],
    }),
  };

  const resourceSpender = mockResourceSpender();

  const base = {
    access: asRollDep({}),
    sheet: asRollDep(sheet),
    domain: asRollDep({
      getProficiencyBonus: jest.fn().mockResolvedValue(4),
    }),
    permanentItemEffects: asRollDep({
      resolve: jest.fn().mockResolvedValue({
        abilityBonuses: {},
        abilityScoreCaps: {},
        savingThrowBonuses: {},
      }),
    }),
    resourceSpender,
    effectCatalog: mockEffectCatalog(),
    userId: 'user-1',
    characterId: 'fighter-1',
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('rejects choosing Indomitable and Stroke of Luck together', async () => {
    await expect(
      executeRollSavingThrow({
        ...base,
        dataSource: asRollDep({ query: jest.fn().mockResolvedValue([]) }),
        dto: {
          abilitySlug: 'sabedoria',
          indomitable: true,
          strokeOfLuck: true,
        },
      }),
    ).rejects.toThrow(BadRequestException);
    expect(applyStrokeOfLuckIfRequested).not.toHaveBeenCalled();
    expect(resourceSpender.spendClassResource).not.toHaveBeenCalled();
  });

  it('spends Indomitable and adds character level to the save bonus', async () => {
    const result = await executeRollSavingThrow({
      ...base,
      dataSource: asRollDep({ query: jest.fn().mockResolvedValue([]) }),
      dto: {
        abilitySlug: 'sabedoria',
        indomitable: true,
      },
    });

    expect(result.note).toContain('Indomável: +9');
    expect(result.modifier).toBe(9);
    expect(resourceSpender.spendClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ classSlug: 'fighter' }),
      'indomitable',
      1,
    );
  });
});
