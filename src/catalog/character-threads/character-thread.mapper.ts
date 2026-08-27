import { Injectable } from '@nestjs/common';
import { PhbCharacterThread } from '@entities/phb-character-thread.entity';
import { VPhbCharacterThreadBundle } from '@entities/views/v-phb-character-thread-bundle.entity';
import {
  CharacterThreadResponseDto,
  CharacterThreadSummaryResponseDto,
} from './dto/character-thread-response.dto';

@Injectable()
export class CharacterThreadMapper {
  toSummaryDto(row: PhbCharacterThread): CharacterThreadSummaryResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      editionSlug: row.editionSlug,
      summary: row.summary,
      sortOrder: row.sortOrder,
    };
  }

  toDto(row: VPhbCharacterThreadBundle): CharacterThreadResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      editionSlug: row.editionSlug,
      summary: row.summary,
      sortOrder: row.sortOrder,
      specialRulesText: row.specialRulesText,
      goals: row.goals ?? [],
      milestones: (row.milestones ?? []).map((milestone) => ({
        id: Number(milestone.id),
        rank: milestone.rank,
        sortOrder: milestone.sortOrder,
        benefits: (milestone.benefits ?? []).map((benefit) => ({
          benefitKey: benefit.benefitKey,
          name: benefit.name,
          description: benefit.description,
          choiceGroup: benefit.choiceGroup,
          sortOrder: benefit.sortOrder,
        })),
      })),
    };
  }
}
