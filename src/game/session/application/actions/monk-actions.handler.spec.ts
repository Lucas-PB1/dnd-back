import { BadRequestException } from '@nestjs/common';
import { MonkActionsHandler } from './monk-actions.handler';

describe('MonkActionsHandler', () => {
  const stateResponse = { classResources: [] };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const handler = new MonkActionsHandler(
    access as never,
    state as never,
    domain as never,
  );

  beforeEach(() => {
    jest.clearAllMocks();
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.buildResponse.mockResolvedValue(stateResponse);
    access.findAccessibleOrFail.mockResolvedValue({
      id: 'monk-1',
      classSlug: 'monk',
      subclassSlug: 'mercy',
      level: 5,
      abilityScores: {
        forca: 10,
        destreza: 16,
        constituicao: 12,
        inteligencia: 10,
        sabedoria: 16,
        carisma: 8,
      },
    });
  });

  it('spends a Focus point on Flurry of Blows', async () => {
    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'flurry-of-blows',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'monk-1' }),
      'focusPoints',
      1,
    );
    expect(result.resourceSpent).toBe(true);
  });

  it('exposes the Focus save DC on Stunning Strike', async () => {
    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'stunning-strike',
    });
    // 8 + WIS(3) + PB(3)
    expect(result.saveDc).toBe(14);
    expect(result.resourceSpent).toBe(true);
  });

  it('rolls healing for Hand of Healing using WIS + Martial Arts die', async () => {
    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'hand-of-healing',
    });
    expect(result.expression).toMatch(/1d8\+3/);
    expect(result.note).toContain('cure');
  });

  it('heals with Wholeness of Body using the subclass pool', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      id: 'monk-1',
      classSlug: 'monk',
      subclassSlug: 'open-hand',
      level: 6,
      abilityScores: {
        forca: 10,
        destreza: 16,
        constituicao: 12,
        inteligencia: 10,
        sabedoria: 16,
        carisma: 8,
      },
    });
    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'wholeness-of-body',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'monk-1' }),
      'wholeness-of-body',
      1,
    );
    expect(result.note).toContain('Integridade Corporal');
  });

  it('spends 2 Focus on Elemental Blast at level 6+', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      id: 'monk-1',
      classSlug: 'monk',
      subclassSlug: 'elements',
      level: 6,
      abilityScores: {
        forca: 10,
        destreza: 16,
        constituicao: 12,
        inteligencia: 10,
        sabedoria: 16,
        carisma: 8,
      },
    });
    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'elemental-blast',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'monk-1' }),
      'focusPoints',
      2,
    );
    expect(result.note).toContain('Esfera');
    expect(result.expression).toMatch(/3d8/);
  });

  it('teleports 18 m on Shadow Step', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      id: 'monk-1',
      classSlug: 'monk',
      subclassSlug: 'shadow',
      level: 6,
      abilityScores: {
        forca: 10,
        destreza: 16,
        constituicao: 12,
        inteligencia: 10,
        sabedoria: 16,
        carisma: 8,
      },
    });
    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'shadow-step',
    });
    expect(result.note).toContain('18 m');
    expect(state.useClassResource).not.toHaveBeenCalled();
  });

  it('rejects subclass actions for the wrong subclass', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      id: 'monk-1',
      classSlug: 'monk',
      subclassSlug: 'shadow',
      level: 5,
      abilityScores: {
        forca: 10,
        destreza: 16,
        constituicao: 12,
        inteligencia: 10,
        sabedoria: 16,
        carisma: 8,
      },
    });
    await expect(
      handler.useTableAction('user-1', 'monk-1', {
        actionSlug: 'hand-of-healing',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects monk actions for non-monks', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      id: 'x',
      classSlug: 'rogue',
      subclassSlug: null,
      level: 5,
      abilityScores: {
        forca: 10,
        destreza: 16,
        constituicao: 12,
        inteligencia: 10,
        sabedoria: 16,
        carisma: 8,
      },
    });
    await expect(
      handler.useTableAction('user-1', 'x', {
        actionSlug: 'flurry-of-blows',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
