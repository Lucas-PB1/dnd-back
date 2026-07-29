import { BadRequestException } from '@nestjs/common';
import { ClericActionsHandler } from './cleric-actions.handler';

describe('ClericActionsHandler', () => {
  const stateResponse = { classResources: [] };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const handler = new ClericActionsHandler(
    access as never,
    state as never,
    domain as never,
  );
  const cleric = {
    id: 'cleric-1',
    classSlug: 'cleric',
    subclassSlug: 'light',
    level: 7,
    abilityScores: {
      forca: 10,
      destreza: 10,
      constituicao: 14,
      inteligencia: 12,
      sabedoria: 18,
      carisma: 8,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue(cleric);
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.buildResponse.mockResolvedValue(stateResponse);
    domain.getProficiencyBonus.mockResolvedValue(3);
  });

  it('spends Channel Divinity and rolls the scaled Divine Spark', async () => {
    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'divine-spark-damage',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'channelDivinity',
      1,
    );
    expect(result.expression).toMatch(/^2d8\+4$/);
    expect(result.saveDc).toBe(15);
  });

  it('adds Sear Undead damage at level 5+', async () => {
    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'turn-undead',
    });

    expect(result.expression).toBe('4d8');
    expect(result.saveDc).toBe(15);
    expect(result.note).toContain('Fulminar');
  });

  it('rolls Radiance of Dawn for a Light Cleric', async () => {
    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'radiance-of-dawn',
    });

    expect(result.expression).toBe('2d10+7');
    expect(result.saveDc).toBe(15);
  });

  it('uses the Life Domain healing pool without rolling', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...cleric,
      subclassSlug: 'life',
      level: 9,
    });

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'preserve-life',
    });

    expect(result.total).toBe(45);
    expect(result.note).toContain('metade dos PV máximos');
  });

  it('spends War Priest uses from the subclass resource', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...cleric,
      subclassSlug: 'war',
    });

    await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'war-priest',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'war-priest',
      1,
    );
  });

  it('rejects Cleric actions for another class', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...cleric,
      classSlug: 'wizard',
    });

    await expect(
      handler.useTableAction('user-1', 'cleric-1', {
        actionSlug: 'divine-spark-heal',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
