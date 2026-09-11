import { BadRequestException } from '@nestjs/common';
import type { CatalogEffect } from '@game/effects';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { ClericActionsHandler } from './cleric-actions.handler';

const CLERIC_ECONOMY = [
  {
    id: 'cleric-divine-spark-heal',
    name: 'Centelha Divina — Cura',
    economy: 'bonus' as const,
    classSlug: 'cleric',
    minLevel: 2,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'divine-spark-heal',
    itemSlug: null,
    featSlug: null,
    description: 'Centelha cura.',
  },
  {
    id: 'cleric-divine-spark-damage',
    name: 'Centelha Divina — Dano',
    economy: 'bonus' as const,
    classSlug: 'cleric',
    minLevel: 2,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'divine-spark-damage',
    itemSlug: null,
    featSlug: null,
    description: 'Centelha dano.',
  },
  {
    id: 'cleric-turn-undead',
    name: 'Expulsar Mortos-Vivos',
    economy: 'action' as const,
    classSlug: 'cleric',
    minLevel: 2,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'turn-undead',
    itemSlug: null,
    featSlug: null,
    description: 'Expulsar.',
  },
  {
    id: 'cleric-preserve-life',
    name: 'Preservar a Vida',
    economy: 'action' as const,
    classSlug: 'cleric',
    subclassSlug: 'life',
    minLevel: 3,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'preserve-life',
    itemSlug: null,
    featSlug: null,
    description: 'Preservar.',
  },
  {
    id: 'cleric-radiance-of-dawn',
    name: 'Brilho do Amanhecer',
    economy: 'action' as const,
    classSlug: 'cleric',
    subclassSlug: 'light',
    minLevel: 3,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'radiance-of-dawn',
    itemSlug: null,
    featSlug: null,
    description: 'Brilho.',
  },
  {
    id: 'cleric-warding-flare',
    name: 'Labareda Protetora',
    economy: 'reaction' as const,
    classSlug: 'cleric',
    subclassSlug: 'light',
    minLevel: 3,
    resourceSlug: 'warding-flare',
    alwaysSpendsResource: true,
    tableAction: 'warding-flare',
    itemSlug: null,
    featSlug: null,
    description: 'Labareda.',
  },
  {
    id: 'cleric-war-priest',
    name: 'Sacerdote da Guerra',
    economy: 'bonus' as const,
    classSlug: 'cleric',
    subclassSlug: 'war',
    minLevel: 3,
    resourceSlug: 'war-priest',
    alwaysSpendsResource: true,
    tableAction: 'war-priest',
    itemSlug: null,
    featSlug: null,
    description: 'Sacerdote.',
  },
  {
    id: 'cleric-dragon-majesty',
    name: 'Majestade Dracônica',
    economy: 'action' as const,
    classSlug: 'cleric',
    subclassSlug: 'dragon-domain',
    minLevel: 3,
    resourceSlug: 'channelDivinity',
    alwaysSpendsResource: true,
    tableAction: 'dragon-majesty',
    itemSlug: null,
    featSlug: null,
    description: 'Majestade.',
  },
  {
    id: 'cleric-chromatic-affinity',
    name: 'Afinidade Cromática',
    economy: 'free' as const,
    classSlug: 'cleric',
    subclassSlug: 'dragon-domain',
    minLevel: 3,
    resourceSlug: 'chromatic-affinity',
    alwaysSpendsResource: true,
    tableAction: 'chromatic-affinity',
    itemSlug: null,
    featSlug: null,
    description: 'Afinidade.',
  },
  {
    id: 'cleric-legendary-aspect-rend',
    name: 'Aspecto — Rasgar',
    economy: 'free' as const,
    classSlug: 'cleric',
    subclassSlug: 'dragon-domain',
    minLevel: 17,
    resourceSlug: 'legendary-aspect',
    alwaysSpendsResource: true,
    tableAction: 'legendary-aspect-rend',
    itemSlug: null,
    featSlug: null,
    description: 'Rasgar.',
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
    requiresOptionKey: null,
    requiresOptionValue: null,
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
      (partial.ownerKind === 'subclass' ? 'light' : 'cleric'),
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

describe('ClericActionsHandler', () => {
  const cleric = createTestCharacter({
    id: 'cleric-1',
    classSlug: 'cleric',
    subclassSlug: 'light',
    level: 7,
    abilityScores: createTestAbilityScores({
      forca: 10,
      destreza: 10,
      constituicao: 14,
      inteligencia: 12,
      sabedoria: 18,
      carisma: 8,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    stateResponse: { tempHp: 0 },
    defaultCharacter: cleric,
    proficiencyBonus: 3,
    mechanicalCatalogLoad: { economyActions: CLERIC_ECONOMY },
  });
  const effectCatalog = {
    load: jest.fn().mockResolvedValue([] as CatalogEffect[]),
  };
  let handler: ClericActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    effectCatalog.load.mockResolvedValue([]);
    handler = new ClericActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
    );
  });

  it('spends Channel Divinity and rolls the scaled Divine Spark', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'feature_dc',
        actionSlug: 'divine-spark-damage',
        ownerKind: 'class',
        unlockLevel: 2,
        sortOrder: 1,
        numeric: { amountFormula: 'eight_plus_mod_plus_pb', flat: null },
      }),
      effect({
        kind: 'table_roll',
        actionSlug: 'divine-spark-damage',
        ownerKind: 'class',
        unlockLevel: 2,
        sortOrder: 2,
        numeric: { amountFormula: 'dice_divine_spark_plus_flat', flat: null },
        note: {
          note: 'Centelha Divina: CD {saveDc} de CON; {total} Necrótico ou Radiante ({expression}), metade no sucesso.',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'divine-spark-damage',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'channelDivinity',
      1,
    );
    expect(result.expression).toMatch(/^2d8\+4$/);
    expect(result.saveDc).toBe(15);
  });

  it('applies Divine Spark heal to the sheet', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'heal',
        actionSlug: 'divine-spark-heal',
        ownerKind: 'class',
        unlockLevel: 2,
        numeric: { amountFormula: 'dice_divine_spark_plus_flat', flat: null },
        note: {
          note: 'Centelha Divina: restaure {total} PV ({expression}; ajuste se for aliado).',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'divine-spark-heal',
    });

    expect(result.expression).toMatch(/^2d8\+4$/);
    expect(result.note).toContain('Centelha Divina');
    expect(ctx.state.applyCurrentHitPoints).toHaveBeenCalled();
  });

  it('adds Sear Undead damage at level 5+', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'feature_dc',
        actionSlug: 'turn-undead',
        ownerKind: 'class',
        unlockLevel: 2,
        sortOrder: 1,
        numeric: { amountFormula: 'eight_plus_mod_plus_pb', flat: null },
      }),
      effect({
        kind: 'table_note',
        actionSlug: 'turn-undead',
        ownerKind: 'class',
        unlockLevel: 2,
        sortOrder: 2,
        note: { note: 'Expulsar Mortos-Vivos base.' },
      }),
      effect({
        kind: 'table_roll',
        actionSlug: 'turn-undead',
        ownerKind: 'class',
        unlockLevel: 5,
        sortOrder: 3,
        numeric: { amountFormula: 'ability_mod_d8', flat: null },
        note: {
          note: 'Expulsar Mortos-Vivos + Fulminar: CD {saveDc} de SAB; na falha, sofre {total} Radiante ({expression}).',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'turn-undead',
    });

    expect(result.expression).toBe('4d8');
    expect(result.saveDc).toBe(15);
    expect(result.note).toContain('Fulminar');
  });

  it('rolls Radiance of Dawn for a Light Cleric', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'feature_dc',
        actionSlug: 'radiance-of-dawn',
        ownerKind: 'subclass',
        ownerSlug: 'light',
        unlockLevel: 3,
        sortOrder: 1,
        numeric: { amountFormula: 'eight_plus_mod_plus_pb', flat: null },
      }),
      effect({
        kind: 'table_roll',
        actionSlug: 'radiance-of-dawn',
        ownerKind: 'subclass',
        ownerSlug: 'light',
        unlockLevel: 3,
        sortOrder: 2,
        numeric: { amountFormula: 'dice_2d10_plus_level', flat: null },
        note: {
          note: 'Brilho do Amanhecer: CD {saveDc} de CON, {total} Radiante ({expression}) ou metade.',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'radiance-of-dawn',
    });

    expect(result.expression).toBe('2d10+7');
    expect(result.saveDc).toBe(15);
  });

  it('uses the Life Domain healing pool without rolling', async () => {
    ctx.mockCharacterOnce({ ...cleric, subclassSlug: 'life', level: 9 });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'heal',
        actionSlug: 'preserve-life',
        ownerKind: 'subclass',
        ownerSlug: 'life',
        unlockLevel: 3,
        numeric: { amountFormula: 'level_times_5', flat: null },
        note: {
          note: 'Preservar a Vida: distribua até o pool; nenhuma passa da metade dos PV máximos.',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'preserve-life',
    });

    expect(result.total).toBe(45);
    expect(result.note).toContain('metade dos PV máximos');
    expect(ctx.state.applyCurrentHitPoints).toHaveBeenCalled();
  });

  it('spends War Priest uses from the subclass resource', async () => {
    ctx.mockCharacterOnce({ ...cleric, subclassSlug: 'war' });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'war-priest',
        ownerKind: 'subclass',
        ownerSlug: 'war',
        unlockLevel: 3,
        note: { note: 'Sacerdote da Guerra: ataque com arma.' },
      }),
    ]);

    await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'war-priest',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'war-priest',
      1,
    );
  });

  it('applies temporary HP for Improved Warding Flare', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'warding-flare',
        ownerKind: 'subclass',
        ownerSlug: 'light',
        unlockLevel: 3,
        sortOrder: 1,
        note: { note: 'Labareda Protetora: Desvantagem.' },
      }),
      effect({
        kind: 'temp_hp',
        actionSlug: 'warding-flare',
        ownerKind: 'subclass',
        ownerSlug: 'light',
        unlockLevel: 6,
        sortOrder: 2,
        numeric: { amountFormula: 'dice_2d6_plus_flat', flat: null },
        note: {
          note: 'Labareda Protetora: imponha Desvantagem e conceda PV temporários. ajuste o contador se o alvo for um aliado.',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'warding-flare',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'warding-flare',
      1,
    );
    expect(result.expression).toMatch(/^2d6\+4$/);
    expect(ctx.state.patch).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      expect.objectContaining({ tempHp: result.total }),
    );
    expect(result.note).toContain('ajuste o contador');
  });

  it('rejects Cleric actions for another class', async () => {
    ctx.mockCharacterOnce({ ...cleric, classSlug: 'wizard' });

    await expect(
      handler.useTableAction('user-1', 'cleric-1', {
        actionSlug: 'divine-spark-heal',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('spends Channel Divinity for Dragon Majesty with save DC', async () => {
    ctx.mockCharacterOnce({
      ...cleric,
      subclassSlug: 'dragon-domain',
      level: 5,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'feature_dc',
        actionSlug: 'dragon-majesty',
        ownerKind: 'subclass',
        ownerSlug: 'dragon-domain',
        unlockLevel: 3,
        sortOrder: 1,
        numeric: { amountFormula: 'eight_plus_mod_plus_pb', flat: null },
      }),
      effect({
        kind: 'table_note',
        actionSlug: 'dragon-majesty',
        ownerKind: 'subclass',
        ownerSlug: 'dragon-domain',
        unlockLevel: 3,
        sortOrder: 2,
        note: {
          note: 'Majestade Dracônica: Emanação 9 m — escolha Enfeitiçado ou Amedrontado.',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'dragon-majesty',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'channelDivinity',
      1,
    );
    expect(result.saveDc).toBe(15);
    expect(result.note).toContain('Enfeitiçado ou Amedrontado');
  });

  it('spends chromatic-affinity for Dragon Domain bonus damage', async () => {
    ctx.mockCharacterOnce({
      ...cleric,
      subclassSlug: 'dragon-domain',
      level: 8,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'chromatic-affinity',
        ownerKind: 'subclass',
        ownerSlug: 'dragon-domain',
        unlockLevel: 3,
        numeric: { amountFormula: 'level', flat: null },
        note: { note: 'Afinidade Cromática: +nível.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'chromatic-affinity',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'chromatic-affinity',
      1,
    );
    expect(result.total).toBe(8);
  });

  it('spends legendary-aspect for Rend at level 17+', async () => {
    ctx.mockCharacterOnce({
      ...cleric,
      subclassSlug: 'dragon-domain',
      level: 17,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'legendary-aspect-rend',
        ownerKind: 'subclass',
        ownerSlug: 'dragon-domain',
        unlockLevel: 17,
        note: { note: 'Rasgar: mova-se e ataque.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'cleric-1', {
      actionSlug: 'legendary-aspect-rend',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'cleric-1' }),
      'legendary-aspect',
      1,
    );
    expect(result.note).toContain('Rasgar');
  });
});
