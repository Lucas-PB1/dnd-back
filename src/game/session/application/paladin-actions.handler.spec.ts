import { BadRequestException } from '@nestjs/common';
import { PaladinActionsHandler } from './paladin-actions.handler';

describe('PaladinActionsHandler', () => {
  const stateResponse = { classResources: [] };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
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
