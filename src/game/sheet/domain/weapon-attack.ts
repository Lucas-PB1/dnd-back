import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';

export type EquippedWeaponPiece = {
  itemSlug: string;
  itemName: string;
  /** `simple` | `martial` */
  category: string;
  damage: string | null;
  damageType: string | null;
  versatileDamage: string | null;
  propertySlugs: string[];
  equipmentSlot: 'main_hand' | 'off_hand' | string;
};

export type WeaponAttackContext = {
  proficiencyBonus: number;
  /** Ex.: `armas-simples`, `armas-marciais`. */
  weaponProficiencySlugs: readonly string[];
  featSlugs?: readonly string[];
  fightingStyleSlugs?: readonly string[];
};

export type WeaponAttack = {
  itemSlug: string;
  itemName: string;
  mode: 'melee' | 'ranged';
  attackBonus: number;
  abilitySlug: 'forca' | 'destreza';
  proficient: boolean;
  damageDice: string;
  damageBonus: number;
  damageType: string | null;
  attackNote: string;
  damageNote: string;
};

const SIMPLE_PROFICIENCY = 'armas-simples';
const MARTIAL_PROFICIENCY = 'armas-marciais';

function abilityMod(score: number): number {
  return Math.floor((score - 10) / 2);
}

function hasStyleOrFeat(context: WeaponAttackContext, slug: string): boolean {
  return (
    (context.featSlugs ?? []).includes(slug) ||
    (context.fightingStyleSlugs ?? []).includes(slug)
  );
}

function hasProperty(piece: EquippedWeaponPiece, slug: string): boolean {
  return piece.propertySlugs.includes(slug);
}

function isAmmunitionWeapon(piece: EquippedWeaponPiece): boolean {
  return hasProperty(piece, 'ammunition');
}

function isThrownWeapon(piece: EquippedWeaponPiece): boolean {
  return hasProperty(piece, 'thrown');
}

function isTwoHanded(piece: EquippedWeaponPiece): boolean {
  return hasProperty(piece, 'two-handed');
}

function isProficient(
  piece: EquippedWeaponPiece,
  context: WeaponAttackContext,
): boolean {
  const proficiencySlugs = [...context.weaponProficiencySlugs];
  if (hasStyleOrFeat(context, 'martial-weapon-training')) {
    proficiencySlugs.push(MARTIAL_PROFICIENCY);
  }

  if (piece.category === 'simple') {
    return proficiencySlugs.includes(SIMPLE_PROFICIENCY);
  }
  if (piece.category === 'martial') {
    return proficiencySlugs.includes(MARTIAL_PROFICIENCY);
  }
  return false;
}

function pickAbility(
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

function formatSigned(value: number): string {
  return value >= 0 ? `+${value}` : `${value}`;
}

function qualifiesForDueling(
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
  equippedWeapons: EquippedWeaponPiece[],
): boolean {
  if (mode !== 'melee') return false;
  if (isTwoHanded(piece)) return false;
  if (isAmmunitionWeapon(piece)) return false;
  // Uma arma corpo a corpo; escudo não conta como arma.
  return equippedWeapons.length === 1;
}

function buildModes(piece: EquippedWeaponPiece): Array<'melee' | 'ranged'> {
  if (isAmmunitionWeapon(piece)) return ['ranged'];
  if (isThrownWeapon(piece)) return ['melee', 'ranged'];
  return ['melee'];
}

function computeOneAttack(
  scores: AbilityScores,
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
  context: WeaponAttackContext,
  equippedWeapons: EquippedWeaponPiece[],
): WeaponAttack {
  const proficient = isProficient(piece, context);
  const ability = pickAbility(scores, piece, mode);
  const attackParts: string[] = [ability.slug === 'forca' ? 'FOR' : 'DES'];
  let attackBonus = ability.mod;

  if (proficient) {
    attackBonus += context.proficiencyBonus;
    attackParts.push('PB');
  }

  if (mode === 'ranged' && hasStyleOrFeat(context, 'archery')) {
    attackBonus += 2;
    attackParts.push('Arquearia');
  }

  let damageBonus = ability.mod;
  const damageParts: string[] = [ability.slug === 'forca' ? 'FOR' : 'DES'];

  if (
    hasStyleOrFeat(context, 'dueling') &&
    qualifiesForDueling(piece, mode, equippedWeapons)
  ) {
    damageBonus += 2;
    damageParts.push('Duelismo');
  }

  if (
    mode === 'ranged' &&
    isThrownWeapon(piece) &&
    hasStyleOrFeat(context, 'thrown-weapon-fighting')
  ) {
    damageBonus += 2;
    damageParts.push('Arremesso');
  }

  // PHB 2024: Maestria em Armas Pesadas — +PB de dano com propriedade Pesada.
  if (hasProperty(piece, 'heavy') && hasStyleOrFeat(context, 'great-weapon-master')) {
    damageBonus += context.proficiencyBonus;
    damageParts.push('Mestre em Armas Grandes');
  }

  const damageDice = piece.damage ?? '1';
  const modeLabel = mode === 'ranged' ? 'à distância' : 'corpo a corpo';

  return {
    itemSlug: piece.itemSlug,
    itemName: piece.itemName,
    mode,
    attackBonus,
    abilitySlug: ability.slug,
    proficient,
    damageDice,
    damageBonus,
    damageType: piece.damageType,
    attackNote: `${modeLabel}: ${attackParts.join(' + ')}`,
    damageNote: `${damageDice} ${formatSigned(damageBonus)} (${damageParts.join(' + ')})`,
  };
}

/** Calcula ataques passivos das armas equipadas (main_hand / off_hand). */
export function computeWeaponAttacks(
  scores: AbilityScores,
  equipped: EquippedWeaponPiece[],
  context: WeaponAttackContext,
): WeaponAttack[] {
  const weapons = equipped.filter(
    (piece) => piece.equipmentSlot === 'main_hand' || piece.equipmentSlot === 'off_hand',
  );

  const attacks: WeaponAttack[] = [];
  for (const piece of weapons) {
    for (const mode of buildModes(piece)) {
      attacks.push(computeOneAttack(scores, piece, mode, context, weapons));
    }
  }
  return attacks;
}
