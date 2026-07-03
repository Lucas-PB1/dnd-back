import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { SubclassResponseDto } from '../dto/subclass-response.dto';
import { SubclassesMapper } from '../subclasses.mapper';

@Injectable()
export class FindSubclassBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: SubclassesMapper,
  ) {}

  async execute(slug: string): Promise<SubclassResponseDto> {
    const row = await this.catalogLookup.findSubclassOrFail(slug);
    return this.mapper.toSubclassDto(row);
  }
}
