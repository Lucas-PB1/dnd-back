import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSubclass } from '@entities/views/v-phb-subclass.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import {
  filterRowsByEditionSlug,
  PaginatedResponseDto,
  paginate,
} from '@common/dto/pagination.dto';
import { SubclassResponseDto } from '@catalog/subclasses/dto/subclass-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassSubclassesQuery {
  constructor(
    @InjectRepository(VPhbSubclass)
    private readonly subclassesRepo: Repository<VPhbSubclass>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    classSlug: string,
    page = 1,
    limit = 20,
    editionSlugs?: string[],
  ): Promise<PaginatedResponseDto<SubclassResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);

    const rows = await this.subclassesRepo.find({
      where: { classSlug },
      order: { subclassName: 'ASC' },
    });
    const filtered = filterRowsByEditionSlug(rows, editionSlugs);
    return paginate(
      filtered.map((row) => this.mapper.toSubclassDto(row)),
      page,
      limit,
    );
  }
}
