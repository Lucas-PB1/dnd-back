/**
 * Cotas de truques / magias conhecidas ou preparadas (espelha o front).
 */

export const PREPARED_SPELL_CLASS_SLUGS = new Set([
  'cleric',
  'druid',
  'paladin',
  'wizard',
]);

export type ClassSpellcastingMode = 'prepared' | 'known' | 'wizard';

export type SpellListType = 'known' | 'prepared' | 'always_prepared';

export type SpellQuotaEntry = {
  spellSlug: string;
  listType: SpellListType;
};

export type SpellCatalogLevel = {
  slug: string;
  level: number;
};

export function classSpellcastingMode(classSlug: string): ClassSpellcastingMode {
  if (classSlug === 'wizard') return 'wizard';
  if (PREPARED_SPELL_CLASS_SLUGS.has(classSlug)) return 'prepared';
  return 'known';
}

export function countSpellsByType(
  characterSpells: readonly SpellQuotaEntry[],
  catalog: readonly SpellCatalogLevel[],
): {
  cantrips: number;
  leveledKnown: number;
  leveledPrepared: number;
} {
  const bySlug = new Map(catalog.map((s) => [s.slug, s]));
  let cantrips = 0;
  let leveledKnown = 0;
  let leveledPrepared = 0;

  for (const entry of characterSpells) {
    if (entry.listType === 'always_prepared') continue;
    const meta = bySlug.get(entry.spellSlug);
    if (!meta) continue;
    if (meta.level === 0) {
      cantrips += 1;
      continue;
    }
    if (entry.listType === 'prepared') {
      leveledPrepared += 1;
      leveledKnown += 1;
    } else if (entry.listType === 'known') {
      leveledKnown += 1;
    }
  }

  return { cantrips, leveledKnown, leveledPrepared };
}

export function wizardSpellbookLimitAtLevel(
  level: number,
  preparedQuota: number | null,
): number {
  if (preparedQuota == null) return 6;
  if (level === 1) return Math.max(preparedQuota + 2, 6);
  return preparedQuota + level;
}

export type SpellQuotaViolation = {
  kind: 'cantrips' | 'known' | 'prepared' | 'spellbook';
  count: number;
  max: number;
};

/** Retorna a primeira violação encontrada, ou null se ok. */
export function findSpellQuotaViolation(input: {
  classSlug: string;
  level: number;
  characterSpells: readonly SpellQuotaEntry[];
  catalog: readonly SpellCatalogLevel[];
  cantripsMax: number | null;
  preparedOrKnownMax: number | null;
  /** Override do mode derivado de classSlug (ex. subclass caster prepared). */
  mode?: ClassSpellcastingMode;
}): SpellQuotaViolation | null {
  const mode = input.mode ?? classSpellcastingMode(input.classSlug);
  const counts = countSpellsByType(input.characterSpells, input.catalog);

  if (
    input.cantripsMax != null &&
    counts.cantrips > input.cantripsMax
  ) {
    return {
      kind: 'cantrips',
      count: counts.cantrips,
      max: input.cantripsMax,
    };
  }

  if (mode === 'known') {
    if (
      input.preparedOrKnownMax != null &&
      counts.leveledKnown > input.preparedOrKnownMax
    ) {
      return {
        kind: 'known',
        count: counts.leveledKnown,
        max: input.preparedOrKnownMax,
      };
    }
    return null;
  }

  if (mode === 'prepared') {
    if (
      input.preparedOrKnownMax != null &&
      counts.leveledPrepared > input.preparedOrKnownMax
    ) {
      return {
        kind: 'prepared',
        count: counts.leveledPrepared,
        max: input.preparedOrKnownMax,
      };
    }
    return null;
  }

  const bookMax = wizardSpellbookLimitAtLevel(
    input.level,
    input.preparedOrKnownMax,
  );
  if (counts.leveledKnown > bookMax) {
    return {
      kind: 'spellbook',
      count: counts.leveledKnown,
      max: bookMax,
    };
  }
  if (
    input.preparedOrKnownMax != null &&
    counts.leveledPrepared > input.preparedOrKnownMax
  ) {
    return {
      kind: 'prepared',
      count: counts.leveledPrepared,
      max: input.preparedOrKnownMax,
    };
  }
  return null;
}

export function spellQuotaViolationMessage(
  classSlug: string,
  violation: SpellQuotaViolation,
): string {
  if (violation.kind === 'cantrips') {
    return `Cantrip quota exceeded for ${classSlug}: ${violation.count}/${violation.max}`;
  }
  if (violation.kind === 'known') {
    return `Known spell quota exceeded for ${classSlug}: ${violation.count}/${violation.max}`;
  }
  if (violation.kind === 'spellbook') {
    return `Wizard spellbook quota exceeded: ${violation.count}/${violation.max}`;
  }
  return `Prepared spell quota exceeded for ${classSlug}: ${violation.count}/${violation.max}`;
}
