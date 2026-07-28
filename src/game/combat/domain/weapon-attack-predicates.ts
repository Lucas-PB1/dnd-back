import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import type {
  EquippedWeaponPiece,
  WeaponAttackContext,
} from './weapon-attack.types';

const SIMPLE_PROFICIENCY = 'armas-simples';
const MARTIAL_PROFICIENCY = 'armas-marciais';
const MARTIAL_LIGHT_PROFICIENCY = 'armas-marciais-leves';
/** Martial Ranged only (ex.: Gunslinger) — martial + ammunition. */
const MARTIAL_RANGED_PROFICIENCY = 'armas-marciais-a-distancia';

/** Proficiências específicas (seeds S031) → item slug. */
const SPECIFIC_WEAPON_PROFICIENCY: Record<string, string> = {
  adagas: 'dagger',
  dardos: 'dart',
  fundas: 'sling',
  bordoes: 'quarterstaff',
  'bestas-leves': 'light-crossbow',
  'bestas-de-mao': 'hand-crossbow',
  'espada-longa': 'longsword',
  rapieira: 'rapier',
  'espada-curta': 'shortsword',
};

export function abilityMod(score: number): number {
  return Math.floor((score - 10) / 2);
}

export function hasStyleOrFeat(
  context: WeaponAttackContext,
  slug: string,
): boolean {
  return (
    (context.featSlugs ?? []).includes(slug) ||
    (context.fightingStyleSlugs ?? []).includes(slug)
  );
}

export function hasProperty(piece: EquippedWeaponPiece, slug: string): boolean {
  return piece.propertySlugs.includes(slug);
}

export function isAmmunitionWeapon(piece: EquippedWeaponPiece): boolean {
  return hasProperty(piece, 'ammunition');
}

export function isThrownWeapon(piece: EquippedWeaponPiece): boolean {
  return hasProperty(piece, 'thrown');
}

export function isTwoHanded(piece: EquippedWeaponPiece): boolean {
  return hasProperty(piece, 'two-handed');
}

export function qualifiesForGreatWeaponFighting(
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
  versatile2h: boolean,
): boolean {
  if (mode !== 'melee') return false;
  return isTwoHanded(piece) || versatile2h;
}

export function isLight(piece: EquippedWeaponPiece): boolean {
  return hasProperty(piece, 'light');
}

export function isMeleeCapable(piece: EquippedWeaponPiece): boolean {
  return !isAmmunitionWeapon(piece) || isThrownWeapon(piece);
}

export function isProficient(
  piece: EquippedWeaponPiece,
  context: WeaponAttackContext,
): boolean {
  const proficiencySlugs = [...context.weaponProficiencySlugs];
  if (hasStyleOrFeat(context, 'martial-weapon-training')) {
    proficiencySlugs.push(MARTIAL_PROFICIENCY);
  }

  for (const slug of proficiencySlugs) {
    const specific = SPECIFIC_WEAPON_PROFICIENCY[slug];
    if (specific && specific === piece.itemSlug) return true;
    if (
      slug === MARTIAL_LIGHT_PROFICIENCY &&
      piece.category === 'martial' &&
      isLight(piece)
    ) {
      return true;
    }
  }

  if (piece.category === 'simple') {
    return proficiencySlugs.includes(SIMPLE_PROFICIENCY);
  }
  if (piece.category === 'martial') {
    if (proficiencySlugs.includes(MARTIAL_PROFICIENCY)) return true;
    if (
      proficiencySlugs.includes(MARTIAL_RANGED_PROFICIENCY) &&
      isAmmunitionWeapon(piece)
    ) {
      return true;
    }
  }
  return false;
}

export function pickAbility(
  scores: AbilityScores,
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
): { slug: 'forca' | 'destreza'; mod: number } {
  const str = abilityMod(scores.forca);
  const dex = abilityMod(scores.destreza);

  if (mode === 'ranged' && !hasProperty(piece, 'finesse')) {
    return { slug: 'destreza', mod: dex };
  }
  if (hasProperty(piece, 'finesse')) {
    return str >= dex
      ? { slug: 'forca', mod: str }
      : { slug: 'destreza', mod: dex };
  }
  if (mode === 'ranged') {
    return { slug: 'destreza', mod: dex };
  }
  return { slug: 'forca', mod: str };
}

export function formatSigned(value: number): string {
  return value >= 0 ? `+${value}` : `${value}`;
}

export function qualifiesForDueling(
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
  equippedWeapons: EquippedWeaponPiece[],
): boolean {
  if (mode !== 'melee') return false;
  if (isTwoHanded(piece)) return false;
  if (isAmmunitionWeapon(piece)) return false;
  return equippedWeapons.length === 1;
}

export function buildModes(
  piece: EquippedWeaponPiece,
): Array<'melee' | 'ranged'> {
  if (isAmmunitionWeapon(piece)) return ['ranged'];
  if (isThrownWeapon(piece)) return ['melee', 'ranged'];
  return ['melee'];
}

export function usesVersatileTwoHanded(
  piece: EquippedWeaponPiece,
  equippedWeapons: EquippedWeaponPiece[],
  hasShield: boolean,
): boolean {
  if (!hasProperty(piece, 'versatile')) return false;
  if (piece.equipmentSlot !== 'main_hand') return false;
  if (hasShield) return false;
  if (equippedWeapons.some((w) => w.equipmentSlot === 'off_hand')) return false;
  return Boolean(piece.versatileDamage);
}

export function abilityShortLabel(slug: 'forca' | 'destreza'): string {
  return slug === 'forca' ? 'FOR' : 'DES';
}

export function formatDamageNote(
  damageDice: string,
  damageBonus: number,
  damageParts: string[],
): string {
  if (damageParts.length > 0) {
    return `${damageDice} ${formatSigned(damageBonus)} (${damageParts.join(' + ')})`;
  }
  return `${damageDice}${damageBonus !== 0 ? ` ${formatSigned(damageBonus)}` : ''}`;
}
