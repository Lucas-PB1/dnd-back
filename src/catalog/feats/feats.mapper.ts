import { Injectable } from '@nestjs/common';
import { VPhbFeat } from '../../entities/views/v-phb-feat.entity';
import { FeatResponseDto } from './dto/feat-response.dto';

@Injectable()
export class FeatsMapper {
  toDto(row: VPhbFeat): FeatResponseDto {
    return {
      slug: row.featSlug,
      name: row.featName,
      categorySlug: row.categorySlug,
      categoryName: row.categoryName,
      categoryTypeLabel: row.categoryTypeLabel,
      repeatable: row.repeatable,
      prerequisite: row.prerequisite,
      sourceChapter: row.sourceChapter,
      sourceChapterTitle: row.sourceChapterTitle,
      editionSlug: row.editionSlug,
      benefits: row.benefits ?? [],
    };
  }
}
