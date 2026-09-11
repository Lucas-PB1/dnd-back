import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbClassFeature } from '@entities/class/phb-class-feature.entity';
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
    @InjectRepository(PhbClassFeature)
    private readonly featuresRepo: Repository<PhbClassFeature>,
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
      where: { klass: { slug: classSlug } },
      relations: ['klass'],
      order: { level: 'ASC', name: 'ASC' },
    });
    if (maxLevel !== undefined) {
      rows = rows.filter((row) => row.level <= maxLevel);
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
