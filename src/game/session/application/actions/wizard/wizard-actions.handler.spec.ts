import { BadRequestException } from '@nestjs/common';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { WizardActionsHandler } from './wizard-actions.handler';

describe('WizardActionsHandler', () => {
  const wizard = createTestCharacter({
    id: 'wiz-1',
    classSlug: 'wizard',
    subclassSlug: 'abjurer',
    abilityScores: createTestAbilityScores({
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 18,
      sabedoria: 10,
      carisma: 10,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: { classResources: [] },
    defaultCharacter: wizard,
  });
  const handler = new WizardActionsHandler(
    asHandlerDep(ctx.access),
    asHandlerDep(ctx.state),
    asHandlerDep(ctx.domain),
    asHandlerDep(ctx.mechanicalCatalog),
  );

  beforeEach(() => {
    ctx.resetMocks();
  });

  it('recovers 1 spell slot for Arcane Recovery', async () => {
    const result = await handler.useTableAction('user-1', 'wiz-1', {
      actionSlug: 'arcane-recovery-1',
    });

    expect(ctx.state.recoverSpellSlotLevel).toHaveBeenCalledWith(
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
    ctx.mockCharacterOnce({
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
    ctx.mockCharacterOnce({
      ...wizard,
      subclassSlug: 'diviner',
      level: 10,
    });

    const result = await handler.useTableAction('user-1', 'wiz-1', {
      actionSlug: 'third-eye',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ subclassSlug: 'diviner' }),
      'third-eye',
      1,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Terceiro Olho');
  });

  it('rolls Portent dice for Diviner', async () => {
    ctx.mockCharacterOnce({
      ...wizard,
      subclassSlug: 'diviner',
    });

    const result = await handler.useTableAction('user-1', 'wiz-1', {
      actionSlug: 'portent',
    });

    expect(result.note).toContain('Presságio');
  });

  it('rejects Wizard actions for non-wizard characters', async () => {
    ctx.mockCharacterOnce({
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
