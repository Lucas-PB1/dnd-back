import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClass } from '../../../entities/views/v-phb-class.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
import { ClassResponseDto } from '../dto/class-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassesQuery {
  constructor(
    @InjectRepository(VPhbClass)
    private readonly classesRepo: Repository<VPhbClass>,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
  ): Promise<PaginatedResponseDto<ClassResponseDto>> {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.classesRepo
      .createQueryBuilder('klass')
      .orderBy('klass.className', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(klass.className ILIKE :q OR klass.classSlug ILIKE :q OR COALESCE(klass.tagline, \'\') ILIKE :q OR COALESCE(klass.summary, \'\') ILIKE :q)',
        { q: `%${term}%` },
      );
    }

    qb.skip((safePage - 1) * safeLimit).take(safeLimit);

    const [rows, total] = await qb.getManyAndCount();
    const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);

    return {
      data: rows.map((row) => this.mapper.toClassDto(row)),
      meta: {
        page: safePage,
        limit: safeLimit,
        total,
        totalPages,
      },
    };
  }
}
