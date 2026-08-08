import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbFeat } from '../../../entities/views/v-phb-feat.entity';
import {
  applyEditionSlugFilter,
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { FeatResponseDto } from '../dto/feat-response.dto';
import { FeatSummaryResponseDto } from '../dto/feat-summary-response.dto';
import { FeatsMapper } from '../feats.mapper';

@Injectable()
export class FindFeatsQuery {
  constructor(
    @InjectRepository(VPhbFeat)
    private readonly featsRepo: Repository<VPhbFeat>,
    private readonly mapper: FeatsMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    category?: string,
    editionSlugs?: string[],
    fields?: 'summary',
  ): Promise<PaginatedResponseDto<FeatResponseDto | FeatSummaryResponseDto>> {
    const qb = this.featsRepo
      .createQueryBuilder('feat')
      .orderBy('feat.featName', 'ASC');

    if (fields === 'summary') {
      qb.select(['feat.featSlug', 'feat.featName', 'feat.categorySlug']);
    }

    applyIlikeSearch(qb, [
      'feat.featName',
      'feat.featSlug',
      'feat.categoryName',
      'feat.categoryTypeLabel',
      "COALESCE(feat.prerequisite, '')",
    ], q);

    const categorySlug = category?.trim();
    if (categorySlug) {
      qb.andWhere('feat.categorySlug = :categorySlug', { categorySlug });
    }
    applyEditionSlugFilter(qb, 'feat.editionSlug', editionSlugs);

    const { rows, meta } = await paginateQb(qb, page, limit);
    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
