import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbHeritageTraditionalBuild } from '@entities/views/v-phb-heritage-traditional-build.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { HeritageTraditionalTraitResponseDto } from '../dto/heritage-traditional-trait-response.dto';

@Injectable()
export class FindHeritageTraditionalBuildQuery {
  constructor(
    @InjectRepository(VPhbHeritageTraditionalBuild)
    private readonly traditionalRepo: Repository<VPhbHeritageTraditionalBuild>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async execute(
    heritageSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<HeritageTraditionalTraitResponseDto>> {
    await this.catalogLookup.findHeritageOrFail(heritageSlug);

    const rows = await this.traditionalRepo.find({
      where: { heritageSlug },
      order: { sortOrder: 'ASC' },
    });
    requireNonEmpty(rows, `Heritage '${heritageSlug}' has no traditional build`);

    const dtos = rows.map((row) => ({
      traitSlug: row.traitSlug,
      traitName: row.traitName,
      category: row.category,
      categoryHint: row.categoryHint,
      sortOrder: row.sortOrder,
    }));

    return paginateByKeys(dtos, {
      cursor,
      limit,
      keyNames: ['sortOrder', 'traitSlug'],
      encodeRow: (row) => ({
        sortOrder: String(row.sortOrder),
        traitSlug: row.traitSlug,
      }),
    });
  }
}
