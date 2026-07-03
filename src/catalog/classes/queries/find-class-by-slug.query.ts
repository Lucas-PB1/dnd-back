import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { ClassResponseDto } from '../dto/class-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(slug: string): Promise<ClassResponseDto> {
    const row = await this.catalogLookup.findClassOrFail(slug);
    return this.mapper.toClassDto(row);
  }
}
