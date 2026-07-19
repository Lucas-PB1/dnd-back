import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSpell } from '../../../entities/views/v-phb-spell.entity';
import {
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { SpellResponseDto } from '../dto/spell-response.dto';
import { SpellsMapper } from '../spells.mapper';

@Injectable()
export class FindSpellsQuery {
  constructor(
    @InjectRepository(VPhbSpell)
    private readonly spellsRepo: Repository<VPhbSpell>,
    private readonly mapper: SpellsMapper,
  ) {}

  async execute(
    page = 1,
    limit = 20,
    q?: string,
    level?: number,
    school?: string,
  ): Promise<PaginatedResponseDto<SpellResponseDto>> {
    const qb = this.spellsRepo
      .createQueryBuilder('spell')
      .orderBy('spell.level', 'ASC')
      .addOrderBy('spell.name', 'ASC');

    applyIlikeSearch(qb, [
      'spell.name',
      'spell.slug',
      'spell.schoolName',
      'spell.levelLabel',
    ], q);

    if (level !== undefined && level !== null && !Number.isNaN(level)) {
      qb.andWhere('spell.level = :level', { level });
    }

    const schoolSlug = school?.trim();
    if (schoolSlug) {
      qb.andWhere('spell.schoolSlug = :schoolSlug', { schoolSlug });
    }

    const { rows, meta } = await paginateQb(qb, page, limit);
    return { data: rows.map((row) => this.mapper.toDto(row)), meta };
  }
}
