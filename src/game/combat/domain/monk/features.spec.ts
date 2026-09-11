import {
  isMonkWeaponForAttack,
  martialArtsDie,
  martialArtsDieFaces,
  monkAttacksPerAction,
  monkFocusSaveDc,
  unarmoredMovementBonusMeters,
} from './features';
import type { EquippedWeaponPiece } from '../weapon-attacks/weapon-attack.types';
import { fixtureSchedulesFor } from '../feature-schedule.fixtures';

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
  const monkBands = fixtureSchedulesFor('monk');

  it('escalates the Martial Arts die by tier', () => {
    expect(martialArtsDieFaces(1, monkBands)).toBe(6);
    expect(martialArtsDieFaces(5, monkBands)).toBe(8);
    expect(martialArtsDieFaces(11, monkBands)).toBe(10);
    expect(martialArtsDieFaces(17, monkBands)).toBe(12);
    expect(martialArtsDie(5, monkBands)).toBe('1d8');
  });

  it('computes the Focus save DC as 8 + WIS + PB', () => {
    expect(monkFocusSaveDc({ wisdomModifier: 3, proficiencyBonus: 3 })).toBe(14);
  });

  it('adds unarmored movement only for monks', () => {
    expect(unarmoredMovementBonusMeters({ classSlug: 'monk', level: 2, featureSchedules: monkBands })).toBe(3);
    expect(unarmoredMovementBonusMeters({ classSlug: 'monk', level: 10, featureSchedules: monkBands })).toBe(6);
    expect(unarmoredMovementBonusMeters({ classSlug: 'fighter', level: 10, featureSchedules: [] })).toBe(0);
  });

  it('grants Extra Attack at level 5', () => {
    expect(monkAttacksPerAction(4, monkBands)).toBe(1);
    expect(monkAttacksPerAction(5, monkBands)).toBe(2);
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
});
