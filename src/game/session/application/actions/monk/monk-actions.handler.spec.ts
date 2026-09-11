import { BadRequestException } from '@nestjs/common';
import type { CatalogEffect } from '@game/effects';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { MonkActionsHandler } from './monk-actions.handler';

const MONK_ECONOMY = [
  {
    id: 'monk-flurry',
    name: 'Torrente de Golpes',
    economy: 'bonus' as const,
    classSlug: 'monk',
    minLevel: 2,
    resourceSlug: 'focusPoints',
    alwaysSpendsResource: true,
    tableAction: 'flurry-of-blows',
    itemSlug: null,
    featSlug: null,
    description: 'Torrente.',
  },
  {
    id: 'monk-stunning-strike',
    name: 'Golpe Atordoante',
    economy: 'free' as const,
    classSlug: 'monk',
    minLevel: 5,
    resourceSlug: 'focusPoints',
    alwaysSpendsResource: true,
    tableAction: 'stunning-strike',
    itemSlug: null,
    featSlug: null,
    description: 'Atordoante.',
  },
  {
    id: 'monk-hand-of-healing',
    name: 'Mão de Cura',
    economy: 'action' as const,
    classSlug: 'monk',
    subclassSlug: 'mercy',
    minLevel: 3,
    resourceSlug: 'focusPoints',
    alwaysSpendsResource: true,
    tableAction: 'hand-of-healing',
    itemSlug: null,
    featSlug: null,
    description: 'Cura.',
  },
  {
    id: 'monk-wholeness-of-body',
    name: 'Integridade Corporal',
    economy: 'bonus' as const,
    classSlug: 'monk',
    subclassSlug: 'open-hand',
    minLevel: 6,
    resourceSlug: 'wholeness-of-body',
    alwaysSpendsResource: true,
    tableAction: 'wholeness-of-body',
    itemSlug: null,
    featSlug: null,
    description: 'Cura.',
  },
  {
    id: 'monk-elemental-blast',
    name: 'Explosão Elemental',
    economy: 'action' as const,
    classSlug: 'monk',
    subclassSlug: 'elements',
    minLevel: 6,
    resourceSlug: 'focusPoints',
    alwaysSpendsResource: true,
    spendAmount: 2,
    tableAction: 'elemental-blast',
    itemSlug: null,
    featSlug: null,
    description: 'Blast.',
  },
  {
    id: 'monk-shadow-step',
    name: 'Passo da Sombra',
    economy: 'bonus' as const,
    classSlug: 'monk',
    subclassSlug: 'shadow',
    minLevel: 6,
    tableAction: 'shadow-step',
    itemSlug: null,
    featSlug: null,
    description: 'Teleporte.',
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
    spell: null,
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
      (partial.ownerKind === 'subclass' ? 'mercy' : 'monk'),
    trigger: 'on_table_action',
    actionSlug: partial.actionSlug,
    unlockLevel: partial.unlockLevel ?? 1,
    sortOrder: partial.sortOrder ?? 1,
    label: partial.label ?? partial.actionSlug,
    resourceSlug: partial.resourceSlug ?? null,
    numeric: partial.numeric ?? null,
    note: partial.note ?? null,
    dice: partial.dice ?? null,
    combatFlag: partial.combatFlag ?? null,
    companion: partial.companion ?? null,
  };
}

describe('MonkActionsHandler', () => {
  const monkScores = createTestAbilityScores({
    forca: 10,
    destreza: 16,
    constituicao: 12,
    inteligencia: 10,
    sabedoria: 16,
    carisma: 8,
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: { classResources: [] },
    defaultCharacter: createTestCharacter({
      id: 'monk-1',
      classSlug: 'monk',
      subclassSlug: 'mercy',
      level: 5,
      abilityScores: monkScores,
    }),
    mechanicalCatalogLoad: { economyActions: MONK_ECONOMY },
  });
  const effectCatalog = {
    load: jest.fn().mockResolvedValue([] as CatalogEffect[]),
  };
  let handler: MonkActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    effectCatalog.load.mockResolvedValue([]);
    handler = new MonkActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
    );
  });

  it('spends a Focus point on Flurry of Blows', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'flurry-of-blows',
        ownerKind: 'class',
        unlockLevel: 2,
        note: { note: 'Torrente de Golpes.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'flurry-of-blows',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'monk-1' }),
      'focusPoints',
      1,
    );
    expect(result.resourceSpent).toBe(true);
  });

  it('exposes the Focus save DC on Stunning Strike', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'feature_dc',
        actionSlug: 'stunning-strike',
        ownerKind: 'class',
        unlockLevel: 5,
        sortOrder: 1,
        numeric: { amountFormula: 'eight_plus_mod_plus_pb', flat: null },
      }),
      effect({
        kind: 'table_note',
        actionSlug: 'stunning-strike',
        ownerKind: 'class',
        unlockLevel: 5,
        sortOrder: 2,
        note: { note: 'CD {saveDc}.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'stunning-strike',
    });

    expect(result.saveDc).toBe(14);
    expect(result.resourceSpent).toBe(true);
  });

  it('rolls healing for Hand of Healing using WIS + Martial Arts die', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'heal',
        actionSlug: 'hand-of-healing',
        ownerKind: 'subclass',
        ownerSlug: 'mercy',
        unlockLevel: 3,
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: { note: 'cure {total} PV ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'hand-of-healing',
    });

    expect(result.expression).toMatch(/1d8\+3/);
    expect(result.note).toContain('cure');
    expect(ctx.state.applyCurrentHitPoints).toHaveBeenCalled();
  });

  it('heals with Wholeness of Body using the subclass pool', async () => {
    ctx.mockCharacterOnce({
      subclassSlug: 'open-hand',
      level: 6,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'heal',
        actionSlug: 'wholeness-of-body',
        ownerKind: 'subclass',
        ownerSlug: 'open-hand',
        unlockLevel: 6,
        numeric: { amountFormula: 'schedule_die_plus_flat', flat: null },
        note: { note: 'Integridade Corporal: {total} PV.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'wholeness-of-body',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'monk-1' }),
      'wholeness-of-body',
      1,
    );
    expect(result.note).toContain('Integridade Corporal');
    expect(ctx.state.applyCurrentHitPoints).toHaveBeenCalled();
  });

  it('spends 2 Focus on Elemental Blast at level 6+', async () => {
    ctx.mockCharacterOnce({
      subclassSlug: 'elements',
      level: 6,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'feature_dc',
        actionSlug: 'elemental-blast',
        ownerKind: 'subclass',
        ownerSlug: 'elements',
        unlockLevel: 6,
        sortOrder: 1,
        numeric: { amountFormula: 'eight_plus_mod_plus_pb', flat: null },
      }),
      effect({
        kind: 'table_roll',
        actionSlug: 'elemental-blast',
        ownerKind: 'subclass',
        ownerSlug: 'elements',
        unlockLevel: 6,
        sortOrder: 2,
        numeric: { amountFormula: 'dice_3d_schedule', flat: null },
        note: { note: 'Esfera {total} ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'elemental-blast',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'monk-1' }),
      'focusPoints',
      2,
    );
    expect(result.note).toContain('Esfera');
    expect(result.expression).toMatch(/3d8/);
  });

  it('teleports 18 m on Shadow Step', async () => {
    ctx.mockCharacterOnce({
      subclassSlug: 'shadow',
      level: 6,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'shadow-step',
        ownerKind: 'subclass',
        ownerSlug: 'shadow',
        unlockLevel: 6,
        note: { note: 'teleporte até 18 m.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'monk-1', {
      actionSlug: 'shadow-step',
    });

    expect(result.note).toContain('18 m');
    expect(ctx.state.useClassResource).not.toHaveBeenCalled();
  });

  it('rejects subclass actions for the wrong subclass', async () => {
    ctx.mockCharacterOnce({
      subclassSlug: 'shadow',
      level: 5,
    });
    await expect(
      handler.useTableAction('user-1', 'monk-1', {
        actionSlug: 'hand-of-healing',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects monk actions for non-monks', async () => {
    ctx.mockCharacterOnce({
      id: 'x',
      classSlug: 'rogue',
      subclassSlug: null,
    });
    await expect(
      handler.useTableAction('user-1', 'x', {
        actionSlug: 'flurry-of-blows',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
