import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpecies } from '@entities/phb-species.entity';
import {
  applyIlikeSearch,
  DEFAULT_PHB_EDITION_SLUG,
  PaginatedResponseDto,
  paginateQbCursor,
} from '@common/dto/pagination.dto';
import { SpeciesResponseDto } from '../dto/species-response.dto';
import { SpeciesSummaryResponseDto } from '../dto/species-summary-response.dto';
import { SpeciesMapper } from '../species.mapper';

const SPECIES_CURSOR_KEYS = [
  { expr: 'species.name', name: 'name' },
  { expr: 'species.slug', name: 'slug' },
] as const;

@Injectable()
export class FindSpeciesQuery {
  constructor(
    @InjectRepository(PhbSpecies)
    private readonly speciesRepo: Repository<PhbSpecies>,
    private readonly mapper: SpeciesMapper,
  ) {}

  async execute(
    cursor?: string,
    limit = 20,
    q?: string,
    editionSlugs?: string[],
    fields?: 'summary',
  ): Promise<
    PaginatedResponseDto<SpeciesResponseDto | SpeciesSummaryResponseDto>
  > {
    const qb = this.speciesRepo
      .createQueryBuilder('species')
      .orderBy('species.name', 'ASC')
      .addOrderBy('species.slug', 'ASC');

    if (fields === 'summary') {
      qb.select([
        'species.slug',
        'species.name',
        'species.sourceMeta',
      ]);
    }

    applyIlikeSearch(qb, [
      'species.name',
      'species.slug',
      "COALESCE(species.tagline, '')",
      "COALESCE(species.summary, '')",
      'species.creatureType',
      'species.size',
    ], q);

    const slugs = editionSlugs?.map((slug) => slug.trim()).filter(Boolean);
    if (slugs?.length) {
      qb.andWhere(
        `COALESCE(species.source_meta->>'editionSlug', :defaultEdition) IN (:...editionSlugs)`,
        {
          defaultEdition: DEFAULT_PHB_EDITION_SLUG,
          editionSlugs: slugs,
        },
      );
    }

    const { rows, meta } = await paginateQbCursor(qb, {
      cursor,
      limit,
      keys: SPECIES_CURSOR_KEYS,
      encodeRow: (row) => ({ name: row.name, slug: row.slug }),
    });
    const data =
      fields === 'summary'
        ? rows.map((row) => this.mapper.toSummaryDto(row))
        : rows.map((row) => this.mapper.toDto(row));
    return { data, meta };
  }
}
