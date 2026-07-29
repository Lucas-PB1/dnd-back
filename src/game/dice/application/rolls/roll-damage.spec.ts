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
import { executeRollDamage } from './roll-damage';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';

describe('executeRollDamage', () => {
  const base = {
    access: {} as never,
    sheet: {} as never,
    domain: { getProficiencyBonus: jest.fn().mockResolvedValue(3) } as never,
    weaponAttacks: {} as never,
    permanentItemEffects: {} as never,
    dataSource: {} as never,
    userId: 'u1',
    characterId: 'c1',
  };

  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('returns graze-on-miss flat damage', async () => {
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Greataxe',
        grazeOnMissDamage: 3,
        damageDice: '1d12',
        damageBonus: 3,
        greatWeaponFighting: false,
        rageDamageBonus: 0,
        overkillExtraDice: null,
        brutalStrikeDice: null,
        abilitySlug: 'forca',
      },
      combatFlags: { rageActive: false, recklessActive: false },
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
      attack: {
        itemName: 'Longsword',
        grazeOnMissDamage: null,
        rageDamageBonus: 0,
      },
      combatFlags: { rageActive: false, recklessActive: false },
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
      attack: {
        itemName: 'Greataxe',
        grazeOnMissDamage: null,
        damageDice: '1d12',
        damageBonus: 4,
        greatWeaponFighting: true,
        rageDamageBonus: 0,
        overkillExtraDice: null,
        brutalStrikeDice: '1d10',
        abilitySlug: 'forca',
      },
      combatFlags: { rageActive: false, recklessActive: false },
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

  it('adds Psi Strike damage and reports Telekinetic Thrust DC', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'fighter',
      subclassSlug: 'psi-warrior',
      level: 7,
      abilityScores: {
        forca: 16,
        destreza: 12,
        constituicao: 14,
        inteligencia: 16,
        sabedoria: 10,
        carisma: 8,
      },
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Longsword',
        grazeOnMissDamage: null,
        damageDice: '1d8',
        damageBonus: 3,
        greatWeaponFighting: false,
        rageDamageBonus: 0,
        overkillExtraDice: null,
        brutalStrikeDice: null,
        abilitySlug: 'forca',
      },
      combatFlags: { rageActive: false, recklessActive: false },
    });

    const result = await executeRollDamage({
      ...base,
      dto: { itemSlug: 'longsword', mode: 'melee', psiStrike: true },
    });

    expect(result.label).toContain('Golpe Psiônico');
    expect(result.expression).toContain('1d8+3');
    expect(result.note).toContain('Estocada Telecinética CD 14');
  });

  it('rolls remaining Sneak Attack dice and doubles those dice on a critical', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'rogue',
      subclassSlug: 'thief',
      level: 5,
      abilityScores: {
        forca: 8,
        destreza: 18,
        constituicao: 12,
        inteligencia: 12,
        sabedoria: 10,
        carisma: 10,
      },
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Rapier',
        grazeOnMissDamage: null,
        damageDice: '1d8',
        damageBonus: 4,
        greatWeaponFighting: false,
        rageDamageBonus: 0,
        overkillExtraDice: null,
        brutalStrikeDice: null,
        abilitySlug: 'destreza',
        sneakAttackEligible: true,
      },
      combatFlags: { rageActive: false, recklessActive: false },
    });

    const result = await executeRollDamage({
      ...base,
      dto: {
        itemSlug: 'rapier',
        mode: 'melee',
        critical: true,
        sneakAttack: true,
        cunningStrikeEffects: ['trip'],
      },
    });

    expect(result.expression).toContain('4d6');
    expect(result.rolls).toHaveLength(6);
    expect(result.note).toContain('Tropeço');
    expect(result.note).toContain('CD 15');
  });

  it('rejects Sneak Attack with an ineligible melee weapon', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'rogue',
      subclassSlug: null,
      level: 5,
      abilityScores: {
        forca: 16,
        destreza: 14,
        constituicao: 12,
        inteligencia: 10,
        sabedoria: 10,
        carisma: 10,
      },
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Longsword',
        grazeOnMissDamage: null,
        damageDice: '1d8',
        damageBonus: 3,
        greatWeaponFighting: false,
        rageDamageBonus: 0,
        overkillExtraDice: null,
        brutalStrikeDice: null,
        abilitySlug: 'forca',
        sneakAttackEligible: false,
      },
      combatFlags: { rageActive: false, recklessActive: false },
    });

    await expect(
      executeRollDamage({
        ...base,
        dto: {
          itemSlug: 'longsword',
          mode: 'melee',
          sneakAttack: true,
        },
      }),
    ).rejects.toThrow(/Finesse weapon or a ranged attack/);
  });
});
