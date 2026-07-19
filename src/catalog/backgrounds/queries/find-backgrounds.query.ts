import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackground } from '../../../entities/views/v-phb-background.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
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
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.backgroundsRepo
      .createQueryBuilder('background')
      .orderBy('background.backgroundName', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(background.backgroundName ILIKE :q OR background.backgroundSlug ILIKE :q OR background.tagline ILIKE :q OR background.summary ILIKE :q)',
        { q: `%${term}%` },
      );
    }

    qb.skip((safePage - 1) * safeLimit).take(safeLimit);

    const [rows, total] = await qb.getManyAndCount();
    const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);

    return {
      data: rows.map((row) => this.mapper.toDto(row)),
      meta: {
        page: safePage,
        limit: safeLimit,
        total,
        totalPages,
      },
    };
  }
}
