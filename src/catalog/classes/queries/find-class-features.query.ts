import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClassFeature } from '@entities/views/v-phb-class-feature.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { ClassFeatureResponseDto } from '../dto/class-feature-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassFeaturesQuery {
  constructor(
    @InjectRepository(VPhbClassFeature)
    private readonly featuresRepo: Repository<VPhbClassFeature>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    classSlug: string,
    cursor?: string,
    limit = 50,
    maxLevel?: number,
  ): Promise<PaginatedResponseDto<ClassFeatureResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);

    let rows = await this.featuresRepo.find({
      where: { classSlug },
      order: { featureLevel: 'ASC', featureName: 'ASC' },
    });
    if (maxLevel !== undefined) {
      rows = rows.filter((row) => row.featureLevel <= maxLevel);
    }

    requireNonEmpty(rows, `Class '${classSlug}' has no class features data`);
    return paginateByKeys(
      rows.map((row) => this.mapper.toClassFeatureDto(row)),
      {
        cursor,
        limit,
        keyNames: ['featureLevel', 'featureName'],
        encodeRow: (row) => ({
          featureLevel: row.featureLevel,
          featureName: row.featureName,
        }),
      },
    );
  }
}
