import { computeWeaponAttacks, type EquippedWeaponPiece } from './weapon-attack';
import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';

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

const dagger = (): EquippedWeaponPiece => ({
  itemSlug: 'dagger',
  itemName: 'Adaga',
  category: 'simple',
  damage: '1d4',
  damageType: 'Perfurante',
  versatileDamage: null,
  propertySlugs: ['finesse', 'thrown', 'light'],
  equipmentSlot: 'main_hand',
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
  it('uses STR + PB for a martial melee weapon when proficient', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], fighterContext);
    expect(attack.attackBonus).toBe(5); // +3 FOR + 2 PB
    expect(attack.damageDice).toBe('1d8');
    expect(attack.damageBonus).toBe(3);
    expect(attack.mode).toBe('melee');
    expect(attack.proficient).toBe(true);
  });

  it('omits PB when the class is not proficient with the weapon category', () => {
    const [attack] = computeWeaponAttacks(scores(), [longsword()], {
      proficiencyBonus: 2,
      weaponProficiencySlugs: ['armas-simples'],
    });
    expect(attack.attackBonus).toBe(3);
    expect(attack.proficient).toBe(false);
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
    expect(attack.attackBonus).toBe(2 + 2 + 2); // DES + PB + archery
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
    expect(attack.damageBonus).toBe(5); // +3 FOR + 2 dueling
  });

  it('does not apply dueling when two weapons are equipped', () => {
    const [attack] = computeWeaponAttacks(
      scores(),
      [longsword('main_hand'), { ...dagger(), equipmentSlot: 'off_hand' }],
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
    expect(attack.damageBonus).toBe(3 + 2); // FOR + PB
    expect(attack.damageNote).toContain('Mestre em Armas Grandes');
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
    expect(attack.damageBonus).toBe(2 + 2); // DES + PB
  });

  it('returns an empty list without equipped weapons', () => {
    expect(computeWeaponAttacks(scores(), [], fighterContext)).toEqual([]);
  });
});
