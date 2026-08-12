import { BadRequestException } from '@nestjs/common';
import { BarbarianActionsHandler } from './barbarian-actions.handler';

describe('BarbarianActionsHandler', () => {
  const stateResponse = {
    classResources: [{ slug: 'rage', remaining: 2, max: 2 }],
    tempHp: 0,
    rageActive: false,
    recklessActive: false,
  };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    })),
    martial: {
      toggleRage: jest.fn().mockImplementation(async (_c, active) => ({
        ...stateResponse,
        rageActive: active ?? true,
      })),
      toggleReckless: jest.fn().mockImplementation(async (_c, active) => ({
        ...stateResponse,
        recklessActive: active ?? true,
      })),
      recoverAllRage: jest.fn().mockResolvedValue({
        ...stateResponse,
        classResources: [{ slug: 'rage', remaining: 4, max: 4 }],
      }),
    },
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const mechanicalCatalog = { load: async () => ({ economyActions: [] }) };
  const handler = new BarbarianActionsHandler(
    access as never,
    state as never,
    domain as never,
    mechanicalCatalog as never,
  );
  const barbarian = {
    id: 'barb-1',
    classSlug: 'barbarian',
    subclassSlug: 'berserker',
    level: 5,
    abilityScores: {
      forca: 16,
      destreza: 14,
      constituicao: 14,
      inteligencia: 8,
      sabedoria: 10,
      carisma: 8,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue(barbarian);
    state.buildResponse.mockResolvedValue({ ...stateResponse });
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.martial.toggleRage.mockImplementation(async (_c, active) => ({
      ...stateResponse,
      rageActive: active ?? true,
    }));
  });

  it('toggles rage on and spends via martial', async () => {
    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'toggle-rage',
    });

    expect(state.martial.toggleRage).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      true,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Fúria ativa');
  });

  it('applies world-tree temp HP when entering rage', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...barbarian,
      subclassSlug: 'world-tree',
      level: 5,
    });

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'toggle-rage',
    });

    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      expect.objectContaining({ tempHp: 5 }),
    );
    expect(result.note).toContain('Surto de Vitalidade');
  });

  it('resolves Frenzy damage for Berserker', async () => {
    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'frenzy',
    });

    expect(result.expression).toBe('2d6');
    expect(result.note).toContain('Frenesi');
  });

  it('resolves Champion of the Gods with dice spend', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...barbarian,
      subclassSlug: 'zealot',
      level: 6,
    });

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'champion-of-the-gods',
      diceCount: 2,
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      'divine-fury-dice',
      2,
    );
    expect(result.expression).toBe('2d12');
    expect(result.note).toContain('Campeão dos Deuses');
  });

  it('enters free rage for muscle wizard without spend flag', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...barbarian,
      subclassSlug: 'path-of-the-muscle-wizard',
    });

    await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'undeniable-magic-rage',
    });

    expect(state.martial.toggleRage).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'barb-1' }),
      true,
      false,
    );
  });

  it('resolves Wild Heart Eagle while raging', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...barbarian,
      subclassSlug: 'wild-heart',
    });
    state.buildResponse.mockResolvedValueOnce({
      ...stateResponse,
      rageActive: true,
    });

    const result = await handler.useTableAction('user-1', 'barb-1', {
      actionSlug: 'wild-heart-eagle',
    });

    expect(result.note).toContain('Águia');
    expect(result.note).toContain('Correr');
  });

  it('rejects Wild Heart Eagle without rage', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...barbarian,
      subclassSlug: 'wild-heart',
    });
    state.buildResponse.mockResolvedValueOnce({
      ...stateResponse,
      rageActive: false,
    });

    await expect(
      handler.useTableAction('user-1', 'barb-1', {
        actionSlug: 'wild-heart-eagle',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects non-barbarian', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...barbarian,
      classSlug: 'fighter',
    });

    await expect(
      handler.useTableAction('user-1', 'barb-1', {
        actionSlug: 'toggle-rage',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
