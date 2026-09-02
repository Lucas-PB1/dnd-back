jest.mock('./roll-weapon-context', () => ({
  loadAccessibleCharacter: jest.fn().mockResolvedValue({
    id: 'c1',
    classSlug: 'fighter',
    subclassSlug: null,
    level: 5,
  }),
  findEquippedWeaponAttack: jest.fn(),
}));

import { BadRequestException } from '@nestjs/common';
import {
  createRollDamageTestContext,
  mockEquippedAttack,
  WEAPONS,
} from './roll-damage.spec.helpers';

describe('executeRollDamage', () => {
  const ctx = createRollDamageTestContext();

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('returns graze-on-miss flat damage', async () => {
    mockEquippedAttack(WEAPONS.greataxeGraze());
    const result = await ctx.rollDamage({
      itemSlug: 'greataxe',
      mode: 'melee',
      grazeMiss: true,
    });
    expect(result).toMatchObject({
      kind: 'damage',
      total: 3,
      rolls: [],
      critical: false,
    });
  });

  it('rejects graze when mastery inactive', async () => {
    mockEquippedAttack(WEAPONS.longswordNoGraze());
    await expect(
      ctx.rollDamage({
        itemSlug: 'longsword',
        mode: 'melee',
        grazeMiss: true,
      }),
    ).rejects.toThrow(BadRequestException);
  });

  it('rolls normal and critical damage with GWF label', async () => {
    mockEquippedAttack(WEAPONS.greataxeGwf());
    const result = await ctx.rollDamage({
      itemSlug: 'greataxe',
      mode: 'melee',
      critical: true,
    });
    expect(result.kind).toBe('damage');
    expect(result.label).toContain('crítico');
    expect(result.label).toContain('GWF');
    expect(result.rolls.length).toBeGreaterThan(0);
  });

  it('adds syndicate quick strike dice when toggled', async () => {
    mockEquippedAttack(WEAPONS.rapierQuickStrike());
    const result = await ctx.rollDamage({
      itemSlug: 'rapier',
      mode: 'melee',
      quickStrike: true,
    });
    expect(result.expression).toContain('+2d4');
    expect(result.note).toContain('Golpe Rápido');
  });

  it('rejects quick strike without syndicate feat on attack', async () => {
    mockEquippedAttack(WEAPONS.rapierNoQuickStrike());
    await expect(
      ctx.rollDamage({
        itemSlug: 'rapier',
        mode: 'melee',
        quickStrike: true,
      }),
    ).rejects.toBeInstanceOf(BadRequestException);
  });
});
