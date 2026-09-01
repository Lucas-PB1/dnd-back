import {
  hasBlackPowderPistolExpert,
  ignoresBlackPowderPistolReload,
  isBlackPowderPistolPiece,
  syndicateQuickStrikeDice,
} from './grim-hollow-cap4-weapon-rules';
import type { EquippedWeaponPiece } from '../weapon-attacks/weapon-attack.types';

const pistol = (): EquippedWeaponPiece => ({
  itemSlug: 'blackpowder-pistol',
  itemName: 'Pistola de Pólvora',
  category: 'advanced',
  damage: '2d4',
  damageType: 'Perfurante',
  propertySlugs: ['blackpowder', 'light', 'loading', 'ammunition', 'firearm'],
  equipmentSlot: 'main_hand',
  versatileDamage: null,
  reloadCapacity: 1,
});

describe('grim-hollow-cap4-weapon-rules', () => {
  it('detects black powder pistols', () => {
    expect(isBlackPowderPistolPiece(pistol())).toBe(true);
    expect(
      isBlackPowderPistolPiece({
        ...pistol(),
        itemSlug: 'blackpowder-rifle',
        propertySlugs: ['blackpowder', 'two-handed', 'loading', 'ammunition'],
      }),
    ).toBe(false);
  });

  it('ignores reload with blackpowder-pistol-expert', () => {
    expect(
      ignoresBlackPowderPistolReload(pistol(), ['blackpowder-pistol-expert']),
    ).toBe(true);
    expect(ignoresBlackPowderPistolReload(pistol(), [])).toBe(false);
  });

  it('grants proficiency via feat flag', () => {
    expect(hasBlackPowderPistolExpert(['blackpowder-pistol-expert'])).toBe(true);
  });

  it('scales syndicate quick strike dice by level', () => {
    expect(syndicateQuickStrikeDice(1)).toBe('1d4');
    expect(syndicateQuickStrikeDice(9)).toBe('2d4');
    expect(syndicateQuickStrikeDice(16)).toBe('4d4');
  });
});
