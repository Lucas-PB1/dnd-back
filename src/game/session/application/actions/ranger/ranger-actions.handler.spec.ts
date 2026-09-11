import { BadRequestException } from '@nestjs/common';
import type { CatalogEffect } from '@game/effects';
import { FIXTURE_BESTIAL_ASPECT_BENEFITS } from '@game/combat/domain/__fixtures__/mechanical-catalog';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { RangerActionsHandler } from './ranger-actions.handler';

const RANGER_ECONOMY = [
  {
    id: 'ranger-hunters-mark',
    name: 'Marca do Predador (gratuita)',
    economy: 'bonus' as const,
    classSlug: 'ranger',
    minLevel: 1,
    resourceSlug: 'favoredEnemy',
    alwaysSpendsResource: true,
    tableAction: 'hunters-mark-free',
    itemSlug: null,
    featSlug: null,
    description: 'Marca gratuita.',
  },
  {
    id: 'ranger-tireless',
    name: 'Incansável',
    economy: 'action' as const,
    classSlug: 'ranger',
    minLevel: 10,
    resourceSlug: 'tireless',
    alwaysSpendsResource: true,
    tableAction: 'tireless',
    itemSlug: null,
    featSlug: null,
    description: 'PV temp.',
  },
  {
    id: 'ranger-natures-veil',
    name: 'Véu da Natureza',
    economy: 'bonus' as const,
    classSlug: 'ranger',
    minLevel: 14,
    resourceSlug: 'naturesVeil',
    alwaysSpendsResource: true,
    tableAction: 'natures-veil',
    itemSlug: null,
    featSlug: null,
    description: 'Invisível.',
  },
  {
    id: 'ranger-hunter-defense',
    name: 'Defesa do Caçador Superior',
    economy: 'reaction' as const,
    classSlug: 'ranger',
    subclassSlug: 'hunter',
    minLevel: 15,
    tableAction: 'hunter-defense',
    itemSlug: null,
    featSlug: null,
    description: 'Defesa.',
  },
  {
    id: 'ranger-gloom-stalker-dodge',
    name: 'Esquiva Sombria',
    economy: 'reaction' as const,
    classSlug: 'ranger',
    subclassSlug: 'gloom-stalker',
    minLevel: 15,
    tableAction: 'gloom-stalker-dodge',
    itemSlug: null,
    featSlug: null,
    description: 'Esquiva.',
  },
  {
    id: 'ranger-primal-companion',
    name: 'Companheiro Primal',
    economy: 'bonus' as const,
    classSlug: 'ranger',
    subclassSlug: 'beast-master',
    minLevel: 3,
    tableAction: 'primal-companion',
    itemSlug: null,
    featSlug: null,
    description: 'Comando.',
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
      (partial.ownerKind === 'subclass' ? 'hunter' : 'ranger'),
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

describe('RangerActionsHandler', () => {
  const ranger = createTestCharacter({
    id: 'ranger-1',
    classSlug: 'ranger',
    subclassSlug: 'hunter',
    level: 10,
    abilityScores: createTestAbilityScores({
      forca: 12,
      destreza: 16,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 16,
      carisma: 8,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: {
      concentratingOn: 'marca-do-predador',
      tempHp: 0,
    },
    defaultCharacter: ranger,
    mechanicalCatalogLoad: {
      economyActions: RANGER_ECONOMY,
      beastborneAspectBenefits: [...FIXTURE_BESTIAL_ASPECT_BENEFITS],
    },
  });
  const syncCompanion = { execute: jest.fn().mockResolvedValue(undefined) };
  const dataSource = { query: jest.fn() };
  const effectCatalog = {
    load: jest.fn().mockResolvedValue([] as CatalogEffect[]),
  };
  let handler: RangerActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    effectCatalog.load.mockResolvedValue([]);
    ctx.state.martial.setBestialAspectLevel = jest
      .fn()
      .mockResolvedValue(ctx.stateResponse);
    handler = new RangerActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
      asHandlerDep(syncCompanion),
      asHandlerDep(dataSource),
    );
  });

  it('spends Favored Enemy and concentrates on Hunter\'s Mark', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'start_concentration',
        actionSlug: 'hunters-mark-free',
        ownerKind: 'class',
        spell: { spellId: '1', spellSlug: 'marca-do-predador', optionKey: null, spellLevel: null },
        note: { note: 'Marca do Predador conjurada.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'hunters-mark-free',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      'favoredEnemy',
      1,
    );
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      { concentratingOn: 'marca-do-predador' },
    );
    expect(result.resourceSpent).toBe(true);
  });

  it('rolls temporary HP for Tireless using WIS', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'temp_hp',
        actionSlug: 'tireless',
        ownerKind: 'class',
        unlockLevel: 10,
        dice: { die: '1d8', dieAtLevel: null, atLevel: null, damageTypeSlug: null },
        numeric: { amountFormula: 'ability_mod', flat: null },
        note: {
          note: 'Incansável: {total} PV temporários ({expression}).',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'tireless',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      'tireless',
      1,
    );
    expect(result.expression).toMatch(/1d8\+3/);
    expect(result.note).toContain('PV temporários');
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'ranger-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
  });

  it('rejects Nature\'s Veil below level 14', async () => {
    await expect(
      handler.useTableAction('user-1', 'ranger-1', {
        actionSlug: 'natures-veil',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects subclass actions for the wrong subclass', async () => {
    await expect(
      handler.useTableAction('user-1', 'ranger-1', {
        actionSlug: 'primal-companion',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('resolves Hunter Superior Defense note at level 15', async () => {
    ctx.mockCharacterOnce({
      ...ranger,
      subclassSlug: 'hunter',
      level: 15,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'hunter-defense',
        ownerKind: 'subclass',
        ownerSlug: 'hunter',
        unlockLevel: 15,
        note: { note: 'Defesa do Caçador Superior.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'hunter-defense',
    });

    expect(result.resourceSpent).toBe(false);
    expect(result.note).toContain('Defesa do Caçador');
  });

  it('resolves Gloom Stalker Shadowy Dodge note at level 15', async () => {
    ctx.mockCharacterOnce({
      ...ranger,
      subclassSlug: 'gloom-stalker',
      level: 15,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'gloom-stalker-dodge',
        ownerKind: 'subclass',
        ownerSlug: 'gloom-stalker',
        unlockLevel: 15,
        note: { note: 'Esquiva Sombria.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'ranger-1', {
      actionSlug: 'gloom-stalker-dodge',
    });

    expect(result.note).toContain('Esquiva Sombria');
  });

  it('rejects ranger actions for non-rangers', async () => {
    ctx.mockCharacterOnce({ ...ranger, classSlug: 'fighter' });
    await expect(
      handler.useTableAction('user-1', 'ranger-1', {
        actionSlug: 'hunters-mark-free',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
