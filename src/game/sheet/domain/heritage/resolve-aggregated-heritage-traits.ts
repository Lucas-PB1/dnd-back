import type { SpeciesChoiceDto } from '@game/sheet/dto/character-sheet.dto';
import {
  aggregateTraitTakes,
  collectHeritageTraitPicks,
  HERITAGE_SIZE_KIND,
  HERITAGE_SPEED_TRADE_KIND,
} from './aggregate-trait-takes';
import { In, Repository } from 'typeorm';
import { PhbHeritageTrait } from '@entities/phb-heritage-trait.entity';

export interface AggregatedHeritageTraitDto {
  traitSlug: string;
  traitName: string;
  takeCount: number;
  slotIndexes: number[];
  activeBenefits: string[];
}

export function resolveBenefitsForTakeCount(input: {
  benefitBase: string | null;
  benefitImproved: string | null;
  takeCount: number;
}): string[] {
  const benefits: string[] = [];
  if (input.benefitBase?.trim() && input.takeCount >= 1) {
    benefits.push(input.benefitBase.trim());
  }
  if (input.benefitImproved?.trim() && input.takeCount >= 2) {
    benefits.push(input.benefitImproved.trim());
  }
  return benefits;
}

export async function resolveAggregatedHeritageTraits(
  heritageChoices: readonly SpeciesChoiceDto[],
  traitRepo: Repository<PhbHeritageTrait>,
): Promise<AggregatedHeritageTraitDto[]> {
  const aggregated = aggregateTraitTakes(collectHeritageTraitPicks(heritageChoices));
  if (aggregated.length === 0) return [];

  const slugs = aggregated.map((entry) => entry.traitSlug);
  const traits = await traitRepo.find({
    where: { slug: In(slugs) },
    select: ['slug', 'name', 'benefitBase', 'benefitImproved'],
  });
  const bySlug = new Map(traits.map((trait) => [trait.slug, trait]));

  return aggregated.map((entry) => {
    const trait = bySlug.get(entry.traitSlug);
    return {
      traitSlug: entry.traitSlug,
      traitName: trait?.name ?? entry.traitSlug,
      takeCount: entry.takeCount,
      slotIndexes: entry.slotIndexes,
      activeBenefits: resolveBenefitsForTakeCount({
        benefitBase: trait?.benefitBase ?? null,
        benefitImproved: trait?.benefitImproved ?? null,
        takeCount: entry.takeCount,
      }),
    };
  });
}

export {
  HERITAGE_SIZE_KIND,
  HERITAGE_SPEED_TRADE_KIND,
};
