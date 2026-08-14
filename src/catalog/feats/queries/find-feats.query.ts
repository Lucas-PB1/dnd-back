import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbFeat } from '@entities/views/v-phb-feat.entity';
import {
  applyEditionSlugFilter,
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { FeatResponseDto } from '../dto/feat-response.dto';
import { FeatSummaryResponseDto } from '../dto/feat-summary-response.dto';
import { FeatsMapper } from '../feats.mapper';

const FEAT_CURSOR_KEYS = [
  { expr: 'feat.featName', name: 'featName' },
  { expr: 'feat.featSlug', name: 'featSlug' },
] as const;

@Injectable()
export class FindFeatsQuery {
  constructor(
    @InjectRepository(VPhbFeat)
    private readonly featsRepo: Repository<VPhbFeat>,
    private readonly mapper: FeatsMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    category?: string,
    editionSlugs?: string[],
    fields?: 'summary',
  ): Promise<PaginatedResponseDto<FeatResponseDto | FeatSummaryResponseDto>> {
    const qb = this.featsRepo
      .createQueryBuilder('feat')
      .orderBy('feat.featName', 'ASC')
      .addOrderBy('feat.featSlug', 'ASC');

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

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: FEAT_CURSOR_KEYS,
      encodeRow: (row) => ({
        featName: row.featName,
        featSlug: row.featSlug,
      }),
    });
    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
