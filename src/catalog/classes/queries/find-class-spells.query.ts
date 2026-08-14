import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VSpellByClass } from '@entities/views/v-spell-by-class.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PaginatedResponseDto, paginateQbCursor } from '@common/dto/pagination.dto';
import { ClassSpellResponseDto } from '../dto/class-spell-response.dto';
import { ClassesMapper } from '../classes.mapper';

const CLASS_SPELL_CURSOR_KEYS = [
  { expr: 'row.spellLevel', name: 'spellLevel' },
  { expr: 'row.spellSlug', name: 'spellSlug' },
] as const;

@Injectable()
export class FindClassSpellsQuery {
  constructor(
    @InjectRepository(VSpellByClass)
    private readonly spellsByClassRepo: Repository<VSpellByClass>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    classSlug: string,
    cursor?: string,
    limit = 20,
    maxLevel?: number,
  ): Promise<PaginatedResponseDto<ClassSpellResponseDto>> {
    const qb = this.spellsByClassRepo
      .createQueryBuilder('row')
      .where('row.classSlug = :classSlug', { classSlug })
      .orderBy('row.spellLevel', 'ASC')
      .addOrderBy('row.spellSlug', 'ASC');

    if (maxLevel !== undefined) {
      qb.andWhere('row.spellLevel <= :maxLevel', { maxLevel });
    }

    const [, { rows, meta }] = await Promise.all([
      this.catalogLookup.findClassOrFail(classSlug),
      paginateQbCursor(qb, {
        cursor,
        limit,
        keys: CLASS_SPELL_CURSOR_KEYS,
        encodeRow: (row) => ({
          spellLevel: Number(row.spellLevel),
          spellSlug: row.spellSlug,
        }),
      }),
    ]);

    return {
      data: rows.map((row) => this.mapper.toClassSpellDto(row)),
      meta,
    };
  }
}
