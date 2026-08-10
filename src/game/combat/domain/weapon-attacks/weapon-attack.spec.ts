import {
  analyzeDualWield,
  computeWeaponAttacks,
  type EquippedWeaponPiece,
} from './weapon-attack';
import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';

const scores = (partial: Partial<AbilityScores> = {}): AbilityScores => ({
  forca: 16,
  destreza: 14,
  constituicao: 13,
  inteligencia: 10,
  sabedoria: 12,
  carisma: 8,
  ...partial,
});

const longsword = (slot: EquippedWeaponPiece['equipmentSlot'] = 'main_hand'): EquippedWeaponPiece => ({
  itemSlug: 'longsword',
  itemName: 'Espada Longa',
  category: 'martial',
  damage: '1d8',
  damageType: 'Cortante',
  versatileDamage: '1d10',
  propertySlugs: ['versatile'],
  equipmentSlot: slot,
});

const longbow = (): EquippedWeaponPiece => ({
  itemSlug: 'longbow',
  itemName: 'Arco Longo',
  category: 'martial',
  damage: '1d8',
  damageType: 'Perfurante',
  versatileDamage: null,
  propertySlugs: ['two-handed', 'ammunition', 'heavy'],
  equipmentSlot: 'main_hand',
});

const dagger = (slot: EquippedWeaponPiece['equipmentSlot'] = 'main_hand'): EquippedWeaponPiece => ({
  itemSlug: 'dagger',
  itemName: 'Adaga',
  category: 'simple',
  damage: '1d4',
  damageType: 'Perfurante',
  versatileDamage: null,
  propertySlugs: ['finesse', 'thrown', 'light'],
  equipmentSlot: slot,
});

const shortsword = (slot: EquippedWeaponPiece['equipmentSlot'] = 'off_hand'): EquippedWeaponPiece => ({
  itemSlug: 'shortsword',
  itemName: 'Espada Curta',
  category: 'martial',
  damage: '1d6',
  damageType: 'Perfurante',
  versatileDamage: null,
  propertySlugs: ['finesse', 'light'],
  equipmentSlot: slot,
});

const greataxe = (): EquippedWeaponPiece => ({
  itemSlug: 'greataxe',
  itemName: 'Machado Grande',
  category: 'martial',
  damage: '1d12',
  damageType: 'Cortante',
  versatileDamage: null,
  propertySlugs: ['two-handed', 'heavy'],
  equipmentSlot: 'main_hand',
});

const fighterContext = {
  proficiencyBonus: 2,
  weaponProficiencySlugs: ['armas-simples', 'armas-marciais'],
};

describe('computeWeaponAttacks', () => {
  it('uses STR + PB and versatile 2H die when alone in main hand', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], fighterContext);
    expect(attack.attackBonus).toBe(5);
    expect(attack.damageDice).toBe('1d10');
    expect(attack.damageBonus).toBe(3);
    expect(attack.attackNote).toContain('versátil (2 mãos)');
    expect(attack.proficient).toBe(true);
  });

  it('uses 1H die when versatile weapon is paired with a shield', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], {
      ...fighterContext,
      hasShield: true,
    });
    expect(attack.damageDice).toBe('1d8');
    expect(attack.attackNote).toContain('versátil (1 mão)');
  });

  it('uses 1H die when off-hand weapon is equipped', () => {
    const [attack] = computeWeaponAttacks(
      scores(),
      [longsword('main_hand'), dagger('off_hand')],
      fighterContext,
    ).filter((a) => a.itemSlug === 'longsword' && a.mode === 'melee');
    expect(attack.damageDice).toBe('1d8');
  });

  it('omits PB when the class is not proficient with the weapon category', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], {
      proficiencyBonus: 2,
      weaponProficiencySlugs: ['armas-simples'],
    });
    expect(attack.attackBonus).toBe(3);
    expect(attack.proficient).toBe(false);
  });

  it('grants proficiency from specific weapon group (wizard + dagger)', () => {
    const [melee] = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      [dagger()],
      {
        proficiencyBonus: 2,
        weaponProficiencySlugs: ['adagas', 'dardos', 'fundas', 'bordoes', 'bestas-leves'],
      },
    ).filter((a) => a.mode === 'melee');
    expect(melee.proficient).toBe(true);
    expect(melee.attackBonus).toBe(5);
  });

  it('does not grant longsword from adagas-only list', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], {
      proficiencyBonus: 2,
      weaponProficiencySlugs: ['adagas'],
    });
    expect(attack.proficient).toBe(false);
  });

  it('grants martial light weapons from armas-marciais-leves', () => {
    const [melee] = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      [shortsword('main_hand')],
      {
        proficiencyBonus: 2,
        weaponProficiencySlugs: ['armas-simples', 'armas-marciais-leves'],
      },
    ).filter((a) => a.mode === 'melee');
    expect(melee.proficient).toBe(true);
  });

  it('grants martial ranged only from armas-marciais-a-distancia', () => {
    const gunslinger = {
      proficiencyBonus: 2,
      weaponProficiencySlugs: [
        'armas-simples',
        'armas-marciais-a-distancia',
      ],
    };
    const [bow] = computeWeaponAttacks(scores(), [longbow()], gunslinger);
    expect(bow.proficient).toBe(true);
    const [sword] = computeWeaponAttacks(scores(), [longsword()], gunslinger);
    expect(sword.proficient).toBe(false);
    const [blade] = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      [dagger()],
      gunslinger,
    ).filter((a) => a.mode === 'melee');
    expect(blade.proficient).toBe(true);
  });

  it('grants martial proficiency from martial-weapon-training feat', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], {
      proficiencyBonus: 2,
      weaponProficiencySlugs: ['armas-simples'],
      featSlugs: ['martial-weapon-training'],
    });
    expect(attack.proficient).toBe(true);
    expect(attack.attackBonus).toBe(5);
  });

  it('uses DEX for ammunition weapons and applies archery +2', () => {
    const [attack] = computeWeaponAttacks(scores(), [longbow()], {
      ...fighterContext,
      fightingStyleSlugs: ['archery'],
    });
    expect(attack.mode).toBe('ranged');
    expect(attack.abilitySlug).toBe('destreza');
    expect(attack.attackBonus).toBe(2 + 2 + 2);
    expect(attack.damageBonus).toBe(2);
  });

  it('picks the better ability for finesse weapons', () => {
    const [melee] = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      [dagger()],
      fighterContext,
    ).filter((attack) => attack.mode === 'melee');
    expect(melee.abilitySlug).toBe('destreza');
    expect(melee.attackBonus).toBe(5);
  });

  it('emits melee and ranged modes for thrown weapons', () => {
    const attacks = computeWeaponAttacks(scores(), [dagger()], fighterContext);
    expect(attacks.map((a) => a.mode).sort()).toEqual(['melee', 'ranged']);
  });

  it('applies dueling +2 damage with a single one-handed melee weapon', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], {
      ...fighterContext,
      featSlugs: ['dueling'],
    });
    expect(attack.damageBonus).toBe(5);
  });

  it('does not apply dueling when two weapons are equipped', () => {
    const [attack] = computeWeaponAttacks(
      scores(),
      [longsword('main_hand'), dagger('off_hand')],
      { ...fighterContext, fightingStyleSlugs: ['dueling'] },
    ).filter((a) => a.itemSlug === 'longsword' && a.mode === 'melee');
    expect(attack.damageBonus).toBe(3);
  });

  it('applies thrown-weapon-fighting on the ranged thrown mode only', () => {
    const attacks = computeWeaponAttacks(scores(), [dagger()], {
      ...fighterContext,
      fightingStyleSlugs: ['thrown-weapon-fighting'],
    });
    const melee = attacks.find((a) => a.mode === 'melee')!;
    const ranged = attacks.find((a) => a.mode === 'ranged')!;
    expect(melee.damageBonus).toBe(3);
    expect(ranged.damageBonus).toBe(5);
  });

  it('applies great-weapon-master PB damage with heavy weapons', () => {
    const [attack] = computeWeaponAttacks(scores(), [greataxe()], {
      ...fighterContext,
      featSlugs: ['great-weapon-master'],
    });
    expect(attack.damageBonus).toBe(3 + 2);
    expect(attack.damageNote).toContain('Mestre em Armas Grandes');
  });

  it('flags great-weapon-fighting on two-handed melee', () => {
    const [attack] = computeWeaponAttacks(scores(), [greataxe()], {
      ...fighterContext,
      fightingStyleSlugs: ['great-weapon-fighting'],
    });
    expect(attack.greatWeaponFighting).toBe(true);
    expect(attack.damageNote).toContain('GWF');
  });

  it('flags great-weapon-fighting on versatile 2H melee', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], {
      ...fighterContext,
      featSlugs: ['great-weapon-fighting'],
    });
    expect(attack.greatWeaponFighting).toBe(true);
  });

  it('does not flag GWF when versatile weapon is used one-handed', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], {
      ...fighterContext,
      fightingStyleSlugs: ['great-weapon-fighting'],
      hasShield: true,
    });
    expect(attack.greatWeaponFighting).toBe(false);
  });

  it('does not flag GWF on ranged attacks', () => {
    const [attack] = computeWeaponAttacks(scores(), [longbow()], {
      ...fighterContext,
      fightingStyleSlugs: ['great-weapon-fighting'],
    });
    expect(attack.greatWeaponFighting).toBe(false);
  });

  it('does not apply great-weapon-master without the heavy property', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], {
      ...fighterContext,
      featSlugs: ['great-weapon-master'],
    });
    expect(attack.damageBonus).toBe(3);
  });

  it('applies great-weapon-master to heavy ranged weapons too', () => {
    const [attack] = computeWeaponAttacks(scores(), [longbow()], {
      ...fighterContext,
      featSlugs: ['great-weapon-master'],
    });
    expect(attack.damageBonus).toBe(2 + 2);
  });

  it('activates weapon mastery when the weapon type is mastered', () => {
    const piece = {
      ...longsword(),
      masterySlug: 'sap',
      masteryName: 'Drenar',
    };
    const [attack] = computeWeaponAttacks(scores(), [piece], {
      ...fighterContext,
      masteredWeaponSlugs: ['longsword'],
    });
    expect(attack.masteryActive).toBe(true);
    expect(attack.masterySlug).toBe('sap');
    expect(attack.masteryName).toBe('Drenar');
    expect(attack.attackNote).toContain('Maestria: Drenar');
  });

  it('applies Nick note on light bonus attacks', () => {
    const main = {
      ...dagger('main_hand'),
      masterySlug: 'nick',
      masteryName: 'Ágil',
    };
    const off = {
      ...shortsword('off_hand'),
      masterySlug: 'vex',
      masteryName: 'Afligir',
    };
    const attack = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      [main, off],
      {
        ...fighterContext,
        masteredWeaponSlugs: ['dagger', 'shortsword'],
      },
    ).find((row) => row.itemSlug === 'shortsword' && row.mode === 'melee')!;
    expect(attack.nickUsesAttackAction).toBe(false);
  });

  it('flags Nick on light bonus when off-hand weapon has nick mastery', () => {
    const main = {
      ...shortsword('main_hand'),
      masterySlug: 'vex',
      masteryName: 'Afligir',
    };
    const off = {
      ...dagger('off_hand'),
      masterySlug: 'nick',
      masteryName: 'Ágil',
    };
    const attack = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      [main, off],
      {
        ...fighterContext,
        masteredWeaponSlugs: ['dagger'],
      },
    ).find((row) => row.itemSlug === 'dagger' && row.mode === 'melee')!;
    expect(attack.role).toBe('light_bonus');
    expect(attack.nickUsesAttackAction).toBe(true);
    expect(attack.attackNote).toContain('Ágil · ação Atacar');
  });

  it('exposes graze on-miss damage when mastered', () => {
    const piece = {
      itemSlug: 'greatsword',
      itemName: 'Espada Grande',
      category: 'martial',
      damage: '2d6',
      damageType: 'Cortante',
      versatileDamage: null,
      propertySlugs: ['two-handed', 'heavy'],
      equipmentSlot: 'main_hand' as const,
      masterySlug: 'graze',
      masteryName: 'Resvalar',
    };
    const [attack] = computeWeaponAttacks(scores(), [piece], {
      ...fighterContext,
      masteredWeaponSlugs: ['greatsword'],
    });
    expect(attack.grazeOnMissDamage).toBe(3);
  });

  it('marks light bonus off-hand without ability damage', () => {
    const off = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      [dagger('main_hand'), shortsword('off_hand')],
      fighterContext,
    ).find((a) => a.itemSlug === 'shortsword' && a.mode === 'melee')!;
    expect(off.role).toBe('light_bonus');
    expect(off.omitsAbilityDamage).toBe(true);
    expect(off.damageBonus).toBe(0);
    expect(off.attackNote).toContain('ataque adicional (Leve)');
  });

  it('adds ability damage on light bonus with two-weapon-fighting', () => {
    const off = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      [dagger('main_hand'), shortsword('off_hand')],
      { ...fighterContext, fightingStyleSlugs: ['two-weapon-fighting'] },
    ).find((a) => a.itemSlug === 'shortsword' && a.mode === 'melee')!;
    expect(off.omitsAbilityDamage).toBe(false);
    expect(off.damageBonus).toBe(3);
  });

  it('allows dual-wielder bonus with non-light off-hand', () => {
    const off = computeWeaponAttacks(
      scores(),
      [dagger('main_hand'), longsword('off_hand')],
      { ...fighterContext, featSlugs: ['dual-wielder'] },
    ).find((a) => a.itemSlug === 'longsword' && a.mode === 'melee')!;
    expect(off.role).toBe('dual_bonus');
    expect(off.omitsAbilityDamage).toBe(true);
    expect(off.attackNote).toContain('Ambidestro');
  });

  it('flags attack disadvantage for heavy weapons on small creatures', () => {
    const [attack] = computeWeaponAttacks(scores(), [greataxe()], {
      ...fighterContext,
      sizeCategory: 'small',
    });
    expect(attack.attackDisadvantage).toBe(true);
    expect(attack.attackNote).toContain('desvantagem');
  });

  it('returns an empty list without equipped weapons', () => {
    expect(computeWeaponAttacks(scores(), [], fighterContext)).toEqual([]);
  });

  it('omits ability damage on firearms and expands crit for gunslinger', () => {
    const revolver: EquippedWeaponPiece = {
      itemSlug: 'revolver',
      itemName: 'Revólver',
      category: 'martial',
      damage: '2d8',
      damageType: 'Perfurante',
      versatileDamage: null,
      propertySlugs: ['ammunition', 'firearm', 'reload'],
      equipmentSlot: 'main_hand',
      reloadCapacity: 6,
    };
    const [attack] = computeWeaponAttacks(scores({ destreza: 16 }), [revolver], {
      proficiencyBonus: 2,
      weaponProficiencySlugs: ['armas-simples', 'armas-marciais-a-distancia'],
      classSlug: 'gunslinger',
      level: 5,
    });
    expect(attack.isFirearm).toBe(true);
    expect(attack.damageBonus).toBe(0);
    expect(attack.omitsAbilityDamage).toBe(true);
    expect(attack.critThreshold).toBe(19);
    expect(attack.reloadCapacity).toBe(6);
  });

  it('applies overkill ability mod on firearms at level 11+', () => {
    const revolver: EquippedWeaponPiece = {
      itemSlug: 'revolver',
      itemName: 'Revólver',
      category: 'martial',
      damage: '2d8',
      damageType: 'Perfurante',
      versatileDamage: null,
      propertySlugs: ['ammunition', 'firearm', 'reload'],
      equipmentSlot: 'main_hand',
      reloadCapacity: 6,
    };
    const [attack] = computeWeaponAttacks(scores({ destreza: 16 }), [revolver], {
      proficiencyBonus: 4,
      weaponProficiencySlugs: ['armas-simples', 'armas-marciais-a-distancia'],
      classSlug: 'gunslinger',
      level: 11,
    });
    expect(attack.damageBonus).toBe(3);
    expect(attack.omitsAbilityDamage).toBe(false);
    expect(attack.damageNote).toContain('Exagero');
  });

  it('adds rage damage on barbarian melee Strength while raging', () => {
    const [attack] = computeWeaponAttacks(scores({ forca: 16 }), [greataxe()], {
      proficiencyBonus: 3,
      weaponProficiencySlugs: ['armas-simples', 'armas-marciais'],
      classSlug: 'barbarian',
      level: 9,
      rageActive: true,
    });
    expect(attack.rageDamageBonus).toBe(3);
    expect(attack.damageBonus).toBe(3 + 3); // FOR + Fúria
    expect(attack.damageNote).toContain('Fúria +3');
    expect(attack.brutalStrikeDice).toBe('1d10');
  });

  it('adds a synthetic Unarmed Strike with the Martial Arts die for monks', () => {
    const attacks = computeWeaponAttacks(scores({ forca: 10, destreza: 16 }), [], {
      proficiencyBonus: 3,
      weaponProficiencySlugs: [],
      classSlug: 'monk',
      level: 5,
    });
    const unarmed = attacks.find((a) => a.itemSlug === 'unarmed-strike')!;
    expect(unarmed).toBeDefined();
    expect(unarmed.proficient).toBe(true);
    expect(unarmed.abilitySlug).toBe('destreza');
    expect(unarmed.attackBonus).toBe(3 + 3); // DES + PB
    expect(unarmed.damageDice).toBe('1d8');
    expect(unarmed.martialArtsDie).toBe('1d8');
  });

  it('upgrades a monk weapon die and allows DEX', () => {
    const [attack] = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      [dagger('main_hand')],
      {
        proficiencyBonus: 2,
        weaponProficiencySlugs: ['armas-simples'],
        classSlug: 'monk',
        level: 11,
      },
    ).filter((a) => a.itemSlug === 'dagger' && a.mode === 'melee');
    expect(attack.abilitySlug).toBe('destreza');
    expect(attack.damageDice).toBe('1d10'); // Martial Arts die beats 1d4
    expect(attack.martialArtsDie).toBe('1d10');
  });

  it('does not grant Martial Arts benefits while a shield is equipped', () => {
    const attacks = computeWeaponAttacks(scores(), [], {
      proficiencyBonus: 3,
      weaponProficiencySlugs: [],
      classSlug: 'monk',
      level: 5,
      hasShield: true,
    });
    const unarmed = attacks.find((a) => a.itemSlug === 'unarmed-strike')!;
    expect(unarmed.martialArtsDie).toBeNull();
    expect(unarmed.damageDice).toBe('1'); // fica com o dano base 1
  });

  it('computes Soulknife Psychic Blades from catalog pieces (sneak + bonus blade)', () => {
    const catalogPieces: EquippedWeaponPiece[] = [
      {
        itemSlug: 'psychic-blade',
        itemName: 'Lâmina Psíquica',
        category: 'simple',
        damage: '1d6',
        damageType: 'Psíquico',
        versatileDamage: null,
        propertySlugs: ['finesse', 'thrown'],
        equipmentSlot: 'main_hand',
        masterySlug: 'vex',
        masteryName: 'Afligir',
      },
      {
        itemSlug: 'psychic-blade-bonus',
        itemName: 'Lâmina Psíquica (adicional)',
        category: 'simple',
        damage: '1d4',
        damageType: 'Psíquico',
        versatileDamage: null,
        propertySlugs: ['finesse', 'thrown', 'light'],
        equipmentSlot: 'off_hand',
        masterySlug: 'vex',
        masteryName: 'Afligir',
      },
    ];
    const attacks = computeWeaponAttacks(
      scores({ forca: 10, destreza: 16 }),
      catalogPieces,
      {
        proficiencyBonus: 4,
        weaponProficiencySlugs: [],
        classSlug: 'rogue',
        subclassSlug: 'soulknife',
        level: 9,
      },
    );
    const mainMelee = attacks.find(
      (a) => a.itemSlug === 'psychic-blade' && a.mode === 'melee',
    )!;
    const mainRanged = attacks.find(
      (a) => a.itemSlug === 'psychic-blade' && a.mode === 'ranged',
    )!;
    const bonus = attacks.find(
      (a) => a.itemSlug === 'psychic-blade-bonus' && a.mode === 'melee',
    )!;

    expect(mainMelee).toMatchObject({
      proficient: true,
      abilitySlug: 'destreza',
      damageDice: '1d6',
      damageType: 'Psíquico',
      sneakAttackEligible: true,
      masterySlug: 'vex',
      masteryActive: true,
    });
    expect(mainMelee.attackBonus).toBe(3 + 4);
    expect(mainRanged.sneakAttackEligible).toBe(true);
    expect(bonus).toMatchObject({
      damageDice: '1d4',
      role: 'light_bonus',
      sneakAttackEligible: true,
      omitsAbilityDamage: true,
    });
    expect(bonus.attackNote).toContain('segunda lâmina');
  });
});

describe('analyzeDualWield', () => {
  it('requires dual-wielder when off-hand is not light', () => {
    const result = analyzeDualWield(
      [dagger('main_hand'), longsword('off_hand')],
      fighterContext,
    );
    expect(result.bonusRole).toBeNull();
    expect(result.dualWieldNeedsFeat).toBe(true);
  });
});
