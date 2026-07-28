jest.mock('./roll-weapon-context', () => ({
  loadAccessibleCharacter: jest.fn().mockResolvedValue({ id: 'c1' }),
  findEquippedWeaponAttack: jest.fn(),
}));

import { executeRollAttack } from './roll-attack';
import { findEquippedWeaponAttack } from './roll-weapon-context';

describe('executeRollAttack', () => {
  const base = {
    access: {} as never,
    sheet: {} as never,
    domain: {} as never,
    weaponAttacks: {} as never,
    userId: 'u1',
    characterId: 'c1',
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('forces disadvantage when attack has disadvantage and mode normal', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      itemName: 'Longbow',
      attackBonus: 5,
      attackDisadvantage: true,
    });
    const result = await executeRollAttack({
      ...base,
      dto: { itemSlug: 'longbow', mode: 'ranged', advantage: 'normal' },
    });
    expect(result.kind).toBe('attack');
    expect(result.mode).toBe('disadvantage');
    expect(result.label).toContain('à distância');
  });

  it('keeps explicit advantage and melee label', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      itemName: 'Longsword',
      attackBonus: 4,
      attackDisadvantage: true,
    });
    const result = await executeRollAttack({
      ...base,
      dto: { itemSlug: 'longsword', mode: 'melee', advantage: 'advantage' },
    });
    expect(result.mode).toBe('advantage');
    expect(result.label).toContain('corpo a corpo');
  });
});
