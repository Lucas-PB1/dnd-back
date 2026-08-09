import { BadRequestException } from '@nestjs/common';
import { FIXTURE_BESTIAL_ASPECT_BENEFITS } from '@game/combat/domain/__fixtures__/mechanical-catalog.fixtures';
import { RangerActionsHandler } from './ranger-actions.handler';

describe('RangerActionsHandler', () => {
  const stateResponse = {
    classResources: [],
    concentratingOn: 'marca-do-predador',
  };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    patch: jest.fn().mockResolvedValue(stateResponse),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
  };
  const mechanicalCatalog = {
    load: async () => ({
      gunslingerManeuvers: [],
      battleMasterManeuvers: [],
      cunningStrikeEffects: [],
      tableActions: [],
      personaMasks: [],
      personaMaskSlugs: [],
      beastborneAspectBenefits: [...FIXTURE_BESTIAL_ASPECT_BENEFITS],
      dungeoneerSlayerLabels: [],
      precautionSpells: [],
      economyActions: [],
      panelActions: [],
    }),
  };
  const handler = new RangerActionsHandler(
    access as never,
    state as never,
    mechanicalCatalog as never,
  );

  const ranger = {
    id: 'ranger-1',
    classSlug: 'ranger',
    subclassSlug: 'hunter',
    level: 10,
    abilityScores: {
      forca: 12,
      destreza: 16,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 16,
      carisma: 8,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.patch.mockResolvedValue(stateResponse);
    access.findAccessibleOrFail.mockResolvedValue(ranger);
  });

  it('spends Favored Enemy and concentrates on Hunter\'s Mark', async () => {
    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'hunters-mark-free',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      'favoredEnemy',
      1,
    );
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      { concentratingOn: 'marca-do-predador' },
    );
    expect(result.resourceSpent).toBe(true);
  });

  it('rolls temporary HP for Tireless using WIS', async () => {
    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'tireless',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      'tireless',
      1,
    );
    expect(result.expression).toMatch(/1d8\+3/);
    expect(result.note).toContain('PV temporários');
  });

  it('rejects Nature\'s Veil below level 14', async () => {
    await expect(
      handler.useTableAction('user-1', 'ranger-1', {
        actionSlug: 'natures-veil',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects subclass actions for the wrong subclass', async () => {
    await expect(
      handler.useTableAction('user-1', 'ranger-1', {
        actionSlug: 'primal-companion',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects ranger actions for non-rangers', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...ranger,
      classSlug: 'fighter',
    });
    await expect(
      handler.useTableAction('user-1', 'ranger-1', {
        actionSlug: 'hunters-mark-free',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
