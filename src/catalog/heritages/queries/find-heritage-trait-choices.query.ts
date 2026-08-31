import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbHeritageTraitChoices } from '@entities/views/v-phb-heritage-trait-choices.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { HeritageTraitChoiceResponseDto } from '../dto/heritage-trait-choice-response.dto';
import { HeritagesMapper } from '../heritages.mapper';

@Injectable()
export class FindHeritageTraitChoicesQuery {
  constructor(
    @InjectRepository(VPhbHeritageTraitChoices)
    private readonly traitChoicesRepo: Repository<VPhbHeritageTraitChoices>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: HeritagesMapper,
  ) {}

  async execute(
    heritageSlug: string,
    cursor?: string,
    limit = 100,
  ): Promise<PaginatedResponseDto<HeritageTraitChoiceResponseDto>> {
    await this.catalogLookup.findHeritageOrFail(heritageSlug);

    const qb = this.traitChoicesRepo
      .createQueryBuilder('c')
      .where('c.heritage_slug = :heritageSlug', { heritageSlug })
      .orderBy('c.sort_order', 'ASC')
      .addOrderBy('c.label', 'ASC')
      .addOrderBy('c.trait_slug', 'ASC');

    const rows = await qb.getMany();
    requireNonEmpty(rows, `Heritage '${heritageSlug}' has no trait choices`);
    return paginateByKeys(
      rows.map((row) => this.mapper.toTraitChoiceDto(row)),
      {
        cursor,
        limit,
        keyNames: ['choiceKind', 'traitSlug'],
        encodeRow: (row) => ({
          choiceKind: row.choiceKind,
          traitSlug: row.traitSlug,
        }),
      },
    );
  }
}
