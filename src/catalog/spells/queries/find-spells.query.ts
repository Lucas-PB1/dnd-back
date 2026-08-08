import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSpell } from '../../../entities/views/v-phb-spell.entity';
import {
  applyEditionSlugFilter,
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQb,
} from '../../../common/dto/pagination.dto';
import { SpellResponseDto } from '../dto/spell-response.dto';
import { SpellSummaryResponseDto } from '../dto/spell-summary-response.dto';
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
    editionSlugs?: string[],
    fields?: 'summary',
  ): Promise<
    PaginatedResponseDto<SpellResponseDto | SpellSummaryResponseDto>
  > {
    const qb = this.spellsRepo
      .createQueryBuilder('spell')
      .orderBy('spell.level', 'ASC')
      .addOrderBy('spell.name', 'ASC');

    if (fields === 'summary') {
      qb.select([
        'spell.slug',
        'spell.name',
        'spell.level',
        'spell.schoolSlug',
        'spell.schoolName',
        'spell.ritual',
      ]);
    }

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
    applyEditionSlugFilter(qb, 'spell.editionSlug', editionSlugs);

    const { rows, meta } = await paginateQb(qb, page, limit);
    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
