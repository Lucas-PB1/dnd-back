export type SubclassOptionPick = {
  optionKey: string;
  valueId: string;
};

export type CompanionProfile = {
  profileId: string;
  subclassSlug: string;
  minLevel: number;
};

export type CompanionTemplateMapRow = {
  optionMatches: Record<string, string>;
  templateSlug: string;
  variantLabel: string;
};

export type ResolvedCompanionConfig = {
  profile: CompanionProfile;
  templateSlug: string;
  variantLabel: string;
};

export function resolveCompanionConfig(
  profile: CompanionProfile | null | undefined,
  maps: readonly CompanionTemplateMapRow[],
  subclassOptions: readonly SubclassOptionPick[] | undefined,
): ResolvedCompanionConfig | null {
  if (!profile) return null;
  const options = subclassOptions ?? [];
  const match = maps.find((row) => optionMatchesAll(options, row.optionMatches));
  if (!match) return null;
  return {
    profile,
    templateSlug: match.templateSlug,
    variantLabel: match.variantLabel || match.templateSlug,
  };
}

function optionMatchesAll(
  options: readonly SubclassOptionPick[],
  matches: Record<string, string>,
): boolean {
  return Object.entries(matches).every(
    ([optionKey, valueId]) => readOption(options, optionKey) === valueId,
  );
}

function readOption(
  options: readonly SubclassOptionPick[],
  optionKey: string,
): string | null {
  return options.find((option) => option.optionKey === optionKey)?.valueId ?? null;
}
