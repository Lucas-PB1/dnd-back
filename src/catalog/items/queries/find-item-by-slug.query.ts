import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { ItemResponseDto } from '../dto/item-response.dto';
import { ItemsMapper } from '../items.mapper';

@Injectable()
export class FindItemBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ItemsMapper,
  ) {}

  async execute(slug: string): Promise<ItemResponseDto> {
    const row = await this.catalogLookup.findItemOrFail(slug);
    return this.mapper.toDto(row);
  }
}
