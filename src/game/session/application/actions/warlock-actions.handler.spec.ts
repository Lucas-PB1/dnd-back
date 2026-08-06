import { BadRequestException } from '@nestjs/common';
import { WarlockActionsHandler } from './warlock-actions.handler';

describe('WarlockActionsHandler', () => {
  const stateResponse = { classResources: [] };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    recoverSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const handler = new WarlockActionsHandler(
    access as never,
    state as never,
    domain as never,
  );
  const warlock = {
    id: 'war-1',
    classSlug: 'warlock',
    subclassSlug: 'fiend',
    level: 5,
    abilityScores: {
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 18,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue(warlock);
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.buildResponse.mockResolvedValue(stateResponse);
    domain.getProficiencyBonus.mockResolvedValue(3);
  });

  it('recovers 1 pact slot for Magical Cunning', async () => {
    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'magical-cunning',
    });

    expect(state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'war-1' }),
      3,
    );
    expect(result.note).toContain('Contato Arcano');
  });

  it('rolls 1d10 for Dark One’s Own Luck (Fiend)', async () => {
    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'dark-ones-own-luck',
    });

    expect(result.expression).toBe('1d10');
    expect(result.note).toContain('Sorte do Próprio Inferno');
  });

  it('resolves Healing Light for Celestial Warlock', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      subclassSlug: 'celestial',
    });

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'healing-light',
    });

    expect(result.expression).toBe('4d6');
    expect(result.note).toContain('Luz Curativa');
  });

  it('rejects Warlock actions for non-warlock characters', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      classSlug: 'sorcerer',
    });

    await expect(
      handler.useTableAction('user-1', 'war-1', {
        actionSlug: 'magical-cunning',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
