import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbLanguage } from '../../../entities/phb-language.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
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
    const qb = this.languagesRepo
      .createQueryBuilder('lang')
      .orderBy('lang.name', 'ASC');

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

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toLanguageDto(row)), meta };
  }
}
