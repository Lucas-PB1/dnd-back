export type SubclassOptionPick = {
  optionKey: string;
  valueId: string;
};

export const LORE_MAGICAL_DISCOVERY_KEYS = new Set([
  'magicalDiscovery1',
  'magicalDiscovery2',
]);

export const LORE_BONUS_SKILL_KEYS = new Set([
  'loreBonusSkill1',
  'loreBonusSkill2',
  'loreBonusSkill3',
]);

export const WIZARD_VERSATILITY_OPTION_KEYS = new Set([
  'abjurationVersatility1',
  'abjurationVersatility2',
  'divinationVersatility1',
  'divinationVersatility2',
  'evocationVersatility1',
  'evocationVersatility2',
  'illusionVersatility1',
  'illusionVersatility2',
]);

export const SUBCLASS_SKILL_OPTION_KEYS = new Set([
  ...LORE_BONUS_SKILL_KEYS,
  'warScholarSkill',
  'glamourSkill',
]);

export const LAND_TERRAIN_OPTION_KEY = 'circleTerrain';

export function resolveLandTerrainSlug(
  subclassSlug: string | null | undefined,
  subclassOptions: readonly SubclassOptionPick[] | undefined,
): string | null {
  if (subclassSlug !== 'land' || !subclassOptions?.length) return null;
  return (
    subclassOptions.find((option) => option.optionKey === LAND_TERRAIN_OPTION_KEY)
      ?.valueId ?? null
  );
}

/** Magias always_prepared vindas de picks de subclasse (Descobertas Mágicas). */
export function collectSubclassOptionGrantedSpellSlugs(
  level: number,
  subclassOptions: readonly SubclassOptionPick[] | undefined,
  unlockLevelByKey: ReadonlyMap<string, number>,
): Set<string> {
  const slugs = new Set<string>();
  if (!subclassOptions?.length) return slugs;

  for (const option of subclassOptions) {
    if (!LORE_MAGICAL_DISCOVERY_KEYS.has(option.optionKey)) continue;
    const unlock = unlockLevelByKey.get(option.optionKey) ?? 6;
    if (level >= unlock && option.valueId) {
      slugs.add(option.valueId);
    }
  }
  return slugs;
}

/** Magias gratuitas no grimório (Versado em {Escola}). */
export function collectSubclassSpellbookBonusSlugs(
  subclassOptions: readonly SubclassOptionPick[] | undefined,
): Set<string> {
  const slugs = new Set<string>();
  if (!subclassOptions?.length) return slugs;

  for (const option of subclassOptions) {
    if (!WIZARD_VERSATILITY_OPTION_KEYS.has(option.optionKey)) continue;
    if (option.valueId) slugs.add(option.valueId);
  }
  return slugs;
}

export function collectSubclassBonusSkillSlugs(
  subclassOptions: readonly SubclassOptionPick[] | undefined,
): string[] {
  if (!subclassOptions?.length) return [];
  return subclassOptions
    .filter(
      (option) =>
        SUBCLASS_SKILL_OPTION_KEYS.has(option.optionKey) && option.valueId,
    )
    .map((option) => option.valueId);
}
