import { BadRequestException } from '@nestjs/common';
import { WizardActionsHandler } from './wizard-actions.handler';

describe('WizardActionsHandler', () => {
  const stateResponse = { classResources: [] };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    recoverSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const handler = new WizardActionsHandler(
    access as never,
    state as never,
    domain as never,
  );
  const wizard = {
    id: 'wiz-1',
    classSlug: 'wizard',
    subclassSlug: 'abjurer',
    level: 5,
    abilityScores: {
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 18,
      sabedoria: 10,
      carisma: 10,
    },
  };

  beforeEach(() => {
    jest.clearAllMocks();
    access.findAccessibleOrFail.mockResolvedValue(wizard);
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.buildResponse.mockResolvedValue(stateResponse);
    domain.getProficiencyBonus.mockResolvedValue(3);
  });

  it('recovers 1 spell slot for Arcane Recovery', async () => {
    const result = await handler.useTableAction('user-1', 'wiz-1', {
      actionSlug: 'arcane-recovery-1',
    });

    expect(state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'wiz-1' }),
      1,
    );
    expect(result.note).toContain('Recuperação Arcana');
  });

  it('calculates Arcane Ward hp for Abjurer', async () => {
    const result = await handler.useTableAction('user-1', 'wiz-1', {
      actionSlug: 'arcane-ward',
    });

    expect(result.total).toBe(14); // 2 * 5 + 4
    expect(result.note).toContain('Proteção Arcana');
  });

  it('requires level 6 for Sculpt Spells', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...wizard,
      subclassSlug: 'evoker',
      level: 3,
    });

    await expect(
      handler.useTableAction('user-1', 'wiz-1', {
        actionSlug: 'sculpt-spells',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('spends Third Eye resource for Diviner', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...wizard,
      subclassSlug: 'diviner',
      level: 10,
    });

    const result = await handler.useTableAction('user-1', 'wiz-1', {
      actionSlug: 'third-eye',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ subclassSlug: 'diviner' }),
      'third-eye',
      1,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Terceiro Olho');
  });

  it('rolls Portent dice for Diviner', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...wizard,
      subclassSlug: 'diviner',
    });

    const result = await handler.useTableAction('user-1', 'wiz-1', {
      actionSlug: 'portent',
    });

    expect(result.note).toContain('Presságio');
  });

  it('rejects Wizard actions for non-wizard characters', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...wizard,
      classSlug: 'cleric',
    });

    await expect(
      handler.useTableAction('user-1', 'wiz-1', {
        actionSlug: 'arcane-recovery-1',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
