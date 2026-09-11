import { BadRequestException } from '@nestjs/common';
import type { CatalogEffect } from '@game/effects';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { PaladinActionsHandler } from './paladin-actions.handler';

const PALADIN_ECONOMY = [
  {
    id: 'paladin-lay-on-hands',
    name: 'Mãos Consagradas',
    economy: 'bonus' as const,
    classSlug: 'paladin',
    minLevel: 1,
    resourceSlug: 'layOnHands',
    alwaysSpendsResource: false,
    tableAction: 'lay-on-hands',
    itemSlug: null,
    featSlug: null,
    description: 'Cura da reserva.',
  },
  {
    id: 'paladin-cure-poison',
    name: 'Mãos Consagradas — Curar Veneno',
    economy: 'bonus' as const,
    classSlug: 'paladin',
    minLevel: 1,
    resourceSlug: 'layOnHands',
    alwaysSpendsResource: true,
    spendAmount: 5,
    tableAction: 'cure-poison',
    itemSlug: null,
    featSlug: null,
    description: 'Curar veneno.',
  },
  {
    id: 'paladin-divine-sense',
    name: 'Sentido Divino',
    economy: 'bonus' as const,
    classSlug: 'paladin',
    minLevel: 3,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'divine-sense',
    itemSlug: null,
    featSlug: null,
    description: 'Sentido.',
  },
  {
    id: 'paladin-abjure-enemies',
    name: 'Repudiar Inimigos',
    economy: 'action' as const,
    classSlug: 'paladin',
    minLevel: 9,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'abjure-enemies',
    itemSlug: null,
    featSlug: null,
    description: 'Repudiar.',
  },
  {
    id: 'paladin-vow-of-enmity',
    name: 'Voto de Inimizade',
    economy: 'free' as const,
    classSlug: 'paladin',
    subclassSlug: 'vengeance',
    minLevel: 3,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'oath-channel',
    itemSlug: null,
    featSlug: null,
    description: 'Voto.',
  },
  {
    id: 'paladin-inspiring-smite',
    name: 'Destruição Inspiradora',
    economy: 'bonus' as const,
    classSlug: 'paladin',
    subclassSlug: 'glory',
    minLevel: 3,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'inspiring-smite',
    itemSlug: null,
    featSlug: null,
    description: 'Inspiradora.',
  },
  {
    id: 'paladin-peerless-athlete',
    name: 'Atleta Inigualável',
    economy: 'bonus' as const,
    classSlug: 'paladin',
    subclassSlug: 'glory',
    minLevel: 3,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'peerless-athlete',
    itemSlug: null,
    featSlug: null,
    description: 'Atleta.',
  },
  {
    id: 'paladin-glorious-defense',
    name: 'Defesa Gloriosa',
    economy: 'reaction' as const,
    classSlug: 'paladin',
    subclassSlug: 'glory',
    minLevel: 15,
    resourceSlug: 'glorious-defense',
    alwaysSpendsResource: true,
    tableAction: 'glorious-defense',
    itemSlug: null,
    featSlug: null,
    description: 'Defesa.',
  },
  {
    id: 'paladin-undying-sentinel',
    name: 'Sentinela Imortal',
    economy: 'free' as const,
    classSlug: 'paladin',
    subclassSlug: 'ancients',
    minLevel: 15,
    resourceSlug: 'undying-sentinel',
    alwaysSpendsResource: true,
    tableAction: 'undying-sentinel',
    itemSlug: null,
    featSlug: null,
    description: 'Sentinela.',
  },
  {
    id: 'paladin-reveler',
    name: 'Folião',
    economy: 'reaction' as const,
    classSlug: 'paladin',
    subclassSlug: 'oath-of-revelry',
    minLevel: 15,
    resourceSlug: 'reveler',
    alwaysSpendsResource: true,
    tableAction: 'reveler',
    itemSlug: null,
    featSlug: null,
    description: 'Folião.',
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
      (partial.ownerKind === 'subclass' ? 'vengeance' : 'paladin'),
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

describe('PaladinActionsHandler', () => {
  const paladin = createTestCharacter({
    id: 'pal-1',
    classSlug: 'paladin',
    subclassSlug: 'vengeance',
    level: 9,
    abilityScores: createTestAbilityScores({
      forca: 16,
      destreza: 10,
      constituicao: 14,
      inteligencia: 8,
      sabedoria: 10,
      carisma: 18,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: { tempHp: 0 },
    defaultCharacter: paladin,
    proficiencyBonus: 3,
    mechanicalCatalogLoad: { economyActions: PALADIN_ECONOMY },
  });
  const effectCatalog = {
    load: jest.fn().mockResolvedValue([] as CatalogEffect[]),
  };
  let handler: PaladinActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    effectCatalog.load.mockResolvedValue([]);
    handler = new PaladinActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
    );
  });

  it('spends the requested amount from the Lay on Hands pool and heals', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'heal',
        actionSlug: 'lay-on-hands',
        ownerKind: 'class',
        note: { note: 'Mãos Consagradas: cure {total} PV.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'lay-on-hands',
      amount: 7,
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'layOnHands',
      7,
    );
    expect(result.total).toBe(7);
    expect(result.resourceSpent).toBe(true);
    expect(ctx.state.applyCurrentHitPoints).toHaveBeenCalled();
  });

  it('spends 5 points to cure poison', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'cure-poison',
        ownerKind: 'class',
        note: { note: 'Curar veneno.' },
      }),
    ]);

    await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'cure-poison',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'layOnHands',
      5,
    );
  });

  it('spends a Channel Divinity use on Divine Sense', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'divine-sense',
        ownerKind: 'class',
        unlockLevel: 3,
        note: { note: 'Sentido Divino.' },
      }),
    ]);

    await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'divine-sense',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'channelDivinity',
      1,
    );
  });

  it('exposes the paladin save DC on Abjure Enemies', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'feature_dc',
        actionSlug: 'abjure-enemies',
        ownerKind: 'class',
        unlockLevel: 9,
        sortOrder: 1,
        numeric: { amountFormula: 'eight_plus_mod_plus_pb', flat: null },
      }),
      effect({
        kind: 'table_note',
        actionSlug: 'abjure-enemies',
        ownerKind: 'class',
        unlockLevel: 9,
        sortOrder: 2,
        note: { note: 'Repudiar CD {saveDc}.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'abjure-enemies',
    });

    expect(result.saveDc).toBe(16);
    expect(result.resourceSpent).toBe(true);
  });

  it('rejects Abjure Enemies below level 9', async () => {
    ctx.mockCharacterOnce({ ...paladin, level: 8 });
    await expect(
      handler.useTableAction('user-1', 'pal-1', {
        actionSlug: 'abjure-enemies',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('spends Channel Divinity on oath channel with subclass note', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'feature_dc',
        actionSlug: 'oath-channel',
        ownerKind: 'subclass',
        ownerSlug: 'vengeance',
        unlockLevel: 3,
        sortOrder: 1,
        numeric: { amountFormula: 'eight_plus_mod_plus_pb', flat: null },
      }),
      effect({
        kind: 'table_note',
        actionSlug: 'oath-channel',
        ownerKind: 'subclass',
        ownerSlug: 'vengeance',
        unlockLevel: 3,
        sortOrder: 2,
        note: { note: 'Voto de Inimizade.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'oath-channel',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'channelDivinity',
      1,
    );
    expect(result.actionName).toBe('Voto de Inimizade');
    expect(result.resourceSpent).toBe(true);
  });

  it('rolls temp HP pool on Inspiring Smite for Glory', async () => {
    ctx.mockCharacterOnce({
      ...paladin,
      subclassSlug: 'glory',
      level: 5,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'temp_hp',
        actionSlug: 'inspiring-smite',
        ownerKind: 'subclass',
        ownerSlug: 'glory',
        unlockLevel: 3,
        numeric: { amountFormula: 'dice_2d8_plus_level', flat: null },
        note: {
          note: 'Destruição Inspiradora: {total} PV temp. ({expression}).',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'inspiring-smite',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'channelDivinity',
      1,
    );
    expect(result.actionName).toBe('Destruição Inspiradora');
    expect(result.expression).toMatch(/^2d8\+5$/);
    expect(result.total).toBeGreaterThanOrEqual(7);
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.anything(),
      expect.objectContaining({ tempHp: result.total }),
    );
  });

  it('spends Channel Divinity on Peerless Athlete for Glory', async () => {
    ctx.mockCharacterOnce({
      ...paladin,
      subclassSlug: 'glory',
      level: 3,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'peerless-athlete',
        ownerKind: 'subclass',
        ownerSlug: 'glory',
        unlockLevel: 3,
        note: { note: 'Atleta Inigualável: Atletismo.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'peerless-athlete',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
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
    ctx.mockCharacterOnce({
      ...paladin,
      subclassSlug: 'glory',
      level: 15,
      abilityScores: { ...paladin.abilityScores, carisma: 18 },
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'glorious-defense',
        ownerKind: 'subclass',
        ownerSlug: 'glory',
        unlockLevel: 15,
        numeric: { amountFormula: 'ability_mod', flat: null },
        note: { note: 'Defesa Gloriosa: +{total} CA.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'glorious-defense',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'glorious-defense',
      1,
    );
    expect(result.actionName).toBe('Defesa Gloriosa');
    expect(result.note).toContain('+4 CA');
  });

  it('rejects Glorious Defense below level 15', async () => {
    ctx.mockCharacterOnce({
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
    ctx.mockCharacterOnce({
      ...paladin,
      subclassSlug: 'ancients',
      level: 15,
      hitPointsCurrent: 0,
      hitPointsMax: 120,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'survive_at_zero',
        actionSlug: 'undying-sentinel',
        ownerKind: 'subclass',
        ownerSlug: 'ancients',
        unlockLevel: 15,
        note: { note: 'Sentinela Imortal: {total} PV.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'undying-sentinel',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'undying-sentinel',
      1,
    );
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      { deathSaveSuccesses: 0, deathSaveFailures: 0 },
    );
    expect(result.actionName).toBe('Sentinela Imortal');
    expect(result.total).toBe(46);
    expect(result.note).toContain('46');
  });

  it('spends Reveler pool for Oath of Revelry L15+', async () => {
    ctx.mockCharacterOnce({
      ...paladin,
      subclassSlug: 'oath-of-revelry',
      level: 15,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'reveler',
        ownerKind: 'subclass',
        ownerSlug: 'oath-of-revelry',
        unlockLevel: 15,
        note: { note: 'Folião.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'pal-1', {
      actionSlug: 'reveler',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'pal-1' }),
      'reveler',
      1,
    );
    expect(result.actionName).toBe('Folião');
  });

  it('rejects paladin actions for non-paladins', async () => {
    ctx.mockCharacterOnce({ ...paladin, classSlug: 'cleric' });
    await expect(
      handler.useTableAction('user-1', 'pal-1', {
        actionSlug: 'lay-on-hands',
        amount: 1,
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
