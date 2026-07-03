import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { SpeciesResponseDto } from '../dto/species-response.dto';
import { SpeciesMapper } from '../species.mapper';

@Injectable()
export class FindSpeciesBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: SpeciesMapper,
  ) {}

  async execute(slug: string): Promise<SpeciesResponseDto> {
    const row = await this.catalogLookup.findSpeciesOrFail(slug);
    return this.mapper.toDto(row);
  }
}
