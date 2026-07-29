import {
  isMonkWeaponForAttack,
  martialArtsDie,
  martialArtsDieFaces,
  monkAttacksPerAction,
  monkCombatNotes,
  monkFocusSaveDc,
  unarmoredMovementBonusMeters,
} from './monk-features';
import type { EquippedWeaponPiece } from './weapon-attack.types';

const piece = (over: Partial<EquippedWeaponPiece>): EquippedWeaponPiece => ({
  itemSlug: 'club',
  itemName: 'Clava',
  category: 'simple',
  damage: '1d4',
  damageType: 'Contundente',
  versatileDamage: null,
  propertySlugs: [],
  equipmentSlot: 'main_hand',
  ...over,
});

describe('monk-features', () => {
  it('escalates the Martial Arts die by tier', () => {
    expect(martialArtsDieFaces(1)).toBe(6);
    expect(martialArtsDieFaces(5)).toBe(8);
    expect(martialArtsDieFaces(11)).toBe(10);
    expect(martialArtsDieFaces(17)).toBe(12);
    expect(martialArtsDie(5)).toBe('1d8');
  });

  it('computes the Focus save DC as 8 + WIS + PB', () => {
    expect(monkFocusSaveDc({ wisdomModifier: 3, proficiencyBonus: 3 })).toBe(14);
  });

  it('adds unarmored movement only for monks', () => {
    expect(unarmoredMovementBonusMeters({ classSlug: 'monk', level: 2 })).toBe(3);
    expect(unarmoredMovementBonusMeters({ classSlug: 'monk', level: 10 })).toBe(6);
    expect(unarmoredMovementBonusMeters({ classSlug: 'fighter', level: 10 })).toBe(0);
  });

  it('grants Extra Attack at level 5', () => {
    expect(monkAttacksPerAction(4)).toBe(1);
    expect(monkAttacksPerAction(5)).toBe(2);
  });

  it('recognises monk weapons for melee only', () => {
    expect(isMonkWeaponForAttack(piece({}), 'melee')).toBe(true);
    expect(isMonkWeaponForAttack(piece({}), 'ranged')).toBe(false);
    expect(
      isMonkWeaponForAttack(
        piece({ category: 'martial', propertySlugs: ['light'] }),
        'melee',
      ),
    ).toBe(true);
    expect(
      isMonkWeaponForAttack(piece({ category: 'martial' }), 'melee'),
    ).toBe(false);
  });

  it('describes core and subclass notes', () => {
    const notes = monkCombatNotes({
      classSlug: 'monk',
      subclassSlug: 'mercy',
      level: 5,
    });
    expect(notes[0]).toContain('Artes Marciais');
    expect(notes.some((note) => note.includes('Golpe Atordoante'))).toBe(true);
    expect(notes.some((note) => note.includes('Mão de Cura'))).toBe(true);
  });

  it('returns no notes for non-monks', () => {
    expect(monkCombatNotes({ classSlug: 'rogue', level: 5 })).toEqual([]);
  });
});
