jest.mock('./roll-weapon-context', () => ({
  loadAccessibleCharacter: jest.fn().mockResolvedValue({
    id: 'c1',
    classSlug: 'fighter',
    subclassSlug: null,
    level: 5,
  }),
  findEquippedWeaponAttack: jest.fn(),
}));

import {
  CHARACTERS,
  createRollDamageTestContext,
  mockCharacter,
  mockEquippedAttack,
  WEAPONS,
} from './roll-damage.spec.helpers';

describe('executeRollDamage — class rules', () => {
  const ctx = createRollDamageTestContext();

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('adds Psi Strike damage and reports Telekinetic Thrust DC', async () => {
    mockCharacter(CHARACTERS.psiWarrior);
    mockEquippedAttack(WEAPONS.longsword());
    const result = await ctx.rollDamage({
      itemSlug: 'longsword',
      mode: 'melee',
      psiStrike: true,
    });
    expect(result.label).toContain('Golpe Psiônico');
    expect(result.expression).toContain('1d8+3');
    expect(result.note).toContain('Estocada Telecinética CD 14');
    expect(ctx.resourceSpender.spendClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ subclassSlug: 'psi-warrior' }),
      'psi-energy-dice',
      1,
    );
  });

  it('rolls remaining Sneak Attack dice and doubles those dice on a critical', async () => {
    mockCharacter(CHARACTERS.rogueThief);
    mockEquippedAttack(WEAPONS.rapierSneak());
    const result = await ctx.rollDamage({
      itemSlug: 'rapier',
      mode: 'melee',
      critical: true,
      sneakAttack: true,
      cunningStrikeEffects: ['trip'],
    });
    expect(result.expression).toContain('4d6');
    expect(result.rolls).toHaveLength(6);
    expect(result.note).toContain('Tropeço');
    expect(result.note).toContain('CD 15');
  });

  it('rejects Sneak Attack with an ineligible melee weapon', async () => {
    mockCharacter(CHARACTERS.rogueBasic);
    mockEquippedAttack(WEAPONS.longswordIneligibleSneak());
    await expect(
      ctx.rollDamage({
        itemSlug: 'longsword',
        mode: 'melee',
        sneakAttack: true,
      }),
    ).rejects.toThrow(/Finesse weapon or a ranged attack/);
  });

  it('doubles pre-smite damage for Death Strike and wraps the expression', async () => {
    mockCharacter(CHARACTERS.assassin);
    mockEquippedAttack(WEAPONS.rapierAssassin());
    const result = await ctx.rollDamage({
      itemSlug: 'rapier',
      mode: 'melee',
      sneakAttack: true,
      assassinDeathStrike: true,
    });
    expect(result.expression).toMatch(/^2×\(/);
    expect(result.note).toContain('Golpe Mortal');
    expect(result.label).toContain('Ataque Furtivo');
  });

  it('adds Radiant Strikes automatically for Paladin level 11 melee', async () => {
    mockCharacter(CHARACTERS.paladinL11);
    mockEquippedAttack(WEAPONS.longsword());
    const result = await ctx.rollDamage({
      itemSlug: 'longsword',
      mode: 'melee',
    });
    expect(result.note).toContain('Golpes Radiantes');
    expect(result.expression).toContain('1d8');
  });

  it('does not add Radiant Strikes below level 11 or on ranged attacks', async () => {
    mockCharacter(CHARACTERS.paladinL10);
    mockEquippedAttack(WEAPONS.longsword());
    const melee = await ctx.rollDamage({
      itemSlug: 'longsword',
      mode: 'melee',
    });
    expect(melee.note ?? '').not.toContain('Golpes Radiantes');

    mockCharacter(CHARACTERS.paladinL11);
    const ranged = await ctx.rollDamage({
      itemSlug: 'longsword',
      mode: 'ranged',
    });
    expect(ranged.note ?? '').not.toContain('Golpes Radiantes');
  });

  it('debits a spell slot when Divine Smite is used', async () => {
    mockCharacter(CHARACTERS.paladinL5);
    mockEquippedAttack(WEAPONS.longsword());
    const result = await ctx.rollDamage({
      itemSlug: 'longsword',
      mode: 'melee',
      divineSmite: true,
      smiteSlotLevel: 1,
    });
    expect(result.label).toContain('Destruição Divina');
    expect(result.note).toContain('Destruição Divina');
    expect(ctx.resourceSpender.consumeSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ classSlug: 'paladin' }),
      1,
    );
  });

  it('spends dread-strike for Dread Ambusher and adds psychic damage', async () => {
    mockCharacter(CHARACTERS.gloomStalker);
    mockEquippedAttack(WEAPONS.longbow());
    const result = await ctx.rollDamage({
      itemSlug: 'longbow',
      mode: 'ranged',
      dreadAmbusher: true,
    });
    expect(result.label).toContain('Golpe Terrível');
    expect(result.note).toContain('Golpe Terrível');
    expect(ctx.resourceSpender.spendClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ subclassSlug: 'gloom-stalker' }),
      'dread-strike',
      1,
    );
  });

  it('adds the Cleric Divine Strike dice at level 14', async () => {
    mockCharacter(CHARACTERS.warCleric);
    mockEquippedAttack(WEAPONS.mace());
    const result = await ctx.rollDamage({
      itemSlug: 'mace',
      mode: 'melee',
      divineStrike: true,
    });
    expect(result.expression).toContain('+2d8');
    expect(result.note).toContain('Golpe Divino');
  });
});
