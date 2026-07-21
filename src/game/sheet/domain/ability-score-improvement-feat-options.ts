import type { PhbFeatOptionDef } from '../../../entities/phb-feat-option.entity';
import type { FeatOptionDto } from '../dto/character-sheet.dto';

export const ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG = 'ability-score-improvement';

export const ASI_DISTRIBUTION_PLUS2 = 'plus2';
export const ASI_DISTRIBUTION_PLUS1PLUS1 = 'plus1plus1';

export function asiDistributionMode(
  featOptions: FeatOptionDto[],
): string | undefined {
  return featOptions.find((o) => o.optionKey === 'distributionMode')?.valueId;
}

export function requiredAbilityScoreImprovementDefs(
  featSlug: string,
  defs: PhbFeatOptionDef[],
  featOptions: FeatOptionDto[],
): PhbFeatOptionDef[] {
  if (featSlug !== ABILITY_SCORE_IMPROVEMENT_FEAT_SLUG) {
    return defs;
  }
  const mode = asiDistributionMode(featOptions);
  return defs.filter((def) => {
    if (def.optionKey === 'secondaryAbility') {
      return mode === ASI_DISTRIBUTION_PLUS1PLUS1;
    }
    return true;
  });
}

export function optionsForAsiFeatInstance(
  featSlug: string,
  instanceIndex: number,
  options: FeatOptionDto[],
): FeatOptionDto[] {
  return options.filter(
    (o) =>
      o.featSlug === featSlug &&
      (o.instanceIndex ?? 0) === instanceIndex,
  );
}
