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

    // Produto: só build tradicional (+ tamanho). Sem pool custom / 9º traço.
    const filtered = rows.filter((row) => {
      if (row.choiceKind === 'heritage_trait_9') return false;
      if (row.choiceKind === 'heritage_speed_trade') return false;
      if (row.choiceKind.startsWith('heritage_trait_')) {
        return row.isTraditional;
      }
      return true;
    });
    requireNonEmpty(
      filtered,
      `Heritage '${heritageSlug}' has no traditional trait choices`,
    );

    return paginateByKeys(
      filtered.map((row) => this.mapper.toTraitChoiceDto(row)),
      {
        cursor,
        limit,
        keyNames: ['sortOrder'],
        encodeRow: (row) => ({ sortOrder: row.sortOrder }),
      },
    );
  }
}
