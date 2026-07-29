jest.mock('./roll-weapon-context', () => ({
  loadAccessibleCharacter: jest.fn().mockResolvedValue({
    id: 'c1',
    classSlug: 'fighter',
    level: 5,
  }),
  findEquippedWeaponAttack: jest.fn(),
}));

import { executeRollAttack } from './roll-attack';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';

describe('executeRollAttack', () => {
  const base = {
    access: {} as never,
    sheet: {} as never,
    domain: {} as never,
    weaponAttacks: {} as never,
    permanentItemEffects: {} as never,
    dataSource: {} as never,
    userId: 'u1',
    characterId: 'c1',
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('forces disadvantage when attack has disadvantage and mode normal', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Longbow',
        attackBonus: 5,
        attackDisadvantage: true,
        abilitySlug: 'destreza',
        critThreshold: 20,
      },
      combatFlags: { rageActive: false, recklessActive: false },
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
      attack: {
        itemName: 'Longsword',
        attackBonus: 4,
        attackDisadvantage: true,
        abilitySlug: 'forca',
        critThreshold: 20,
      },
      combatFlags: { rageActive: false, recklessActive: false },
    });
    const result = await executeRollAttack({
      ...base,
      dto: { itemSlug: 'longsword', mode: 'melee', advantage: 'advantage' },
    });
    expect(result.mode).toBe('advantage');
    expect(result.label).toContain('corpo a corpo');
  });

  it('applies Mobile Aim for an Assassin without setting movement to zero', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'rogue',
      subclassSlug: 'assassin',
      level: 9,
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Shortbow',
        attackBonus: 7,
        attackDisadvantage: false,
        abilitySlug: 'destreza',
        critThreshold: 20,
      },
      combatFlags: { rageActive: false, recklessActive: false },
    });

    const result = await executeRollAttack({
      ...base,
      dto: {
        itemSlug: 'shortbow',
        mode: 'ranged',
        steadyAim: true,
      },
    });

    expect(result.mode).toBe('advantage');
    expect(result.note).toContain('Mira Móvel');
    expect(result.note).not.toContain('Deslocamento 0');
  });
});
