/** Itens Enspelled DMG — magia vinculada (arma / armadura / cajado). */

export const ENSPELLED_MAX_SPELL_LEVEL = 8;

export const ENSPELLED_WEAPON_COVERAGE_SLUG = 'arma-magificada';
export const ENSPELLED_ARMOR_COVERAGE_SLUG = 'armadura-magificada';
export const ENSPELLED_STAFF_ITEM_SLUG = 'cajado-magificado';

const WEAPON_SCHOOLS = [
  'adivinhacao',
  'evocacao',
  'invocacao',
  'necromancia',
  'transmutacao',
] as const;

const ARMOR_SCHOOLS = ['abjuracao', 'ilusao'] as const;

export type EnspelledProfile = {
  /** coverage = overlay; unique = peça própria com bound_spell_slug */
  kind: 'coverage' | 'unique';
  /** null = qualquer escola */
  schoolSlugs: readonly string[] | null;
  maxLevel: number;
};

export const ENSPELLED_PROFILES: Record<string, EnspelledProfile> = {
  [ENSPELLED_WEAPON_COVERAGE_SLUG]: {
    kind: 'coverage',
    schoolSlugs: WEAPON_SCHOOLS,
    maxLevel: ENSPELLED_MAX_SPELL_LEVEL,
  },
  [ENSPELLED_ARMOR_COVERAGE_SLUG]: {
    kind: 'coverage',
    schoolSlugs: ARMOR_SCHOOLS,
    maxLevel: ENSPELLED_MAX_SPELL_LEVEL,
  },
  [ENSPELLED_STAFF_ITEM_SLUG]: {
    kind: 'unique',
    schoolSlugs: null,
    maxLevel: ENSPELLED_MAX_SPELL_LEVEL,
  },
};

export function getEnspelledProfile(slug: string): EnspelledProfile | null {
  return ENSPELLED_PROFILES[slug] ?? null;
}

export function isEnspelledCoverageSlug(slug: string): boolean {
  return getEnspelledProfile(slug)?.kind === 'coverage';
}

export function isEnspelledUniqueSlug(slug: string): boolean {
  return getEnspelledProfile(slug)?.kind === 'unique';
}

export function isEnspelledEconomyItemSlug(slug: string): boolean {
  return getEnspelledProfile(slug) != null;
}

export function assertEnspelledBoundSpell(input: {
  itemSlug: string;
  spellSlug: string;
  spellLevel: number;
  schoolSlug: string;
}): void {
  const profile = getEnspelledProfile(input.itemSlug);
  if (!profile) {
    throw new Error(`Item '${input.itemSlug}' is not an enspelled profile`);
  }
  if (input.spellLevel < 0 || input.spellLevel > profile.maxLevel) {
    throw new Error(
      `Enspelled spell '${input.spellSlug}' must be level 0–${profile.maxLevel}`,
    );
  }
  if (
    profile.schoolSlugs != null &&
    !profile.schoolSlugs.includes(input.schoolSlug)
  ) {
    throw new Error(
      `Enspelled spell '${input.spellSlug}' school '${input.schoolSlug}' is not allowed for '${input.itemSlug}'`,
    );
  }
}

/** @deprecated use assertEnspelledBoundSpell with itemSlug */
export function isEnspelledAllowedSchool(schoolSlug: string): boolean {
  return (WEAPON_SCHOOLS as readonly string[]).includes(schoolSlug);
}

/** Tabela DMG Enspelled: raridade / CD / bônus de ataque mágico por nível da magia. */
export type EnspelledRarity =
  | 'uncommon'
  | 'rare'
  | 'very-rare'
  | 'legendary';

export type EnspelledSpellStats = {
  rarity: EnspelledRarity;
  rarityLabel: string;
  saveDc: number;
  spellAttackBonus: number;
};

const ENSPELLED_BY_LEVEL: Record<number, EnspelledSpellStats> = {
  0: {
    rarity: 'uncommon',
    rarityLabel: 'Incomum',
    saveDc: 13,
    spellAttackBonus: 5,
  },
  1: {
    rarity: 'uncommon',
    rarityLabel: 'Incomum',
    saveDc: 13,
    spellAttackBonus: 5,
  },
  2: {
    rarity: 'rare',
    rarityLabel: 'Raro',
    saveDc: 13,
    spellAttackBonus: 5,
  },
  3: {
    rarity: 'rare',
    rarityLabel: 'Raro',
    saveDc: 15,
    spellAttackBonus: 7,
  },
  4: {
    rarity: 'very-rare',
    rarityLabel: 'Muito Raro',
    saveDc: 15,
    spellAttackBonus: 7,
  },
  5: {
    rarity: 'very-rare',
    rarityLabel: 'Muito Raro',
    saveDc: 17,
    spellAttackBonus: 9,
  },
  6: {
    rarity: 'legendary',
    rarityLabel: 'Lendário',
    saveDc: 17,
    spellAttackBonus: 9,
  },
  7: {
    rarity: 'legendary',
    rarityLabel: 'Lendário',
    saveDc: 18,
    spellAttackBonus: 10,
  },
  8: {
    rarity: 'legendary',
    rarityLabel: 'Lendário',
    saveDc: 18,
    spellAttackBonus: 10,
  },
};

export function getEnspelledSpellStats(
  spellLevel: number,
): EnspelledSpellStats {
  const stats = ENSPELLED_BY_LEVEL[spellLevel];
  if (!stats) {
    throw new Error(
      `No Enspelled stats for spell level ${spellLevel} (expected 0–${ENSPELLED_MAX_SPELL_LEVEL})`,
    );
  }
  return stats;
}

export function buildEnspelledCastNote(spellLevel: number): string {
  const stats = getEnspelledSpellStats(spellLevel);
  return `Enspelled (${stats.rarityLabel}): CD ${stats.saveDc}, ataque mágico +${stats.spellAttackBonus}`;
}
