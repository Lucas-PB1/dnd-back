/** Cobertura DMG (`properties.kind = coverage`) — parse e matching. */

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

function splitFilterTokens(filter: string): string[] {
  return filter
    .split(/\s*(?:,|;|\bou\b|\|)\s*/i)
    .map((part) => part.trim())
    .filter(Boolean);
}

function baseLabels(base: CoverageBaseContext): string[] {
  const labels = [base.itemName, base.subtypeLabel ?? '']
    .filter(Boolean)
    .map(normalizeCoverageText);
  return [...new Set(labels)];
}

function matchesAllowlist(base: CoverageBaseContext, filter: string): boolean {
  const labels = baseLabels(base);
  const tokens = splitFilterTokens(filter).map(normalizeCoverageText);
  return tokens.some((token) =>
    labels.some(
      (label) => label === token || label.includes(token) || token.includes(label),
    ),
  );
}

function isWeaponBase(base: CoverageBaseContext): boolean {
  return base.itemType === 'weapon' || Boolean(base.weaponCategory);
}

function isRangedWeaponHint(base: CoverageBaseContext): boolean {
  const hay = normalizeCoverageText(
    `${base.itemSlug} ${base.itemName} ${base.subtypeLabel ?? ''}`,
  );
  return /arco|best|crossbow|bow|firearm|pistola|rifle|atirar|ranged|distancia|virote|flecha/.test(
    hay,
  );
}

function isArmorBody(base: CoverageBaseContext): boolean {
  const cat = base.armorCategorySlug;
  return cat === 'light' || cat === 'medium' || cat === 'heavy';
}

function isShield(base: CoverageBaseContext): boolean {
  return base.armorCategorySlug === 'shield';
}

/** True se a peça base passa no filtro da cobertura. */
export function coverageMatchesBase(
  coverage: ItemCoverage,
  base: CoverageBaseContext,
): boolean {
  const filter = normalizeCoverageText(coverage.appliesFilter);

  if (coverage.appliesTo === 'weapon') {
    if (!isWeaponBase(base)) return false;
    if (filter.startsWith('qualquer')) {
      const cat = (base.weaponCategory ?? '').toLowerCase();
      if (filter.includes('simples') || filter.includes('marcial')) {
        return cat === 'simple' || cat === 'martial';
      }
      if (
        filter.includes('corpo a corpo') ||
        filter.includes('corpo-a-corpo') ||
        filter.includes('melee')
      ) {
        return !isRangedWeaponHint(base);
      }
      if (
        filter.includes('distancia') ||
        filter.includes('à distância') ||
        filter.includes('a distancia') ||
        filter.includes('ranged')
      ) {
        return isRangedWeaponHint(base);
      }
      return true;
    }
    return matchesAllowlist(base, coverage.appliesFilter);
  }

  if (coverage.appliesTo === 'armor') {
    if (!isArmorBody(base)) return false;
    if (filter.includes('exceto') && filter.includes('gibao')) {
      const name = normalizeCoverageText(base.itemName);
      const subtype = normalizeCoverageText(base.subtypeLabel ?? '');
      if (name.includes('gibao') || subtype.includes('gibao') || name.includes('hide')) {
        return false;
      }
    }
    if (filter.startsWith('qualquer')) {
      const cat = base.armorCategorySlug;
      const wantsLight = filter.includes('leve');
      const wantsMedium = filter.includes('media');
      const wantsHeavy = filter.includes('pesada');
      if (!wantsLight && !wantsMedium && !wantsHeavy) return true;
      if (cat === 'light') return wantsLight;
      if (cat === 'medium') return wantsMedium;
      if (cat === 'heavy') return wantsHeavy;
      return false;
    }
    return matchesAllowlist(base, coverage.appliesFilter);
  }

  if (coverage.appliesTo === 'shield') {
    if (base.armorCategorySlug !== 'shield') return false;
    return true;
  }

  if (coverage.appliesTo === 'ammunition') {
    if (!isAmmunitionBase(base)) return false;
    if (filter.startsWith('qualquer')) return true;
    return matchesAllowlist(base, coverage.appliesFilter);
  }
  if (coverage.appliesTo === 'wand') {
    return normalizeCoverageText(base.itemName).includes('varinha');
  }
  if (coverage.appliesTo === 'unarmed') {
    return base.itemSlug === 'unarmed' || base.itemSlug.includes('unarmed');
  }

  return false;
}

const AMMUNITION_NAME_HINTS = [
  'municao',
  'flecha',
  'flechas',
  'virote',
  'virotes',
  'bala',
  'balas',
  'agulha',
  'agulhas',
  'arrow',
  'arrows',
  'bolt',
  'bolts',
  'bullet',
  'bullets',
  'needle',
  'needles',
  'pedra de funda',
  'pedras de funda',
  'sling bullet',
  'sling bullets',
] as const;

const AMMUNITION_CONTAINER_HINTS = [
  'aljava',
  'estojo',
  'quiver',
  'case',
] as const;

/** Peça base é munição (não estojo/aljava). */
export function isAmmunitionBase(base: CoverageBaseContext): boolean {
  const slug = normalizeCoverageText(base.itemSlug);
  const name = normalizeCoverageText(base.itemName);
  const subtype = normalizeCoverageText(base.subtypeLabel ?? '');
  const type = normalizeCoverageText(base.itemType);

  if (type.includes('ammunition')) return true;
  if (slug === 'municao' || name === 'municao') return true;

  if (
    AMMUNITION_CONTAINER_HINTS.some(
      (hint) => slug.includes(hint) || name.includes(hint),
    )
  ) {
    return false;
  }

  const haystack = `${slug} ${name} ${subtype}`;
  return AMMUNITION_NAME_HINTS.some((hint) => haystack.includes(hint));
}
