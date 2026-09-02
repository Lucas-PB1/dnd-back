/** Parse e tipos de cobertura DMG (`properties.kind = coverage`). */

export const COVERAGE_APPLIES_TO = [
  'weapon',
  'armor',
  'shield',
  'ammunition',
  'wand',
  'unarmed',
] as const;

export type CoverageAppliesTo = (typeof COVERAGE_APPLIES_TO)[number];

const APPLIES_TO_SET = new Set<string>(COVERAGE_APPLIES_TO);

export type ItemCoverage = {
  appliesTo: CoverageAppliesTo;
  appliesFilter: string;
  requiresTierBonus: boolean;
};

export type CoverageBaseContext = {
  itemSlug: string;
  itemName: string;
  itemType: string;
  /** phb_weapon.category: simple | martial | … */
  weaponCategory?: string | null;
  /** v_phb_armor.category_slug: light | medium | heavy | shield */
  armorCategorySlug?: string | null;
  /** properties.weaponSubtype / armorSubtype / category */
  subtypeLabel?: string | null;
};

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === 'object' && value !== null && !Array.isArray(value);
}

export function normalizeCoverageText(value: string): string {
  return value
    .normalize('NFD')
    .replace(/\p{M}/gu, '')
    .toLowerCase()
    .replace(/\s+/g, ' ')
    .trim();
}

/** Lê `kind/appliesTo/appliesFilter/requiresTierBonus` do catálogo. */
export function parseItemCoverage(
  properties: Record<string, unknown> | null | undefined,
): ItemCoverage | null {
  if (!isRecord(properties)) return null;
  if (properties.kind !== 'coverage') return null;
  const appliesTo =
    typeof properties.appliesTo === 'string' ? properties.appliesTo : '';
  if (!APPLIES_TO_SET.has(appliesTo)) return null;
  const appliesFilter =
    typeof properties.appliesFilter === 'string'
      ? properties.appliesFilter.trim()
      : '';
  if (!appliesFilter) return null;
  return {
    appliesTo: appliesTo as CoverageAppliesTo,
    appliesFilter,
    requiresTierBonus: properties.requiresTierBonus === true,
  };
}

export function coverageRequiresTierBonus(
  properties: Record<string, unknown> | null | undefined,
): boolean {
  return parseItemCoverage(properties)?.requiresTierBonus === true;
}

export function coverageBonusToEffects(
  appliesTo: CoverageAppliesTo,
  bonus: 1 | 2 | 3,
): { attackBonus?: number; damageBonus?: number; acBonus?: number } {
  if (appliesTo === 'weapon' || appliesTo === 'ammunition') {
    return { attackBonus: bonus, damageBonus: bonus };
  }
  if (appliesTo === 'armor' || appliesTo === 'shield') {
    return { acBonus: bonus };
  }
  if (appliesTo === 'wand' || appliesTo === 'unarmed') {
    return { attackBonus: bonus };
  }
  return {};
}
