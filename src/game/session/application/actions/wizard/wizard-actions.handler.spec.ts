import { BadRequestException } from '@nestjs/common';
import type { CatalogEffect } from '@game/effects';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { WizardActionsHandler } from './wizard-actions.handler';

const WIZARD_ECONOMY = [
  {
    id: 'wizard-arcane-recovery-1',
    name: 'Recuperação Arcana (Slot 1º)',
    economy: 'free' as const,
    classSlug: 'wizard',
    minLevel: 1,
    resourceSlug: 'arcaneRecovery',
    alwaysSpendsResource: true,
    tableAction: 'arcane-recovery-1',
    itemSlug: null,
    featSlug: null,
    description: 'Recuperação.',
  },
  {
    id: 'wizard-arcane-ward',
    name: 'Proteção Arcana',
    economy: 'free' as const,
    classSlug: 'wizard',
    subclassSlug: 'abjurer',
    minLevel: 3,
    alwaysSpendsResource: false,
    tableAction: 'arcane-ward',
    itemSlug: null,
    featSlug: null,
    description: 'Ward.',
  },
  {
    id: 'wizard-sculpt-spells',
    name: 'Esculpir Magias',
    economy: 'free' as const,
    classSlug: 'wizard',
    subclassSlug: 'evoker',
    minLevel: 6,
    alwaysSpendsResource: false,
    tableAction: 'sculpt-spells',
    itemSlug: null,
    featSlug: null,
    description: 'Esculpir.',
  },
  {
    id: 'wizard-third-eye',
    name: 'O Terceiro Olho',
    economy: 'bonus' as const,
    classSlug: 'wizard',
    subclassSlug: 'diviner',
    minLevel: 10,
    resourceSlug: 'third-eye',
    alwaysSpendsResource: true,
    tableAction: 'third-eye',
    itemSlug: null,
    featSlug: null,
    description: 'Olho.',
  },
  {
    id: 'wizard-portent',
    name: 'Rolar Presságio',
    economy: 'free' as const,
    classSlug: 'wizard',
    subclassSlug: 'diviner',
    minLevel: 3,
    alwaysSpendsResource: false,
    tableAction: 'portent',
    itemSlug: null,
    featSlug: null,
    description: 'Presságio.',
  },
];

function effect(
  partial: Partial<CatalogEffect> &
    Pick<CatalogEffect, 'kind' | 'actionSlug' | 'ownerKind'>,
): CatalogEffect {
  return {
    id: partial.id ?? `${partial.kind}-${partial.actionSlug}`,
    ownerId: '1',
    minTraitTakes: 0,
    requiresOptionKey: partial.requiresOptionKey ?? null,
    requiresOptionValue: partial.requiresOptionValue ?? null,
    spell: partial.spell ?? null,
    castEconomy: null,
    resource: null,
    combatMod: null,
    proficiency: null,
    purchaseDiscount: null,
    damageDie: null,
    weapon: null,
    feat: null,
    saveAdvantage: null,
    sense: null,
    damageType: null,
    language: null,
    checkAdvantage: null,
    reach: null,
    restQuirk: null,
    environmentalImmunity: null,
    condition: null,
    save: null,
    forcedMovement: null,
    kind: partial.kind,
    ownerKind: partial.ownerKind,
    ownerSlug:
      partial.ownerSlug ??
      (partial.ownerKind === 'subclass' ? 'abjurer' : 'wizard'),
    trigger: 'on_table_action',
    actionSlug: partial.actionSlug,
    unlockLevel: partial.unlockLevel ?? 1,
    sortOrder: partial.sortOrder ?? 1,
    label: partial.label ?? partial.actionSlug,
    resourceSlug: partial.resourceSlug ?? null,
    numeric: partial.numeric ?? null,
    note: partial.note ?? null,
    dice: partial.dice ?? null,
    combatFlag: null,
    companion: null,
  };
}

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
    stateResponse: { classResources: [], tempHp: 0 },
    defaultCharacter: wizard,
    mechanicalCatalogLoad: { economyActions: WIZARD_ECONOMY },
  });
  const effectCatalog = {
    load: jest.fn().mockResolvedValue([] as CatalogEffect[]),
  };
  let handler: WizardActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    effectCatalog.load.mockResolvedValue([]);
    handler = new WizardActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
    );
  });

  it('recovers 1 spell slot for Arcane Recovery', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'recover_spell_slot',
        actionSlug: 'arcane-recovery-1',
        ownerKind: 'class',
        spell: {
          spellId: null,
          spellSlug: null,
          optionKey: 'fixed_slot',
          spellLevel: 1,
        },
        note: { note: 'Recuperação Arcana: slot 1º.' },
      }),
    ]);

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
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'temp_hp',
        actionSlug: 'arcane-ward',
        ownerKind: 'subclass',
        ownerSlug: 'abjurer',
        numeric: { amountFormula: 'level_times_2', flat: null },
        note: { note: 'Proteção Arcana: {total} PV temp.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'wiz-1', {
      actionSlug: 'arcane-ward',
    });

    expect(result.total).toBe(14);
    expect(result.note).toContain('Proteção Arcana');
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'wiz-1' }),
      expect.objectContaining({ tempHp: 14 }),
    );
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
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'third-eye',
        ownerKind: 'subclass',
        ownerSlug: 'diviner',
        note: { note: 'O Terceiro Olho ativo.' },
      }),
    ]);

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
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_roll',
        actionSlug: 'portent',
        ownerKind: 'subclass',
        ownerSlug: 'diviner',
        numeric: { amountFormula: 'portent_d20_count', flat: null },
        note: { note: 'Presságio: [{expression}].' },
      }),
    ]);

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
