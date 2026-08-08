import { Injectable } from '@nestjs/common';
import { PhbSpecies } from '../../entities/phb-species.entity';
import { PhbSpeciesTrait } from '../../entities/phb-species-trait.entity';
import { VPhbSpeciesTraitChoices } from '../../entities/views/v-phb-species-trait-choices.entity';
import { DEFAULT_PHB_EDITION_SLUG } from '../../common/dto/pagination.dto';
import { SpeciesResponseDto } from './dto/species-response.dto';
import { SpeciesSummaryResponseDto } from './dto/species-summary-response.dto';
import { SpeciesTraitResponseDto } from './dto/species-trait-response.dto';
import { SpeciesTraitChoiceResponseDto } from './dto/species-trait-choice-response.dto';

function editionSlugFromSourceMeta(
  sourceMeta: Record<string, unknown> | null,
): string {
  const raw = sourceMeta?.editionSlug;
  return typeof raw === 'string' && raw.trim()
    ? raw.trim()
    : DEFAULT_PHB_EDITION_SLUG;
}

@Injectable()
export class SpeciesMapper {
  toSummaryDto(row: PhbSpecies): SpeciesSummaryResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      editionSlug: editionSlugFromSourceMeta(row.sourceMeta),
    };
  }

  toDto(row: PhbSpecies): SpeciesResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      tagline: row.tagline,
      summary: row.summary,
      creatureType: row.creatureType,
      size: row.size,
      speed: row.speed,
      description: row.description,
      editionSlug: editionSlugFromSourceMeta(row.sourceMeta),
    };
  }

  toTraitDto(row: PhbSpeciesTrait): SpeciesTraitResponseDto {
    return {
      name: row.name,
      description: row.description,
      choiceKind: row.choiceKind,
    };
  }

  toTraitChoiceDto(row: VPhbSpeciesTraitChoices): SpeciesTraitChoiceResponseDto {
    return {
      traitName: row.traitName,
      choiceKind: row.choiceKind,
      choiceSlug: row.choiceSlug,
      choiceName: row.choiceName,
      level1Benefit: row.level1Benefit,
      spellLevel3Slug: row.spellLevel3Slug,
      spellLevel5Slug: row.spellLevel5Slug,
      damageType: row.damageType,
    };
  }
}
