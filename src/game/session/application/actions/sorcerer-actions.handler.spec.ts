import { BadRequestException } from '@nestjs/common';
import { SorcererActionsHandler } from './sorcerer-actions.handler';

describe('SorcererActionsHandler', () => {
  const stateResponse = { classResources: [] };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    consumeSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    recoverSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const handler = new SorcererActionsHandler(
    access as never,
    state as never,
    domain as never,
  );
  const sorcerer = {
    id: 'sorc-1',
    classSlug: 'sorcerer',
    subclassSlug: 'wild-magic',
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
    access.findAccessibleOrFail.mockResolvedValue(sorcerer);
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.buildResponse.mockResolvedValue(stateResponse);
    domain.getProficiencyBonus.mockResolvedValue(3);
  });

  it('converts level 1 spell slot to 1 sorcery point', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'convert-slot-1-to-points',
    });

    expect(state.consumeSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      1,
    );
    expect(state.recoverClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      1,
    );
    expect(result.note).toContain('consumiu 1 Slot de 1º círculo');
  });

  it('converts sorcery points to level 1 spell slot (cost 2 points)', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'convert-points-to-slot-1',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      2,
    );
    expect(state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      1,
    );
    expect(result.note).toContain('gastou 2 Pontos de Feitiçaria');
  });

  it('spends sorcery points for Metamagic', async () => {
    const result = await handler.useTableAction('user-1', 'sorc-1', {
      actionSlug: 'use-metamagic-1',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'sorc-1' }),
      'sorceryPoints',
      1,
    );
    expect(result.actionName).toContain('Metamágica');
  });

  it('rejects Sorcerer actions for non-sorcerer characters', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...sorcerer,
      classSlug: 'cleric',
    });

    await expect(
      handler.useTableAction('user-1', 'sorc-1', {
        actionSlug: 'convert-slot-1-to-points',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
