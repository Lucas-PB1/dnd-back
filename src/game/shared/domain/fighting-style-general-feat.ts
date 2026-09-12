export const FIGHTING_STYLE_GENERAL_FEAT_MIN_LEVEL: Readonly<
  Record<string, number>
> = {
  'advanced-weapon-proficiency': 8,
};

export function isGeneralFeatFightingStylePick(
  featSlug: string,
  level: number,
): boolean {
  const min = FIGHTING_STYLE_GENERAL_FEAT_MIN_LEVEL[featSlug];
  return min != null && level >= min;
}
