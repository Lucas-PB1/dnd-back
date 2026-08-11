import { BadRequestException } from '@nestjs/common';
import { PaladinActionsHandler } from './paladin-actions.handler';

describe('PaladinActionsHandler', () => {
  const stateResponse = { classResources: [], tempHp: 0 };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
    patch: jest.fn().mockResolvedValue({ ...stateResponse, tempHp: 12 }),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const handler = new PaladinActionsHandler(
    access as never,
    state as never,
    domain as never,
  );

  const paladin = {
    id: 'pal-1',
    classSlug: 'paladin',
    subclassSlug: 'vengeance',
    level: 9,
    abilityScores: {
      forca: 16,
      destreza: 10,
      constituicao: 14,
      inteligencia: 8,
      sabedoria: 10,
      carisma: 18,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.buildResponse.mockResolvedValue(stateResponse);
    state.patch.mockImplementation(async (_c, dto) => ({
      ...stateResponse,
      ...dto,
    }));
    access.findAccessibleOrFail.mockResolvedValue(paladin);
  });

  it('spends the requested amount from the Lay on Hands pool', async () => {
    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'lay-on-hands',
      amount: 7,
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'layOnHands',
      7,
    );
    expect(result.total).toBe(7);
    expect(result.resourceSpent).toBe(true);
  });

  it('spends 5 points to cure poison', async () => {
    await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'cure-poison',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'layOnHands',
      5,
    );
  });

  it('spends a Channel Divinity use on Divine Sense', async () => {
    await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'divine-sense',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'channelDivinity',
      1,
    );
  });

  it('exposes the paladin save DC on Abjure Enemies', async () => {
    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'abjure-enemies',
    });
    // 8 + CHA(4) + PB(3)
    expect(result.saveDc).toBe(15);
    expect(result.resourceSpent).toBe(true);
  });

  it('rejects Abjure Enemies below level 9', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...paladin,
      level: 8,
    });
    await expect(
      handler.useTableAction('user-1', 'pal-1', {
        actionSlug: 'abjure-enemies',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('spends Channel Divinity on oath channel with subclass note', async () => {
    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'oath-channel',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'channelDivinity',
      1,
    );
    expect(result.actionName).toBe('Voto de Inimizade');
    expect(result.resourceSpent).toBe(true);
  });

  it('rolls temp HP pool on Inspiring Smite for Glory', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...paladin,
      subclassSlug: 'glory',
      level: 5,
    });
    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'inspiring-smite',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'channelDivinity',
      1,
    );
    expect(result.actionName).toBe('Destruição Inspiradora');
    expect(result.expression).toMatch(/^2d8\+5$/);
    expect(result.total).toBeGreaterThanOrEqual(7);
    expect(state.patch).toHaveBeenCalledWith(
      expect.anything(),
      expect.objectContaining({ tempHp: result.total }),
    );
  });

  it('routes Glory oath-channel to Inspiring Smite', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...paladin,
      subclassSlug: 'glory',
      level: 5,
    });
    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'oath-channel',
    });
    expect(result.actionName).toBe('Destruição Inspiradora');
    expect(result.expression).toMatch(/^2d8\+5$/);
  });

  it('spends Channel Divinity on Peerless Athlete for Glory', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...paladin,
      subclassSlug: 'glory',
      level: 3,
    });
    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'peerless-athlete',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'channelDivinity',
      1,
    );
    expect(result.actionName).toBe('Atleta Inigualável');
    expect(result.note).toContain('Atletismo');
  });

  it('rejects Peerless Athlete for non-Glory oaths', async () => {
    await expect(
      handler.useTableAction('user-1', 'pal-1', {
        actionSlug: 'peerless-athlete',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('spends Glorious Defense pool for Glory L15+', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...paladin,
      subclassSlug: 'glory',
      level: 15,
      abilityScores: { ...paladin.abilityScores, carisma: 18 },
    });
    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'glorious-defense',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'glorious-defense',
      1,
    );
    expect(result.actionName).toBe('Defesa Gloriosa');
    expect(result.note).toContain('+4 CA');
  });

  it('rejects Glorious Defense below level 15', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...paladin,
      subclassSlug: 'glory',
      level: 10,
    });
    await expect(
      handler.useTableAction('user-1', 'pal-1', {
        actionSlug: 'glorious-defense',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('spends Undying Sentinel and reports 1 + 3×level HP', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...paladin,
      subclassSlug: 'ancients',
      level: 15,
      hitPointsCurrent: 0,
      hitPointsMax: 120,
    });
    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'undying-sentinel',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'undying-sentinel',
      1,
    );
    expect(state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      { deathSaveSuccesses: 0, deathSaveFailures: 0 },
    );
    expect(result.actionName).toBe('Sentinela Imortal');
    expect(result.total).toBe(46);
    expect(result.note).toContain('46');
  });

  it('spends Reveler pool for Oath of Revelry L15+', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...paladin,
      subclassSlug: 'oath-of-revelry',
      level: 15,
    });
    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'reveler',
    });
    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'reveler',
      1,
    );
    expect(result.actionName).toBe('Folião');
  });

  it('rejects paladin actions for non-paladins', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...paladin,
      classSlug: 'cleric',
    });
    await expect(
      handler.useTableAction('user-1', 'pal-1', {
        actionSlug: 'lay-on-hands',
        amount: 1,
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
