import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbFeat } from '../../entities/views/v-phb-feat.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { FeatResponseDto } from './dto/feat-response.dto';

@Injectable()
export class FeatsService {
  constructor(
    @InjectRepository(VPhbFeat)
    private readonly featsRepo: Repository<VPhbFeat>,
  ) {}

  async findAll(page = 1, limit = 20): Promise<PaginatedResponseDto<FeatResponseDto>> {
    const rows = await this.featsRepo.find({ order: { featName: 'ASC' } });
    return paginate(rows.map((row) => this.toDto(row)), page, limit);
  }

  async findBySlug(slug: string): Promise<FeatResponseDto> {
    const row = await this.featsRepo.findOne({ where: { featSlug: slug } });
    if (!row) {
      throw new NotFoundException(`Feat '${slug}' not found`);
    }
    return this.toDto(row);
  }

  private toDto(row: VPhbFeat): FeatResponseDto {
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
