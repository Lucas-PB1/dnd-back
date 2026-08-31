import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbHeritage } from '@entities/phb-heritage.entity';
import {
  applyIlikeSearch,
  DEFAULT_PHB_EDITION_SLUG,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { HeritageResponseDto } from '../dto/heritage-response.dto';
import { HeritageSummaryResponseDto } from '../dto/heritage-summary-response.dto';
import { HeritagesMapper } from '../heritages.mapper';

const HERITAGE_CURSOR_KEYS = [
  { expr: 'heritage.name', name: 'name' },
  { expr: 'heritage.slug', name: 'slug' },
] as const;

@Injectable()
export class FindHeritagesQuery {
  constructor(
    @InjectRepository(PhbHeritage)
    private readonly heritageRepo: Repository<PhbHeritage>,
    private readonly mapper: HeritagesMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    editionSlugs?: string[],
    fields?: 'summary',
    includeCatalogOnly = false,
  ): Promise<
    PaginatedResponseDto<HeritageResponseDto | HeritageSummaryResponseDto>
  > {
    const qb = this.heritageRepo
      .createQueryBuilder('heritage')
      .orderBy('heritage.name', 'ASC')
      .addOrderBy('heritage.slug', 'ASC');

    if (fields === 'summary') {
      qb.select(['heritage.slug', 'heritage.name', 'heritage.sourceMeta']);
    }

    applyIlikeSearch(
      qb,
      [
        'heritage.name',
        'heritage.slug',
        "COALESCE(heritage.tagline, '')",
        "COALESCE(heritage.summary, '')",
        'heritage.creatureType',
        'heritage.category',
      ],
      q,
    );

    const slugs = editionSlugs?.map((slug) => slug.trim()).filter(Boolean);
    if (slugs?.length) {
      qb.andWhere(
        `COALESCE(heritage.source_meta->>'editionSlug', :defaultEdition) IN (:...editionSlugs)`,
        {
          defaultEdition: DEFAULT_PHB_EDITION_SLUG,
          editionSlugs: slugs,
        },
      );
    }

    if (!includeCatalogOnly) {
      qb.andWhere(
        `COALESCE(heritage.source_meta->>'catalogOnly', 'false') NOT IN ('true', '1')`,
      );
    }

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: HERITAGE_CURSOR_KEYS,
      encodeRow: (row) => ({ name: row.name, slug: row.slug }),
    });
    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
