import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbLanguage } from '../../../entities/phb-language.entity';
import { PaginatedResponseDto } from '../../../common/dto/pagination.dto';
import { LanguageResponseDto } from '../dto/language-response.dto';
import { ReferenceMapper } from '../reference.mapper';

@Injectable()
export class FindLanguagesQuery {
  constructor(
    @InjectRepository(PhbLanguage)
    private readonly languagesRepo: Repository<PhbLanguage>,
    private readonly mapper: ReferenceMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    rare?: 'true' | 'false',
  ): Promise<PaginatedResponseDto<LanguageResponseDto>> {
    const safePage = Math.max(1, page);
    const safeLimit = Math.min(100, Math.max(1, limit));

    const qb = this.languagesRepo
      .createQueryBuilder('lang')
      .orderBy('lang.name', 'ASC');

    const term = q?.trim();
    if (term) {
      qb.andWhere(
        '(lang.name ILIKE :q OR lang.slug ILIKE :q OR COALESCE(lang.script, \'\') ILIKE :q OR COALESCE(lang.typicalSpeakers, \'\') ILIKE :q)',
        { q: `%${term}%` },
      );
    }

    if (rare === 'true') {
      qb.andWhere('lang.isRare = true');
    } else if (rare === 'false') {
      qb.andWhere('lang.isRare = false');
    }

    qb.skip((safePage - 1) * safeLimit).take(safeLimit);

    const [rows, total] = await qb.getManyAndCount();
    const totalPages = Math.max(1, Math.ceil(total / safeLimit) || 1);

    return {
      data: rows.map((row) => this.mapper.toLanguageDto(row)),
      meta: {
        page: safePage,
        limit: safeLimit,
        total,
        totalPages,
      },
    };
  }
}
