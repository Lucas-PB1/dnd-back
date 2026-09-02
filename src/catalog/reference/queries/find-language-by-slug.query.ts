import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { LanguageResponseDto } from '../dto/language-response.dto';
import { ReferenceMapper } from '../reference.mapper';

@Injectable()
export class FindLanguageBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ReferenceMapper,
  ) {}

  async execute(slug: string): Promise<LanguageResponseDto> {
    const row = await this.catalogLookup.findLanguageOrFail(slug);
    return this.mapper.toLanguageDto(row);
  }
}
