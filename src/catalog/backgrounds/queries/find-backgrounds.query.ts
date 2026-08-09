import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackground } from '@entities/views/v-phb-background.entity';
import {
  applyEditionSlugFilter,
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '@common/dto/pagination.dto';
import { BackgroundResponseDto } from '../dto/background-response.dto';
import { BackgroundSummaryResponseDto } from '../dto/background-summary-response.dto';
import { BackgroundsMapper } from '../backgrounds.mapper';

@Injectable()
export class FindBackgroundsQuery {
  constructor(
    @InjectRepository(VPhbBackground)
    private readonly backgroundsRepo: Repository<VPhbBackground>,
    private readonly mapper: BackgroundsMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    editionSlugs?: string[],
    fields?: 'summary',
  ): Promise<
    PaginatedResponseDto<BackgroundResponseDto | BackgroundSummaryResponseDto>
  > {
    const qb = this.backgroundsRepo
      .createQueryBuilder('background')
      .orderBy('background.backgroundName', 'ASC');

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

    const { rows, meta } = await paginateQb(qb, page, limit);
    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
