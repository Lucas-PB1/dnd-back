import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClassFeature } from '../../../entities/views/v-phb-class-feature.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginateOrNotFound } from '../../../common/dto/pagination.dto';
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
    page = 1,
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

    return paginateOrNotFound(
      rows,
      (row) => this.mapper.toClassFeatureDto(row),
      page,
      limit,
      `Class '${classSlug}' has no class features data`,
    );
  }
}
