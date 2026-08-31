import { Injectable, NotFoundException } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { HeritageResponseDto } from '../dto/heritage-response.dto';
import { HeritagesMapper } from '../heritages.mapper';

@Injectable()
export class FindHeritageBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: HeritagesMapper,
  ) {}

  async execute(
    slug: string,
    editionSlugs?: string[],
  ): Promise<HeritageResponseDto> {
    const row = await this.catalogLookup.findHeritageOrFail(slug);
    if (editionSlugs?.length) {
      const edition =
        (row.sourceMeta?.editionSlug as string | undefined)?.trim() ??
        'phb-2024-pt';
      if (!editionSlugs.includes(edition)) {
        throw new NotFoundException(`Heritage '${slug}' not found`);
      }
    }
    return this.mapper.toDto(row);
  }
}
