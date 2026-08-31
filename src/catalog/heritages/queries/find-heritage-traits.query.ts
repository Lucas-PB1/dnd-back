import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbHeritageTrait } from '@entities/phb-heritage-trait.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { HeritageTraitResponseDto } from '../dto/heritage-trait-response.dto';
import { HeritagesMapper } from '../heritages.mapper';

@Injectable()
export class FindHeritageTraitsQuery {
  constructor(
    @InjectRepository(PhbHeritageTrait)
    private readonly traitsRepo: Repository<PhbHeritageTrait>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: HeritagesMapper,
  ) {}

  async execute(
    heritageSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<HeritageTraitResponseDto>> {
    await this.catalogLookup.findHeritageOrFail(heritageSlug);

    const rows = await this.traitsRepo.find({
      order: { category: 'ASC', slug: 'ASC' },
    });
    requireNonEmpty(rows, 'Modular heritage trait pool is empty');

    return paginateByKeys(
      rows.map((row) => this.mapper.toTraitDto(row)),
      {
        cursor,
        limit,
        keyNames: ['category', 'slug'],
        encodeRow: (row) => ({ category: row.category, slug: row.slug }),
      },
    );
  }
}
