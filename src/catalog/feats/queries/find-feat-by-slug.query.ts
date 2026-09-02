import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { FeatResponseDto } from '../dto/feat-response.dto';
import { FeatsMapper } from '../feats.mapper';
import { FindFeatOriginBackgroundsQuery } from './find-feat-origin-backgrounds.query';

@Injectable()
export class FindFeatBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: FeatsMapper,
    private readonly originBackgroundsQuery: FindFeatOriginBackgroundsQuery,
  ) {}

  async execute(slug: string): Promise<FeatResponseDto> {
    const row = await this.catalogLookup.findFeatOrFail(slug);
    const originBackgrounds = await this.originBackgroundsQuery.execute(slug);
    return {
      ...this.mapper.toDto(row),
      originBackgrounds,
    };
  }
}
