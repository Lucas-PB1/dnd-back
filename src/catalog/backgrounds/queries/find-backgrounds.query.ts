import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackground } from '../../../entities/views/v-phb-background.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { BackgroundResponseDto } from '../dto/background-response.dto';
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
  ): Promise<PaginatedResponseDto<BackgroundResponseDto>> {
    const qb = this.backgroundsRepo
      .createQueryBuilder('background')
      .orderBy('background.backgroundName', 'ASC');

    applyIlikeSearch(qb, [
      'background.backgroundName',
      'background.backgroundSlug',
      'background.tagline',
      'background.summary',
    ], q);

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toDto(row)), meta };
  }
}
