import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackground } from '@entities/views/v-phb-background.entity';
import {
  applyEditionSlugFilter,
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { BackgroundResponseDto } from '../dto/background-response.dto';
import { BackgroundSummaryResponseDto } from '../dto/background-summary-response.dto';
import { BackgroundsMapper } from '../backgrounds.mapper';

const BACKGROUND_CURSOR_KEYS = [
  { expr: 'background.backgroundName', name: 'backgroundName' },
  { expr: 'background.backgroundSlug', name: 'backgroundSlug' },
] as const;

@Injectable()
export class FindBackgroundsQuery {
  constructor(
    @InjectRepository(VPhbBackground)
    private readonly backgroundsRepo: Repository<VPhbBackground>,
    private readonly mapper: BackgroundsMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    editionSlugs?: string[],
    fields?: 'summary',
    _includeCatalogOnly = false,
  ): Promise<
    PaginatedResponseDto<BackgroundResponseDto | BackgroundSummaryResponseDto>
  > {
    const qb = this.backgroundsRepo
      .createQueryBuilder('background')
      .orderBy('background.backgroundName', 'ASC')
      .addOrderBy('background.backgroundSlug', 'ASC');

    if (fields === 'summary') {
      qb.select([
        'background.backgroundSlug',
        'background.backgroundName',
        'background.editionSlug',
      ]);
    }

    applyIlikeSearch(qb, [
      'background.backgroundName',
      'background.backgroundSlug',
      'background.tagline',
      'background.summary',
    ], q);
    applyEditionSlugFilter(qb, 'background.editionSlug', editionSlugs);

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: BACKGROUND_CURSOR_KEYS,
      encodeRow: (row) => ({
        backgroundName: row.backgroundName,
        backgroundSlug: row.backgroundSlug,
      }),
    });
    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
