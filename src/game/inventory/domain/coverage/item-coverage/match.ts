import { isAmmunitionBase } from './ammunition';
import {
  normalizeCoverageText,
  type CoverageBaseContext,
  type ItemCoverage,
} from './parse';

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

function matchWeapon(coverage: ItemCoverage, base: CoverageBaseContext): boolean {
  const filter = normalizeCoverageText(coverage.appliesFilter);
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

function matchArmor(coverage: ItemCoverage, base: CoverageBaseContext): boolean {
  const filter = normalizeCoverageText(coverage.appliesFilter);
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

export function coverageMatchesBase(
  coverage: ItemCoverage,
  base: CoverageBaseContext,
): boolean {
  const filter = normalizeCoverageText(coverage.appliesFilter);

  if (coverage.appliesTo === 'weapon') {
    return matchWeapon(coverage, base);
  }

  if (coverage.appliesTo === 'armor') {
    return matchArmor(coverage, base);
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
