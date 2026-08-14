import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSpell } from '@entities/views/v-phb-spell.entity';
import {
  applyEditionSlugFilter,
  applyIlikeSearch,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { SpellResponseDto } from '../dto/spell-response.dto';
import { SpellSummaryResponseDto } from '../dto/spell-summary-response.dto';
import { SpellsMapper } from '../spells.mapper';

const SPELL_CURSOR_KEYS = [
  { expr: 'spell.level', name: 'level' },
  { expr: 'spell.slug', name: 'slug' },
] as const;

@Injectable()
export class FindSpellsQuery {
  constructor(
    @InjectRepository(VPhbSpell)
    private readonly spellsRepo: Repository<VPhbSpell>,
    private readonly mapper: SpellsMapper,
  ) {}

  async execute(
    cursor?: string,
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
      .addOrderBy('spell.slug', 'ASC');

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

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: SPELL_CURSOR_KEYS,
      encodeRow: (row) => ({ level: Number(row.level), slug: row.slug }),
    });
    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
