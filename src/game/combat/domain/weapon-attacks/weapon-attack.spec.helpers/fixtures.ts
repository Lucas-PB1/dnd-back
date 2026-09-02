import type { AbilityScores } from '@game/shared/infrastructure/player-character.entity';
import type { EquippedWeaponPiece } from '../weapon-attack';
import type { WeaponAttackContext } from '../weapon-attack.types';

export function testScores(partial: Partial<AbilityScores> = {}): AbilityScores {
  return {
    forca: 16,
    destreza: 14,
    constituicao: 13,
    inteligencia: 10,
    sabedoria: 12,
    carisma: 8,
    ...partial,
  };
}

export const FIGHTER_CTX: WeaponAttackContext = {
  proficiencyBonus: 2,
  weaponProficiencySlugs: ['armas-simples', 'armas-marciais'],
};

export const GUNSLINGER_RANGED_CTX: WeaponAttackContext = {
  proficiencyBonus: 2,
  weaponProficiencySlugs: ['armas-simples', 'armas-marciais-a-distancia'],
};

export function longsword(
  slot: EquippedWeaponPiece['equipmentSlot'] = 'main_hand',
): EquippedWeaponPiece {
  return {
    itemSlug: 'longsword',
    itemName: 'Espada Longa',
    category: 'martial',
    damage: '1d8',
    damageType: 'Cortante',
    versatileDamage: '1d10',
    propertySlugs: ['versatile'],
    equipmentSlot: slot,
  };
}

export function longbow(): EquippedWeaponPiece {
  return {
    itemSlug: 'longbow',
    itemName: 'Arco Longo',
    category: 'martial',
    damage: '1d8',
    damageType: 'Perfurante',
    versatileDamage: null,
    propertySlugs: ['two-handed', 'ammunition', 'heavy'],
    equipmentSlot: 'main_hand',
  };
}

export function dagger(
  slot: EquippedWeaponPiece['equipmentSlot'] = 'main_hand',
): EquippedWeaponPiece {
  return {
    itemSlug: 'dagger',
    itemName: 'Adaga',
    category: 'simple',
    damage: '1d4',
    damageType: 'Perfurante',
    versatileDamage: null,
    propertySlugs: ['finesse', 'thrown', 'light'],
    equipmentSlot: slot,
  };
}

export function shortsword(
  slot: EquippedWeaponPiece['equipmentSlot'] = 'off_hand',
): EquippedWeaponPiece {
  return {
    itemSlug: 'shortsword',
    itemName: 'Espada Curta',
    category: 'martial',
    damage: '1d6',
    damageType: 'Perfurante',
    versatileDamage: null,
    propertySlugs: ['finesse', 'light'],
    equipmentSlot: slot,
  };
}

export function greataxe(): EquippedWeaponPiece {
  return {
    itemSlug: 'greataxe',
    itemName: 'Machado Grande',
    category: 'martial',
    damage: '1d12',
    damageType: 'Cortante',
    versatileDamage: null,
    propertySlugs: ['two-handed', 'heavy'],
    equipmentSlot: 'main_hand',
  };
}

export function catchpole(): EquippedWeaponPiece {
  return {
    itemSlug: 'catchpole',
    itemName: 'Catchpole',
    category: 'advanced',
    damage: '1d6',
    damageType: 'Perfurante',
    propertySlugs: ['hafted', 'reach', 'two-handed'],
    equipmentSlot: 'main_hand',
    versatileDamage: null,
  };
}

export function revolver(): EquippedWeaponPiece {
  return {
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
}

export function blackpowderPistol(): EquippedWeaponPiece {
  return {
    itemSlug: 'blackpowder-pistol',
    itemName: 'Pistola de Pólvora',
    category: 'advanced',
    damage: '2d4',
    damageType: 'Perfurante',
    versatileDamage: null,
    propertySlugs: [
      'blackpowder',
      'light',
      'loading',
      'ammunition',
      'firearm',
      'reload',
    ],
    equipmentSlot: 'main_hand',
    reloadCapacity: 1,
  };
}

export function greatswordGraze(): EquippedWeaponPiece {
  return {
    itemSlug: 'greatsword',
    itemName: 'Espada Grande',
    category: 'martial',
    damage: '2d6',
    damageType: 'Cortante',
    versatileDamage: null,
    propertySlugs: ['two-handed', 'heavy'],
    equipmentSlot: 'main_hand',
    masterySlug: 'graze',
    masteryName: 'Resvalar',
  };
}

export const SOULKNIFE_PSYCHIC_BLADES: EquippedWeaponPiece[] = [
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
