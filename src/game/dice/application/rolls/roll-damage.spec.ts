jest.mock('./roll-weapon-context', () => ({
  loadAccessibleCharacter: jest.fn().mockResolvedValue({ id: 'c1' }),
  findEquippedWeaponAttack: jest.fn(),
}));

import { BadRequestException } from '@nestjs/common';
import { executeRollDamage } from './roll-damage';
import { findEquippedWeaponAttack } from './roll-weapon-context';

describe('executeRollDamage', () => {
  const base = {
    access: {} as never,
    sheet: {} as never,
    domain: {} as never,
    weaponAttacks: {} as never,
    permanentItemEffects: {} as never,
    userId: 'u1',
    characterId: 'c1',
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('returns graze-on-miss flat damage', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      itemName: 'Greataxe',
      grazeOnMissDamage: 3,
      damageDice: '1d12',
      damageBonus: 3,
      greatWeaponFighting: false,
    });
    const result = await executeRollDamage({
      ...base,
      dto: { itemSlug: 'greataxe', mode: 'melee', grazeMiss: true },
    });
    expect(result).toMatchObject({
      kind: 'damage',
      total: 3,
      rolls: [],
      critical: false,
    });
  });

  it('rejects graze when mastery inactive', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      itemName: 'Longsword',
      grazeOnMissDamage: null,
    });
    await expect(
      executeRollDamage({
        ...base,
        dto: { itemSlug: 'longsword', mode: 'melee', grazeMiss: true },
      }),
    ).rejects.toThrow(BadRequestException);
  });

  it('rolls normal and critical damage with GWF label', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      itemName: 'Greataxe',
      grazeOnMissDamage: null,
      damageDice: '1d12',
      damageBonus: 4,
      greatWeaponFighting: true,
    });
    const result = await executeRollDamage({
      ...base,
      dto: { itemSlug: 'greataxe', mode: 'melee', critical: true },
    });
    expect(result.kind).toBe('damage');
    expect(result.label).toContain('crítico');
    expect(result.label).toContain('GWF');
    expect(result.rolls.length).toBeGreaterThan(0);
  });
});
