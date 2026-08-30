import { Injectable, NotFoundException } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { SpeciesResponseDto } from '../dto/species-response.dto';
import { SpeciesMapper } from '../species.mapper';
import { isSpeciesExcludedFromCatalog } from '../domain/species-edition-gating';

@Injectable()
export class FindSpeciesBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: SpeciesMapper,
  ) {}

  async execute(
    slug: string,
    editionSlugs?: string[],
  ): Promise<SpeciesResponseDto> {
    if (isSpeciesExcludedFromCatalog(slug, editionSlugs)) {
      throw new NotFoundException(`Species '${slug}' not found`);
    }
    const row = await this.catalogLookup.findSpeciesOrFail(slug);
    return this.mapper.toDto(row);
  }
}
