import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { SpellResponseDto } from '../dto/spell-response.dto';
import { SpellsMapper } from '../spells.mapper';

@Injectable()
export class FindSpellBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: SpellsMapper,
  ) {}

  async execute(slug: string): Promise<SpellResponseDto> {
    const row = await this.catalogLookup.findSpellOrFail(slug);
    return this.mapper.toDto(row);
  }
}
