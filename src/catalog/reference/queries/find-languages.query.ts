import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbLanguage } from '@entities/phb-language.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { LanguageResponseDto } from '../dto/language-response.dto';
import { ReferenceMapper } from '../reference.mapper';

const LANGUAGE_CURSOR_KEYS = [
  { expr: 'lang.name', name: 'name' },
  { expr: 'lang.slug', name: 'slug' },
] as const;

@Injectable()
export class FindLanguagesQuery {
  constructor(
    @InjectRepository(PhbLanguage)
    private readonly languagesRepo: Repository<PhbLanguage>,
    private readonly mapper: ReferenceMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    rare?: 'true' | 'false',
  ): Promise<PaginatedResponseDto<LanguageResponseDto>> {
    const qb = this.languagesRepo
      .createQueryBuilder('lang')
      .orderBy('lang.name', 'ASC')
      .addOrderBy('lang.slug', 'ASC');

    applyIlikeSearch(qb, [
      'lang.name',
      'lang.slug',
      "COALESCE(lang.script, '')",
      "COALESCE(lang.typicalSpeakers, '')",
    ], q);

    if (rare === 'true') {
      qb.andWhere('lang.isRare = true');
    } else if (rare === 'false') {
      qb.andWhere('lang.isRare = false');
    }

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: LANGUAGE_CURSOR_KEYS,
      encodeRow: (row) => ({ name: row.name, slug: row.slug }),
    });
    return { data: rows.map((row) => this.mapper.toLanguageDto(row)), meta };
  }
}
