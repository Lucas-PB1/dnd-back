import { Injectable } from '@nestjs/common';
import { VPhbFeat } from '@entities/views/v-phb-feat.entity';
import { FeatResponseDto } from './dto/feat-response.dto';
import { FeatSummaryResponseDto } from './dto/feat-summary-response.dto';

@Injectable()
export class FeatsMapper {
  toSummaryDto(row: VPhbFeat): FeatSummaryResponseDto {
    return {
      slug: row.featSlug,
      name: row.featName,
      categorySlug: row.categorySlug,
    };
  }

  toDto(row: VPhbFeat): FeatResponseDto {
    return {
      slug: row.featSlug,
      name: row.featName,
      categorySlug: row.categorySlug,
      categoryName: row.categoryName,
      categoryTypeLabel: row.categoryTypeLabel,
      repeatable: row.repeatable,
      prerequisite: row.prerequisite,
      minimumLevel: row.minimumLevel,
      abilityPrerequisites: row.abilityPrerequisites ?? [],
      requiresSpellcasting: row.requiresSpellcasting,
      requiredArmorTrainingSlug: row.requiredArmorTrainingSlug,
      requiresFightingStyle: row.requiresFightingStyle,
      requiresWeaponMastery: row.requiresWeaponMastery ?? false,
      requiredFeatSlugs: row.requiredFeatSlugs ?? [],
      requiredSkillSlugs: row.requiredSkillSlugs ?? [],
      requiredSpeciesSlugs: row.requiredSpeciesSlugs ?? [],
      requiredWeaponProficiencySlugs: row.requiredWeaponProficiencySlugs ?? [],
      requiredFeatOptions: row.requiredFeatOptions ?? [],
      sourceChapter: row.sourceChapter,
      sourceChapterTitle: row.sourceChapterTitle,
      editionSlug: row.editionSlug,
      benefits: row.benefits ?? [],
    };
  }
}
