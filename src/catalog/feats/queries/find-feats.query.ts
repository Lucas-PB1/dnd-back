import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbFeat } from '../../../entities/views/v-phb-feat.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
import { FeatResponseDto } from '../dto/feat-response.dto';
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
  ): Promise<PaginatedResponseDto<FeatResponseDto>> {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.featsRepo
      .createQueryBuilder('feat')
      .orderBy('feat.featName', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(feat.featName ILIKE :q OR feat.featSlug ILIKE :q OR feat.categoryName ILIKE :q OR feat.categoryTypeLabel ILIKE :q OR COALESCE(feat.prerequisite, \'\') ILIKE :q)',
        { q: `%${term}%` },
      );
    }

    const categorySlug = category?.trim();
    if (categorySlug) {
      qb.andWhere('feat.categorySlug = :categorySlug', { categorySlug });
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
