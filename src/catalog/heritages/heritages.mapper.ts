import { Injectable } from '@nestjs/common';
import { PhbHeritage } from '@entities/phb-heritage.entity';
import { PhbHeritageTrait } from '@entities/phb-heritage-trait.entity';
import { VPhbHeritageTraitChoices } from '@entities/views/v-phb-heritage-trait-choices.entity';
import { DEFAULT_PHB_EDITION_SLUG } from '@common/dto/pagination.dto';
import { HeritageResponseDto } from './dto/heritage-response.dto';
import { HeritageSummaryResponseDto } from './dto/heritage-summary-response.dto';
import { HeritageTraitResponseDto } from './dto/heritage-trait-response.dto';
import { HeritageTraitChoiceResponseDto } from './dto/heritage-trait-choice-response.dto';

function editionSlugFromSourceMeta(
  sourceMeta: Record<string, unknown> | null,
): string {
  const raw = sourceMeta?.editionSlug;
  return typeof raw === 'string' && raw.trim()
    ? raw.trim()
    : DEFAULT_PHB_EDITION_SLUG;
}

@Injectable()
export class HeritagesMapper {
  toSummaryDto(row: PhbHeritage): HeritageSummaryResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      editionSlug: editionSlugFromSourceMeta(row.sourceMeta),
    };
  }

  toDto(row: PhbHeritage): HeritageResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      category: row.category,
      tagline: row.tagline,
      summary: row.summary,
      creatureType: row.creatureType,
      sizeRule: row.sizeRule,
      speedRule: row.speedRule,
      description: row.description,
      allowsSpeedTrade: row.allowsSpeedTrade,
      allowsSizeChoice: row.allowsSizeChoice,
      editionSlug: editionSlugFromSourceMeta(row.sourceMeta),
      imageUrl: row.imageUrl,
    };
  }

  toTraitDto(row: PhbHeritageTrait): HeritageTraitResponseDto {
    return {
      slug: row.slug,
      name: row.name.replace(/\.$/, ''),
      category: row.category,
      description: row.description,
      benefitBase: row.benefitBase,
      benefitImproved: row.benefitImproved,
    };
  }

  toTraitChoiceDto(row: VPhbHeritageTraitChoices): HeritageTraitChoiceResponseDto {
    return {
      choiceKind: row.choiceKind,
      traitSlug: row.traitSlug,
      traitName: row.traitName,
      label: row.label,
      benefitBase: row.benefitBase,
      benefitImproved: row.benefitImproved,
      isTraditional: row.isTraditional,
      sortOrder: row.sortOrder,
    };
  }
}
