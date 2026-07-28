export const FIGHTING_STYLE_FEAT_CATEGORY = 'fighting-style';

export function isFightingStyleSubclassOptionKey(optionKey: string): boolean {
  return (
    optionKey === 'additionalFightingStyle' ||
    optionKey === 'fighting_style' ||
    optionKey.endsWith('FightingStyle')
  );
}

export function collectFightingStyleSlugsFromSubclassOptions(
  subclassOptions: { optionKey: string; valueId: string }[] | undefined,
): string[] {
  if (!subclassOptions?.length) return [];
  return subclassOptions
    .filter((option) => isFightingStyleSubclassOptionKey(option.optionKey))
    .map((option) => option.valueId);
}
