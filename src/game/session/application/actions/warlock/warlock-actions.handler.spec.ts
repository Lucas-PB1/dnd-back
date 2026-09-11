import { BadRequestException } from '@nestjs/common';
import type { CatalogEffect } from '@game/effects';
import {
  asHandlerDep,
  createTableActionHandlerTestContext,
  createTestAbilityScores,
  createTestCharacter,
} from '../testing/table-action-handler.harness';
import { WarlockActionsHandler } from './warlock-actions.handler';

const WARLOCK_ECONOMY = [
  {
    id: 'warlock-magical-cunning',
    name: 'Astúcia Mágica',
    economy: 'free' as const,
    classSlug: 'warlock',
    minLevel: 2,
    resourceSlug: 'magical-cunning',
    alwaysSpendsResource: true,
    tableAction: 'magical-cunning',
    itemSlug: null,
    featSlug: null,
    description: 'Astúcia.',
  },
  {
    id: 'warlock-healing-light',
    name: 'Luz Medicinal',
    economy: 'bonus' as const,
    classSlug: 'warlock',
    subclassSlug: 'celestial',
    minLevel: 3,
    resourceSlug: 'healing-light',
    alwaysSpendsResource: false,
    tableAction: 'healing-light',
    itemSlug: null,
    featSlug: null,
    description: 'Luz.',
  },
  {
    id: 'warlock-dark-ones-luck',
    name: 'A Sorte do Próprio Tenebroso',
    economy: 'free' as const,
    classSlug: 'warlock',
    subclassSlug: 'fiend',
    minLevel: 6,
    resourceSlug: 'dark-ones-luck',
    alwaysSpendsResource: false,
    tableAction: 'dark-ones-luck',
    itemSlug: null,
    featSlug: null,
    description: 'Sorte.',
  },
  {
    id: 'warlock-fey-steps',
    name: 'Passos Feéricos',
    economy: 'bonus' as const,
    classSlug: 'warlock',
    subclassSlug: 'archfey',
    minLevel: 3,
    resourceSlug: 'fey-steps',
    alwaysSpendsResource: true,
    tableAction: 'fey-step-effect',
    itemSlug: null,
    featSlug: null,
    description: 'Fey.',
  },
  {
    id: 'warlock-clairvoyant',
    name: 'Combatente Clarividente',
    economy: 'free' as const,
    classSlug: 'warlock',
    subclassSlug: 'great-old-one',
    minLevel: 6,
    resourceSlug: 'clairvoyant-competitor',
    alwaysSpendsResource: true,
    tableAction: 'clairvoyant-combatant',
    itemSlug: null,
    featSlug: null,
    description: 'Clarividente.',
  },
  {
    id: 'warlock-beguiling',
    name: 'Defesas Sedutoras',
    economy: 'reaction' as const,
    classSlug: 'warlock',
    subclassSlug: 'archfey',
    minLevel: 10,
    resourceSlug: 'beguiling-defenses',
    alwaysSpendsResource: true,
    tableAction: 'beguiling-defenses',
    itemSlug: null,
    featSlug: null,
    description: 'Defesas.',
  },
  {
    id: 'warlock-hurl',
    name: 'Lançar no Inferno',
    economy: 'free' as const,
    classSlug: 'warlock',
    subclassSlug: 'fiend',
    minLevel: 14,
    resourceSlug: 'hurl-through-hell',
    alwaysSpendsResource: true,
    tableAction: 'hurl-through-hell',
    itemSlug: null,
    featSlug: null,
    description: 'Inferno.',
  },
  {
    id: 'warlock-invoke-pact-weapon',
    name: 'Invocar Arma de Pacto',
    economy: 'bonus' as const,
    classSlug: 'warlock',
    minLevel: 1,
    alwaysSpendsResource: false,
    tableAction: 'invoke-pact-weapon',
    itemSlug: null,
    featSlug: null,
    description: 'Pacto.',
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
      (partial.ownerKind === 'subclass' ? 'fiend' : 'warlock'),
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

describe('WarlockActionsHandler', () => {
  const warlock = createTestCharacter({
    id: 'war-1',
    classSlug: 'warlock',
    subclassSlug: 'fiend',
    level: 5,
    abilityScores: createTestAbilityScores({
      forca: 8,
      destreza: 14,
      constituicao: 14,
      inteligencia: 10,
      sabedoria: 10,
      carisma: 18,
    }),
  });
  const ctx = createTableActionHandlerTestContext({
    defaultCharacter: warlock,
    mechanicalCatalogLoad: { economyActions: WARLOCK_ECONOMY },
  });
  const inventory = {
    findPactWeaponSlug: jest.fn(),
    bindAndEquipPactWeapon: jest.fn(),
  };
  const assertCanBindPact = {
    assertCharacterCanUsePactBlade: jest.fn(),
    assertItemIsMeleeWeapon: jest.fn(),
    assert: jest.fn(),
  };
  const effectCatalog = {
    load: jest.fn().mockResolvedValue([] as CatalogEffect[]),
  };
  let handler: WarlockActionsHandler;

  beforeEach(() => {
    ctx.resetMocks();
    effectCatalog.load.mockResolvedValue([]);
    assertCanBindPact.assertCharacterCanUsePactBlade.mockResolvedValue(
      undefined,
    );
    assertCanBindPact.assertItemIsMeleeWeapon.mockResolvedValue(undefined);
    inventory.bindAndEquipPactWeapon.mockResolvedValue({
      itemSlug: 'longsword',
      itemName: 'Espada Longa',
    });
    handler = new WarlockActionsHandler(
      asHandlerDep(ctx.access),
      asHandlerDep(ctx.state),
      asHandlerDep(inventory),
      asHandlerDep(assertCanBindPact),
      asHandlerDep(ctx.mechanicalCatalog),
      asHandlerDep(effectCatalog),
    );
  });

  it('recovers half pact slots for Magical Cunning', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'recover_spell_slot',
        actionSlug: 'magical-cunning',
        ownerKind: 'class',
        spell: {
          spellId: null,
          spellSlug: null,
          optionKey: 'pact_slot_level',
          spellLevel: null,
        },
        numeric: {
          amountFormula: 'pact_slots_recovery_count',
          flat: null,
        },
        note: { note: 'Astúcia Mágica: recuperou {total} Slot(s) de Pacto.' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'magical-cunning',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'war-1' }),
      'magical-cunning',
      1,
    );
    expect(ctx.state.recoverSpellSlotLevel).toHaveBeenCalledTimes(1);
    expect(ctx.state.recoverSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'war-1' }),
      3,
    );
    expect(result.note).toContain('Astúcia Mágica');
  });

  it('requires level 6 for Dark One’s Luck', async () => {
    await expect(
      handler.useTableAction('user-1', 'war-1', {
        actionSlug: 'dark-ones-luck',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rolls 1d10 for Dark One’s Luck (Fiend L6+)', async () => {
    ctx.mockCharacterOnce({ ...warlock, level: 6 });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'spend_resource',
        actionSlug: 'dark-ones-luck',
        ownerKind: 'subclass',
        ownerSlug: 'fiend',
        resourceSlug: 'dark-ones-luck',
        numeric: { amountFormula: 'fixed', flat: 1 },
      }),
      effect({
        kind: 'table_roll',
        actionSlug: 'dark-ones-luck',
        ownerKind: 'subclass',
        ownerSlug: 'fiend',
        unlockLevel: 6,
        dice: { die: '1d10', dieAtLevel: null, atLevel: null, damageTypeSlug: null },
        note: {
          note: 'A Sorte do Próprio Tenebroso: some +{total} ({expression}).',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'dark-ones-luck',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'dark-ones-luck',
      1,
    );
    expect(result.expression).toBe('1d10');
    expect(result.note).toContain('Sorte do Próprio Tenebroso');
  });

  it('resolves Healing Light for Celestial Warlock', async () => {
    ctx.mockCharacterOnce({ ...warlock, subclassSlug: 'celestial' });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'heal_from_dice_pool',
        actionSlug: 'healing-light',
        ownerKind: 'subclass',
        ownerSlug: 'celestial',
        resourceSlug: 'healing-light',
        dice: { die: '1d6', dieAtLevel: null, atLevel: null, damageTypeSlug: null },
        note: { note: 'Luz Medicinal: {total} PV ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'healing-light',
      diceCount: 2,
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'healing-light',
      2,
    );
    expect(result.expression).toBe('2d6');
    expect(result.note).toContain('Luz Medicinal');
    expect(ctx.state.applyCurrentHitPoints).toHaveBeenCalled();
  });

  it('rejects Dark One’s Luck when resource spend fails', async () => {
    ctx.mockCharacterOnce({ ...warlock, level: 6 });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'spend_resource',
        actionSlug: 'dark-ones-luck',
        ownerKind: 'subclass',
        ownerSlug: 'fiend',
        resourceSlug: 'dark-ones-luck',
        numeric: { amountFormula: 'fixed', flat: 1 },
      }),
    ]);
    ctx.state.useClassResource.mockRejectedValueOnce(
      new BadRequestException('Sem usos restantes'),
    );

    await expect(
      handler.useTableAction('user-1', 'war-1', {
        actionSlug: 'dark-ones-luck',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('notes Clairvoyant Combatant as telepathic combat link', async () => {
    ctx.mockCharacterOnce({
      ...warlock,
      subclassSlug: 'great-old-one',
      level: 6,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'clairvoyant-combatant',
        ownerKind: 'subclass',
        ownerSlug: 'great-old-one',
        note: {
          note: 'Combatente Clarividente: ligação com Mente Desperta.',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'clairvoyant-combatant',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'clairvoyant-competitor',
      1,
    );
    expect(result.note).toContain('Mente Desperta');
    expect(result.note).not.toContain('teleporte');
  });

  it('notes Beguiling Defenses as post-hit reaction', async () => {
    ctx.mockCharacterOnce({
      ...warlock,
      subclassSlug: 'archfey',
      level: 10,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'beguiling-defenses',
        ownerKind: 'subclass',
        ownerSlug: 'archfey',
        note: {
          note: 'Defesas Sedutoras: imune a Enfeitiçado. Reação após ser acertado.',
        },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'beguiling-defenses',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'beguiling-defenses',
      1,
    );
    expect(result.note).toContain('acertado');
    expect(result.note).toContain('Enfeitiçado');
  });

  it('rejects Warlock actions for non-warlock characters', async () => {
    ctx.mockCharacterOnce({ ...warlock, classSlug: 'sorcerer' });

    await expect(
      handler.useTableAction('user-1', 'war-1', {
        actionSlug: 'magical-cunning',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('rejects invoke-pact-weapon without Pact of the Blade', async () => {
    assertCanBindPact.assertCharacterCanUsePactBlade.mockRejectedValueOnce(
      new BadRequestException('Requer a invocação Pacto da Lâmina'),
    );
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'bind_pact_weapon',
        actionSlug: 'invoke-pact-weapon',
        ownerKind: 'class',
      }),
    ]);

    await expect(
      handler.useTableAction('user-1', 'war-1', {
        actionSlug: 'invoke-pact-weapon',
        itemSlug: 'longsword',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(inventory.bindAndEquipPactWeapon).not.toHaveBeenCalled();
  });

  it('binds and notes when invoking a pact weapon', async () => {
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'bind_pact_weapon',
        actionSlug: 'invoke-pact-weapon',
        ownerKind: 'class',
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'invoke-pact-weapon',
      itemSlug: 'longsword',
    });

    expect(assertCanBindPact.assertItemIsMeleeWeapon).toHaveBeenCalledWith(
      'longsword',
    );
    expect(inventory.bindAndEquipPactWeapon).toHaveBeenCalledWith(
      'war-1',
      'longsword',
      8,
      { classSlug: 'warlock', speciesSlug: null },
    );
    expect(result.note).toContain('Espada Longa');
    expect(result.note).toContain('Carisma');
  });

  it('uses already-marked pact weapon when itemSlug is omitted', async () => {
    inventory.findPactWeaponSlug.mockResolvedValueOnce('dagger');
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'bind_pact_weapon',
        actionSlug: 'invoke-pact-weapon',
        ownerKind: 'class',
      }),
    ]);

    await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'invoke-pact-weapon',
    });

    expect(inventory.bindAndEquipPactWeapon).toHaveBeenCalledWith(
      'war-1',
      'dagger',
      8,
      { classSlug: 'warlock', speciesSlug: null },
    );
  });

  it('spends fey-steps on Passos Feéricos', async () => {
    ctx.mockCharacterOnce({ ...warlock, subclassSlug: 'archfey' });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_note',
        actionSlug: 'fey-step-effect',
        ownerKind: 'subclass',
        ownerSlug: 'archfey',
        note: { note: 'Passos Feéricos (−1 uso).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'fey-step-effect',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'fey-steps',
      1,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Passos Feéricos');
  });

  it('rolls Hurl Through Hell for Fiend L14', async () => {
    ctx.mockCharacterOnce({
      ...warlock,
      subclassSlug: 'fiend',
      level: 14,
    });
    effectCatalog.load.mockResolvedValueOnce([
      effect({
        kind: 'table_roll',
        actionSlug: 'hurl-through-hell',
        ownerKind: 'subclass',
        ownerSlug: 'fiend',
        unlockLevel: 14,
        dice: { die: '8d10', dieAtLevel: null, atLevel: null, damageTypeSlug: null },
        note: { note: 'Lançar no Inferno: {total} ({expression}).' },
      }),
    ]);

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'hurl-through-hell',
    });

    expect(ctx.state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'hurl-through-hell',
      1,
    );
    expect(result.expression).toBe('8d10');
    expect(result.note).toContain('Lançar no Inferno');
  });
});
