import { BadRequestException } from '@nestjs/common';
import { WarlockActionsHandler } from './warlock-actions.handler';

describe('WarlockActionsHandler', () => {
  const stateResponse = { classResources: [] };
  const access = { findAccessibleOrFail: jest.fn() };
  const state = {
    useClassResource: jest.fn().mockResolvedValue({ state: stateResponse }),
    recoverClassResource: jest.fn().mockResolvedValue(stateResponse),
    recoverSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
    buildResponse: jest.fn().mockResolvedValue(stateResponse),
  };
  const domain = { getProficiencyBonus: jest.fn().mockResolvedValue(3) };
  const inventory = {
    findPactWeaponSlug: jest.fn(),
    bindAndEquipPactWeapon: jest.fn(),
  };
  const assertCanBindPact = {
    assertCharacterCanUsePactBlade: jest.fn(),
    assertItemIsMeleeWeapon: jest.fn(),
    assert: jest.fn(),
  };
  const handler = new WarlockActionsHandler(
    access as never,
    state as never,
    domain as never,
    inventory as never,
    assertCanBindPact as never,
  );
  const warlock = {
    id: 'war-1',
    classSlug: 'warlock',
    subclassSlug: 'fiend',
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
    access.findAccessibleOrFail.mockResolvedValue(warlock);
    state.useClassResource.mockResolvedValue({ state: stateResponse });
    state.recoverClassResource.mockResolvedValue(stateResponse);
    state.buildResponse.mockResolvedValue(stateResponse);
    domain.getProficiencyBonus.mockResolvedValue(3);
    assertCanBindPact.assertCharacterCanUsePactBlade.mockResolvedValue(
      undefined,
    );
    assertCanBindPact.assertItemIsMeleeWeapon.mockResolvedValue(undefined);
    inventory.bindAndEquipPactWeapon.mockResolvedValue({
      itemSlug: 'longsword',
      itemName: 'Espada Longa',
    });
  });

  it('recovers half pact slots for Magical Cunning', async () => {
    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'magical-cunning',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ id: 'war-1' }),
      'magical-cunning',
      1,
    );
    expect(state.recoverSpellSlotLevel).toHaveBeenCalledTimes(1);
    expect(state.recoverSpellSlotLevel).toHaveBeenCalledWith(
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
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      level: 6,
    });

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'dark-ones-luck',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'dark-ones-luck',
      1,
    );
    expect(result.expression).toBe('1d10');
    expect(result.note).toContain('Sorte do Próprio Tenebroso');
  });

  it('resolves Healing Light for Celestial Warlock', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      subclassSlug: 'celestial',
    });

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'healing-light',
      diceCount: 2,
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'healing-light',
      2,
    );
    expect(result.expression).toBe('2d6');
    expect(result.note).toContain('Luz Medicinal');
  });

  it('rejects Dark One’s Luck when resource spend fails', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      level: 6,
    });
    state.useClassResource.mockRejectedValueOnce(
      new BadRequestException('Sem usos restantes'),
    );

    await expect(
      handler.useTableAction('user-1', 'war-1', {
        actionSlug: 'dark-ones-luck',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });

  it('notes Clairvoyant Combatant as telepathic combat link', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      subclassSlug: 'great-old-one',
      level: 6,
    });

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'clairvoyant-combatant',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'clairvoyant-competitor',
      1,
    );
    expect(result.note).toContain('Mente Desperta');
    expect(result.note).not.toContain('teleporte');
  });

  it('notes Beguiling Defenses as post-hit reaction', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      subclassSlug: 'archfey',
      level: 10,
    });

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'beguiling-defenses',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'beguiling-defenses',
      1,
    );
    expect(result.note).toContain('acertado');
    expect(result.note).toContain('Enfeitiçado');
  });

  it('rejects Warlock actions for non-warlock characters', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      classSlug: 'sorcerer',
    });

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

    await expect(
      handler.useTableAction('user-1', 'war-1', {
        actionSlug: 'invoke-pact-weapon',
        itemSlug: 'longsword',
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
    expect(inventory.bindAndEquipPactWeapon).not.toHaveBeenCalled();
  });

  it('binds and notes when invoking a pact weapon', async () => {
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
    );
    expect(result.note).toContain('Espada Longa');
    expect(result.note).toContain('Carisma');
  });

  it('uses already-marked pact weapon when itemSlug is omitted', async () => {
    inventory.findPactWeaponSlug.mockResolvedValueOnce('dagger');

    await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'invoke-pact-weapon',
    });

    expect(inventory.bindAndEquipPactWeapon).toHaveBeenCalledWith(
      'war-1',
      'dagger',
      8,
    );
  });

  it('spends fey-steps on Passos Feéricos', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      subclassSlug: 'archfey',
    });

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'fey-step-effect',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'fey-steps',
      1,
    );
    expect(result.resourceSpent).toBe(true);
    expect(result.note).toContain('Passos Feéricos');
  });

  it('rolls Hurl Through Hell for Fiend L14', async () => {
    access.findAccessibleOrFail.mockResolvedValueOnce({
      ...warlock,
      subclassSlug: 'fiend',
      level: 14,
    });

    const result = await handler.useTableAction('user-1', 'war-1', {
      actionSlug: 'hurl-through-hell',
    });

    expect(state.useClassResource).toHaveBeenCalledWith(
      expect.anything(),
      'hurl-through-hell',
      1,
    );
    expect(result.expression).toBe('8d10');
    expect(result.note).toContain('Lançar no Inferno');
  });
});
