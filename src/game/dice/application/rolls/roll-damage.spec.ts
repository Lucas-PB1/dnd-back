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
  FIXTURE_CUNNING_STRIKE_EFFECTS,
  FIXTURE_DUNGEONEER_SLAYER_LABELS,
} from '@game/combat/domain/__fixtures__/mechanical-catalog.fixtures';
import { executeRollDamage } from './roll-damage';
import {
  findEquippedWeaponAttack,
  loadAccessibleCharacter,
} from './roll-weapon-context';

describe('executeRollDamage', () => {
  const resourceSpender = {
    spendClassResource: jest.fn().mockResolvedValue(undefined),
    consumeSpellSlotLevel: jest.fn().mockResolvedValue(undefined),
  };

  const mechanicalCatalog = {
    load: async () => ({
      cunningStrikeEffects: FIXTURE_CUNNING_STRIKE_EFFECTS,
      dungeoneerSlayerLabels: FIXTURE_DUNGEONEER_SLAYER_LABELS,
      gunslingerManeuvers: [],
      battleMasterManeuvers: [],
      tableActions: [],
      personaMasks: [],
      personaMaskSlugs: [],
      beastborneAspectBenefits: [],
      precautionSpells: [],
      economyActions: [],
      panelActions: [],
    }),
  };

  const base = {
    access: {} as never,
    sheet: {} as never,
    domain: { getProficiencyBonus: jest.fn().mockResolvedValue(3) } as never,
    weaponAttacks: {} as never,
    permanentItemEffects: {} as never,
    dataSource: {} as never,
    resourceSpender,
    mechanicalCatalog: mechanicalCatalog as never,
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
    });

    const result = await executeRollDamage({
      ...base,
      dto: { itemSlug: 'longsword', mode: 'melee', psiStrike: true },
    });

    expect(result.label).toContain('Golpe Psiônico');
    expect(result.expression).toContain('1d8+3');
    expect(result.note).toContain('Estocada Telecinética CD 14');
    expect(resourceSpender.spendClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ subclassSlug: 'psi-warrior' }),
      'psi-energy-dice',
      1,
    );
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
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

  it('doubles pre-smite damage for Death Strike and wraps the expression', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'rogue',
      subclassSlug: 'assassin',
      level: 17,
      abilityScores: {
        forca: 8,
        destreza: 20,
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
        damageBonus: 5,
        greatWeaponFighting: false,
        rageDamageBonus: 0,
        overkillExtraDice: null,
        brutalStrikeDice: null,
        abilitySlug: 'destreza',
        sneakAttackEligible: true,
      },
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
    });

    const result = await executeRollDamage({
      ...base,
      dto: {
        itemSlug: 'rapier',
        mode: 'melee',
        sneakAttack: true,
        assassinDeathStrike: true,
      },
    });

    expect(result.expression).toMatch(/^2×\(/);
    expect(result.note).toContain('Golpe Mortal');
    expect(result.label).toContain('Ataque Furtivo');
  });

  it('adds Radiant Strikes automatically for Paladin level 11 melee', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'paladin',
      subclassSlug: 'devotion',
      level: 11,
      abilityScores: {
        forca: 16,
        destreza: 10,
        constituicao: 14,
        inteligencia: 8,
        sabedoria: 10,
        carisma: 16,
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
    });

    const result = await executeRollDamage({
      ...base,
      dto: { itemSlug: 'longsword', mode: 'melee' },
    });

    expect(result.note).toContain('Golpes Radiantes');
    expect(result.expression).toContain('1d8');
  });

  it('does not add Radiant Strikes below level 11 or on ranged attacks', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'paladin',
      subclassSlug: 'devotion',
      level: 10,
      abilityScores: {
        forca: 16,
        destreza: 10,
        constituicao: 14,
        inteligencia: 8,
        sabedoria: 10,
        carisma: 16,
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
    });

    const melee = await executeRollDamage({
      ...base,
      dto: { itemSlug: 'longsword', mode: 'melee' },
    });
    expect(melee.note ?? '').not.toContain('Golpes Radiantes');

    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'paladin',
      subclassSlug: 'devotion',
      level: 11,
      abilityScores: {
        forca: 16,
        destreza: 10,
        constituicao: 14,
        inteligencia: 8,
        sabedoria: 10,
        carisma: 16,
      },
    });
    const ranged = await executeRollDamage({
      ...base,
      dto: { itemSlug: 'longsword', mode: 'ranged' },
    });
    expect(ranged.note ?? '').not.toContain('Golpes Radiantes');
  });

  it('debits a spell slot when Divine Smite is used', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'paladin',
      subclassSlug: 'devotion',
      level: 5,
      abilityScores: {
        forca: 16,
        destreza: 10,
        constituicao: 14,
        inteligencia: 8,
        sabedoria: 10,
        carisma: 16,
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
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
    });

    const result = await executeRollDamage({
      ...base,
      dto: {
        itemSlug: 'longsword',
        mode: 'melee',
        divineSmite: true,
        smiteSlotLevel: 1,
      },
    });

    expect(result.label).toContain('Destruição Divina');
    expect(result.note).toContain('Destruição Divina');
    expect(resourceSpender.consumeSpellSlotLevel).toHaveBeenCalledWith(
      expect.objectContaining({ classSlug: 'paladin' }),
      1,
    );
  });

  it('spends dread-strike for Dread Ambusher and adds psychic damage', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'ranger',
      subclassSlug: 'gloom-stalker',
      level: 3,
      abilityScores: {
        forca: 12,
        destreza: 16,
        constituicao: 14,
        inteligencia: 10,
        sabedoria: 14,
        carisma: 8,
      },
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Longbow',
        grazeOnMissDamage: null,
        damageDice: '1d8',
        damageBonus: 3,
        greatWeaponFighting: false,
        rageDamageBonus: 0,
        overkillExtraDice: null,
        brutalStrikeDice: null,
        abilitySlug: 'destreza',
      },
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
    });

    const result = await executeRollDamage({
      ...base,
      dto: {
        itemSlug: 'longbow',
        mode: 'ranged',
        dreadAmbusher: true,
      },
    });

    expect(result.label).toContain('Golpe Terrível');
    expect(result.note).toContain('Golpe Terrível');
    expect(resourceSpender.spendClassResource).toHaveBeenCalledWith(
      expect.objectContaining({ subclassSlug: 'gloom-stalker' }),
      'dread-strike',
      1,
    );
  });

  it('adds the Cleric Divine Strike dice at level 14', async () => {
    (loadAccessibleCharacter as jest.Mock).mockResolvedValueOnce({
      id: 'c1',
      classSlug: 'cleric',
      subclassSlug: 'war',
      level: 14,
      abilityScores: {
        forca: 16,
        destreza: 10,
        constituicao: 14,
        inteligencia: 10,
        sabedoria: 18,
        carisma: 8,
      },
    });
    (findEquippedWeaponAttack as jest.Mock).mockResolvedValue({
      attack: {
        itemName: 'Mace',
        grazeOnMissDamage: null,
        damageDice: '1d6',
        damageBonus: 3,
        greatWeaponFighting: false,
        rageDamageBonus: 0,
        overkillExtraDice: null,
        brutalStrikeDice: null,
        abilitySlug: 'forca',
      },
      combatFlags: { rageActive: false, recklessActive: false, bestialAspectLevel: 0 },
    });

    const result = await executeRollDamage({
      ...base,
      dto: {
        itemSlug: 'mace',
        mode: 'melee',
        divineStrike: true,
      },
    });

    expect(result.expression).toContain('+2d8');
    expect(result.note).toContain('Golpe Divino');
  });
});
