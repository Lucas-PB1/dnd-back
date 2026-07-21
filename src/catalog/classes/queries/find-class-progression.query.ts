import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClassProgression } from '../../../entities/views/v-phb-class-progression.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginateOrNotFound } from '../../../common/dto/pagination.dto';
import { ClassProgressionResponseDto } from '../dto/class-progression-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassProgressionQuery {
  constructor(
    @InjectRepository(VPhbClassProgression)
    private readonly progressionRepo: Repository<VPhbClassProgression>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    classSlug: string,
    page = 1,
    limit = 25,
  ): Promise<PaginatedResponseDto<ClassProgressionResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);
    const rows = await this.progressionRepo.find({
      where: { classSlug },
      order: { level: 'ASC' },
    });
    return paginateOrNotFound(
      rows,
      (row) => this.mapper.toProgressionDto(row),
      page,
      limit,
      `Class '${classSlug}' has no level progression`,
    );
  }
}
