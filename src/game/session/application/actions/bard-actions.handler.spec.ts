import { BadRequestException } from '@nestjs/common';
import { FIXTURE_PERSONA_MASK_SLUGS } from '@game/combat/domain/__fixtures__/mechanical-catalog.fixtures';
import { BardActionsHandler } from './bard-actions.handler';

describe('BardActionsHandler', () => {
  const stateResponse = { classResources: [] };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const mechanicalCatalog = {
    load: async () => ({
      gunslingerManeuvers: [],
      battleMasterManeuvers: [],
      cunningStrikeEffects: [],
      tableActions: [],
      personaMasks: FIXTURE_PERSONA_MASK_SLUGS.map((slug) => ({
        slug,
        name: slug,
      })),
      personaMaskSlugs: [...FIXTURE_PERSONA_MASK_SLUGS],
      beastborneAspectBenefits: [],
      dungeoneerSlayerLabels: [],
      precautionSpells: [],
      economyActions: [],
      panelActions: [],
    }),
  };
  const handler = new BardActionsHandler(
    access as never,
    state as never,
    domain as never,
    mechanicalCatalog as never,
  );
  const bard = {
    id: 'bard-1',
    classSlug: 'bard',
    subclassSlug: 'lore',
    level: 5,
    abilityScores: {
      forca: 8,
      destreza: 14,
      constituicao: 12,
      inteligencia: 10,
      sabedoria: 12,
      carisma: 16,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue(bard);
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.buildResponse.mockResolvedValue(stateResponse);
    domain.getProficiencyBonus.mockResolvedValue(3);
  });

  it('spends Bardic Inspiration and returns correct die for level 5', async () => {
    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'grant-inspiration',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
    expect(result.expression).toBe('1d8');
    expect(result.note).toContain('Inspiração Bárdica (1d8)');
  });

  it('resolves Cutting Words for Lore Bard', async () => {
    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'cutting-words',
    });

    expect(result.expression).toBe('1d8');
    expect(result.note).toContain('Palavras Cortantes');
  });

  it('resolves Enthralling Performance for Glamour Bard', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      subclassSlug: 'glamour',
    });

    const result = await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'enthralling-performance',
    });

    expect(result.expression).toBe('2d8');
    expect(result.note).toContain('Desempenho Cativante');
  });

  it('recovers 1 inspiration for Superior Inspiration (level 18)', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      level: 18,
    });

    await handler.useTableAction('user-1', 'bard-1', {
      actionSlug: 'superior-inspiration',
    });

    expect(state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'bard-1' }),
      'bardicInspiration',
      1,
    );
  });

  it('rejects Bard actions for non-bard characters', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...bard,
      classSlug: 'fighter',
    });

    await expect(
      handler.useTableAction('user-1', 'bard-1', {
        actionSlug: 'grant-inspiration',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
