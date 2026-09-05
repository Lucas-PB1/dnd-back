jest.mock('./roll-weapon-context', () => ({
  loadAccessibleCharacter: jest.fn().mockResolvedValue({
    id: 'c1',
    classSlug: 'fighter',
    level: 5,
  }),
  findEquippedWeaponAttack: jest.fn(),
}));

jest.mock('./apply-cursemarked-bracket', () => ({
  applyCursemarkedBracketIfTriggered: jest.fn().mockResolvedValue(undefined),
}));

import { executeRollAttack } from './roll-attack';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';
import { asRollDep, mockEffectCatalog, mockResourceSpender } from './roll-damage.spec.helpers';

describe('executeRollAttack', () => {
  const base = {
    access: asRollDep({}),
    sheet: asRollDep({}),
    domain: asRollDep({}),
    weaponAttacks: asRollDep({}),
    permanentItemEffects: asRollDep({}),
    dataSource: asRollDep({}),
    resourceSpender: mockResourceSpender(),
    effectCatalog: mockEffectCatalog(),
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
      featSlugs: [],
    });
    const result = await executeRollAttack({
      ...base,
      dto: { itemSlug: 'longbow', mode: 'ranged', advantage: 'normal' },
    });
    expect(result.kind).toBe('attack');
    expect(result.mode).toBe('disadvantage');
    expect(result.label).toContain('à distância');
  });

  it('cancels explicit advantage with attack disadvantage', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Longsword',
        attackBonus: 4,
        attackDisadvantage: true,
        abilitySlug: 'forca',
        critThreshold: 20,
      },
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
      featSlugs: [],
    });
    const result = await executeRollAttack({
      ...base,
      dto: { itemSlug: 'longsword', mode: 'melee', advantage: 'advantage' },
    });
    expect(result.mode).toBe('normal');
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
      featSlugs: [],
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

  it('cancels studied attack advantage with weapon disadvantage', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'fighter',
      subclassSlug: 'champion',
      level: 13,
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Longsword',
        attackBonus: 6,
        attackDisadvantage: true,
        abilitySlug: 'forca',
        critThreshold: 20,
      },
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
      featSlugs: [],
    });

    const result = await executeRollAttack({
      ...base,
      dto: {
        itemSlug: 'longsword',
        mode: 'melee',
        advantage: 'normal',
        studiedAttack: true,
      },
    });

    expect(result.mode).toBe('normal');
    expect(result.note).toContain('Ataques Estudados');
  });

  it('applies half cover AC bonus and hit check', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Longbow',
        attackBonus: 5,
        attackDisadvantage: false,
        abilitySlug: 'destreza',
        critThreshold: 20,
      },
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
      featSlugs: [],
    });
    const result = await executeRollAttack({
      ...base,
      dto: {
        itemSlug: 'longbow',
        mode: 'ranged',
        targetCover: 'half',
        targetAc: 15,
      },
    });
    expect(result.targetAcBonus).toBe(2);
    expect(result.effectiveTargetAc).toBe(17);
    expect(typeof result.hit).toBe('boolean');
    expect(result.note).toContain('Cobertura parcial');
  });

  it('rejects full cover before rolling', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Longbow',
        attackBonus: 5,
        attackDisadvantage: false,
        abilitySlug: 'destreza',
        critThreshold: 20,
      },
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
      featSlugs: [],
    });
    await expect(
      executeRollAttack({
        ...base,
        dto: { itemSlug: 'longbow', mode: 'ranged', targetCover: 'full' },
      }),
    ).rejects.toThrow('Cobertura total');
  });

  it('upgrades disadvantage to normal with Steady Aim', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'rogue',
      subclassSlug: 'thief',
      level: 3,
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Shortbow',
        attackBonus: 5,
        attackDisadvantage: true,
        abilitySlug: 'destreza',
        critThreshold: 20,
      },
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
      featSlugs: [],
    });

    const result = await executeRollAttack({
      ...base,
      dto: {
        itemSlug: 'shortbow',
        mode: 'ranged',
        advantage: 'normal',
        steadyAim: true,
      },
    });

    expect(result.mode).toBe('normal');
    expect(result.note).toContain('Mira Firme');
    expect(result.note).toContain('Deslocamento 0');
  });

  it('applies reckless advantage on melee STR for barbarian', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'barbarian',
      level: 5,
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Greataxe',
        attackBonus: 7,
        attackDisadvantage: false,
        abilitySlug: 'forca',
        critThreshold: 20,
      },
      combatFlags: { rageActive: true, recklessActive: true, bestialAspectLevel: 0 },
      featSlugs: [],
    });

    const result = await executeRollAttack({
      ...base,
      dto: { itemSlug: 'greataxe', mode: 'melee', advantage: 'normal' },
    });

    expect(result.mode).toBe('advantage');
    expect(result.note).toContain('Imprudente');
  });

  it('skips reckless advantage when brutal strike is declared', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'barbarian',
      subclassSlug: 'path-of-the-berserker',
      level: 7,
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Greataxe',
        attackBonus: 7,
        attackDisadvantage: false,
        abilitySlug: 'forca',
        critThreshold: 20,
      },
      combatFlags: { rageActive: true, recklessActive: true, bestialAspectLevel: 0 },
      featSlugs: [],
    });

    const result = await executeRollAttack({
      ...base,
      dto: {
        itemSlug: 'greataxe',
        mode: 'melee',
        advantage: 'normal',
        brutalStrike: true,
      },
    });

    expect(result.mode).toBe('normal');
    expect(result.note ?? '').not.toContain('Imprudente');
  });
});
