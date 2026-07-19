import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbFeat } from '../../../entities/views/v-phb-feat.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
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
    const qb = this.featsRepo
      .createQueryBuilder('feat')
      .orderBy('feat.featName', 'ASC');

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

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toDto(row)), meta };
  }
}
