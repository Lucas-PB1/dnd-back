import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSubclass } from '../../../entities/views/v-phb-subclass.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
import { SubclassResponseDto } from '../dto/subclass-response.dto';
import { SubclassesMapper } from '../subclasses.mapper';

@Injectable()
export class FindSubclassesQuery {
  constructor(
    @InjectRepository(VPhbSubclass)
    private readonly subclassesRepo: Repository<VPhbSubclass>,
    private readonly mapper: SubclassesMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    classSlug?: string,
  ): Promise<PaginatedResponseDto<SubclassResponseDto>> {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.subclassesRepo
      .createQueryBuilder('sc')
      .orderBy('sc.className', 'ASC')
      .addOrderBy('sc.subclassName', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(sc.subclassName ILIKE :q OR sc.subclassSlug ILIKE :q OR sc.className ILIKE :q OR sc.classSlug ILIKE :q OR COALESCE(sc.tagline, \'\') ILIKE :q OR COALESCE(sc.summary, \'\') ILIKE :q)',
        { q: `%${term}%` },
      );
    }

    const klass = classSlug?.trim();
    if (klass) {
      qb.andWhere('sc.classSlug = :classSlug', { classSlug: klass });
    }

    qb.skip((safePage - 1) * safeLimit).take(safeLimit);

    const [rows, total] = await qb.getManyAndCount();
    const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);

    return {
      data: rows.map((row) => this.mapper.toSubclassDto(row)),
      meta: {
        page: safePage,
        limit: safeLimit,
        total,
        totalPages,
      },
    };
  }
}
