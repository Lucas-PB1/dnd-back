import type { AbilityScores } from '../../shared/infrastructure/player-character.entity';
import type { SizeCategory } from './creature-size';

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
  /** Ex.: `armas-simples`, `armas-marciais`, `adagas`. */
  weaponProficiencySlugs: readonly string[];
  featSlugs?: readonly string[];
  fightingStyleSlugs?: readonly string[];
  sizeCategory?: SizeCategory;
  /** true se há escudo equipado (afeta versatile 2H). */
  hasShield?: boolean;
};

export type WeaponAttackRole = 'main' | 'light_bonus' | 'dual_bonus';

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
  role: WeaponAttackRole;
  attackDisadvantage: boolean;
  omitsAbilityDamage: boolean;
};

const SIMPLE_PROFICIENCY = 'armas-simples';
const MARTIAL_PROFICIENCY = 'armas-marciais';
const MARTIAL_LIGHT_PROFICIENCY = 'armas-marciais-leves';

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

function isLight(piece: EquippedWeaponPiece): boolean {
  return hasProperty(piece, 'light');
}

function isMeleeCapable(piece: EquippedWeaponPiece): boolean {
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
  return equippedWeapons.length === 1;
}

function buildModes(piece: EquippedWeaponPiece): Array<'melee' | 'ranged'> {
  if (isAmmunitionWeapon(piece)) return ['ranged'];
  if (isThrownWeapon(piece)) return ['melee', 'ranged'];
  return ['melee'];
}

function usesVersatileTwoHanded(
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

export type DualWieldAnalysis = {
  bonusRole: WeaponAttackRole | null;
  dualWieldNeedsFeat: boolean;
  dualWieldTwoHandedOffHand: boolean;
};

/** Analisa main/off para TWF / Dual Wielder. */
export function analyzeDualWield(
  weapons: EquippedWeaponPiece[],
  context: WeaponAttackContext,
): DualWieldAnalysis {
  const main = weapons.find((w) => w.equipmentSlot === 'main_hand');
  const off = weapons.find((w) => w.equipmentSlot === 'off_hand');
  if (!main || !off) {
    return {
      bonusRole: null,
      dualWieldNeedsFeat: false,
      dualWieldTwoHandedOffHand: false,
    };
  }

  if (isTwoHanded(off)) {
    return {
      bonusRole: null,
      dualWieldNeedsFeat: false,
      dualWieldTwoHandedOffHand: true,
    };
  }

  const mainLight = isLight(main) && isMeleeCapable(main);
  const offLight = isLight(off) && isMeleeCapable(off);
  const offMeleeOk = isMeleeCapable(off) && !isTwoHanded(off);

  if (mainLight && offLight) {
    return {
      bonusRole: 'light_bonus',
      dualWieldNeedsFeat: false,
      dualWieldTwoHandedOffHand: false,
    };
  }

  if (
    mainLight &&
    offMeleeOk &&
    !offLight &&
    hasStyleOrFeat(context, 'dual-wielder')
  ) {
    return {
      bonusRole: 'dual_bonus',
      dualWieldNeedsFeat: false,
      dualWieldTwoHandedOffHand: false,
    };
  }

  if (offMeleeOk && !offLight) {
    return {
      bonusRole: null,
      dualWieldNeedsFeat: true,
      dualWieldTwoHandedOffHand: false,
    };
  }

  return {
    bonusRole: null,
    dualWieldNeedsFeat: false,
    dualWieldTwoHandedOffHand: false,
  };
}

function computeOneAttack(
  scores: AbilityScores,
  piece: EquippedWeaponPiece,
  mode: 'melee' | 'ranged',
  context: WeaponAttackContext,
  equippedWeapons: EquippedWeaponPiece[],
  role: WeaponAttackRole,
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

  const isBonusAttack = role === 'light_bonus' || role === 'dual_bonus';
  const hasTwf =
    hasStyleOrFeat(context, 'two-weapon-fighting');
  const omitAbilityDamage =
    isBonusAttack && !hasTwf && ability.mod >= 0;

  let damageBonus = omitAbilityDamage ? 0 : ability.mod;
  const damageParts: string[] = omitAbilityDamage
    ? []
    : [ability.slug === 'forca' ? 'FOR' : 'DES'];

  if (omitAbilityDamage && ability.mod < 0) {
    damageBonus = ability.mod;
    damageParts.push(ability.slug === 'forca' ? 'FOR' : 'DES');
  }

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

  if (hasProperty(piece, 'heavy') && hasStyleOrFeat(context, 'great-weapon-master')) {
    damageBonus += context.proficiencyBonus;
    damageParts.push('Mestre em Armas Grandes');
  }

  const versatile2h = usesVersatileTwoHanded(
    piece,
    equippedWeapons,
    Boolean(context.hasShield),
  );
  const damageDice = versatile2h
    ? (piece.versatileDamage ?? piece.damage ?? '1')
    : (piece.damage ?? '1');

  const modeLabel = mode === 'ranged' ? 'à distância' : 'corpo a corpo';
  const noteExtras: string[] = [];
  if (hasProperty(piece, 'versatile')) {
    noteExtras.push(versatile2h ? 'versátil (2 mãos)' : 'versátil (1 mão)');
  }
  if (role === 'light_bonus') noteExtras.push('ataque adicional (Leve)');
  if (role === 'dual_bonus') noteExtras.push('ataque adicional (Ambidestro)');

  const attackDisadvantage =
    context.sizeCategory === 'small' && hasProperty(piece, 'heavy');
  if (attackDisadvantage) {
    noteExtras.push('desvantagem (Pesada / tamanho Pequeno)');
  }

  const attackNoteBase = `${modeLabel}: ${attackParts.join(' + ')}`;
  const attackNote =
    noteExtras.length > 0
      ? `${attackNoteBase} · ${noteExtras.join(' · ')}`
      : attackNoteBase;

  const damageNote =
    damageParts.length > 0
      ? `${damageDice} ${formatSigned(damageBonus)} (${damageParts.join(' + ')})`
      : `${damageDice}${damageBonus !== 0 ? ` ${formatSigned(damageBonus)}` : ''}`;

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
    attackNote,
    damageNote,
    role,
    attackDisadvantage,
    omitsAbilityDamage: omitAbilityDamage,
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

  const dual = analyzeDualWield(weapons, context);

  const attacks: WeaponAttack[] = [];
  for (const piece of weapons) {
    const role: WeaponAttackRole =
      piece.equipmentSlot === 'off_hand' && dual.bonusRole
        ? dual.bonusRole
        : 'main';
    for (const mode of buildModes(piece)) {
      // Ataque adicional TWF/Dual é corpo a corpo; modos ranged da off-hand ficam main.
      const effectiveRole =
        role !== 'main' && mode === 'ranged' ? 'main' : role;
      attacks.push(
        computeOneAttack(
          scores,
          piece,
          mode,
          context,
          weapons,
          effectiveRole,
        ),
      );
    }
  }
  return attacks;
}

export function heavyWeaponSlugsForSmallSize(
  weapons: EquippedWeaponPiece[],
  sizeCategory: SizeCategory | undefined,
): string[] {
  if (sizeCategory !== 'small') return [];
  return weapons
    .filter((w) => hasProperty(w, 'heavy'))
    .map((w) => w.itemSlug);
}
