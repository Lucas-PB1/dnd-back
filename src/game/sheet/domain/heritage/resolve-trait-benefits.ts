export interface HeritageTraitBenefitSource {
  traitSlug: string;
  benefitBase: string | null;
  benefitImproved: string | null;
}

export interface ResolvedHeritageTraitBenefit {
  traitSlug: string;
  takeCount: number;
  activeBenefits: string[];
}

export function resolveTraitBenefits(
  trait: HeritageTraitBenefitSource,
  takeCount: number,
): ResolvedHeritageTraitBenefit {
  const activeBenefits: string[] = [];
  const base = trait.benefitBase?.trim();
  const improved = trait.benefitImproved?.trim();

  if (takeCount >= 1 && base) {
    activeBenefits.push(base);
  }
  if (takeCount >= 2 && improved) {
    activeBenefits.push(improved);
  }

  return {
    traitSlug: trait.traitSlug,
    takeCount,
    activeBenefits,
  };
}

export function resolveAggregatedTraitBenefits(
  traitsBySlug: ReadonlyMap<string, HeritageTraitBenefitSource>,
  aggregated: ReadonlyArray<{ traitSlug: string; takeCount: number }>,
): ResolvedHeritageTraitBenefit[] {
  return aggregated.flatMap((entry) => {
    const trait = traitsBySlug.get(entry.traitSlug);
    if (!trait) return [];
    return [resolveTraitBenefits(trait, entry.takeCount)];
  });
}
