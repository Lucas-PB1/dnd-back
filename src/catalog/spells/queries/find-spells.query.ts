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
import { sangromancyDescriptionSqlPattern } from '@game/spellcasting/domain/sangromancy/sangromancy-spells';
import {
  applySpellListExtraFilters,
  type SpellCastingTimeKind,
  type SpellRangeKind,
} from '../domain/spell-list-extra-filters';
import { SpellResponseDto } from '../dto/spell-response.dto';
import { SpellSummaryResponseDto } from '../dto/spell-summary-response.dto';
import { SpellsMapper } from '../spells.mapper';

const SPELL_CURSOR_KEYS = [
  { expr: 'spell.level', name: 'level' },
  { expr: 'spell.slug', name: 'slug' },
] as const;

export type FindSpellsFilters = {
  cursor?: string;
  limit?: number;
  q?: string;
  level?: number;
  school?: string;
  editionSlugs?: string[];
  fields?: 'summary';
  sangromancy?: boolean;
  ritual?: boolean;
  concentration?: boolean;
  roll?: 'attack' | 'save';
  castingTime?: SpellCastingTimeKind;
  saveAbility?: string;
  rangeKind?: SpellRangeKind;
};

@Injectable()
export class FindSpellsQuery {
  constructor(
    @InjectRepository(VPhbSpell)
    private readonly spellsRepo: Repository<VPhbSpell>,
    private readonly mapper: SpellsMapper,
  ) {}

  async execute(
    filters: FindSpellsFilters = {},
  ): Promise<
    PaginatedResponseDto<SpellResponseDto | SpellSummaryResponseDto>
  > {
    const qb = this.spellsRepo
      .createQueryBuilder('spell')
      .orderBy('spell.level', 'ASC')
      .addOrderBy('spell.slug', 'ASC');

    if (filters.fields === 'summary') {
      qb.select([
        'spell.slug',
        'spell.name',
        'spell.level',
        'spell.schoolSlug',
        'spell.schoolName',
        'spell.ritual',
        'spell.concentration',
        'spell.castingTime',
        'spell.range',
        'spell.levelLabel',
        'spell.editionSlug',
        'spell.requiresAttackRoll',
        'spell.saveAbilitySlug',
      ]);
    }

    applyIlikeSearch(
      qb,
      ['spell.name', 'spell.slug', 'spell.schoolName', 'spell.levelLabel'],
      filters.q,
    );

    if (
      filters.level !== undefined &&
      filters.level !== null &&
      !Number.isNaN(filters.level)
    ) {
      qb.andWhere('spell.level = :level', { level: filters.level });
    }

    const schoolSlug = filters.school?.trim();
    if (schoolSlug) {
      qb.andWhere('spell.schoolSlug = :schoolSlug', { schoolSlug });
    }
    if (filters.sangromancy) {
      qb.andWhere('spell.description LIKE :sangromancyTag', {
        sangromancyTag: sangromancyDescriptionSqlPattern(),
      });
    }

    applySpellListExtraFilters(qb, {
      ritual: filters.ritual,
      concentration: filters.concentration,
      roll: filters.roll,
      castingTime: filters.castingTime,
      saveAbility: filters.saveAbility,
      rangeKind: filters.rangeKind,
    });
    applyEditionSlugFilter(qb, 'spell.editionSlug', filters.editionSlugs);

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor: filters.cursor,
      limit: filters.limit ?? 20,
      keys: SPELL_CURSOR_KEYS,
      encodeRow: (row) => ({ level: Number(row.level), slug: row.slug }),
    });
    const data =
      filters.fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
