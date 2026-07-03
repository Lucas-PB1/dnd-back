import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { BackgroundResponseDto } from '../dto/background-response.dto';
import { BackgroundsMapper } from '../backgrounds.mapper';

@Injectable()
export class FindBackgroundBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: BackgroundsMapper,
  ) {}

  async execute(slug: string): Promise<BackgroundResponseDto> {
    const row = await this.catalogLookup.findBackgroundOrFail(slug);
    return this.mapper.toDto(row);
  }
}
