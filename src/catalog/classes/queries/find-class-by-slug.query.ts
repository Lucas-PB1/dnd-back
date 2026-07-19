import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { ClassResponseDto } from '../dto/class-response.dto';
import { ClassesMapper } from '../classes.mapper';
import { ClassProficienciesQuery } from './class-proficiencies.query';

@Injectable()
export class FindClassBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
    private readonly proficiencies: ClassProficienciesQuery,
  ) {}

  async execute(slug: string): Promise<ClassResponseDto> {
    const row = await this.catalogLookup.findClassOrFail(slug);
    const dto = this.mapper.toClassDto(row);
    const profs = await this.proficiencies.forClassSlug(slug);
    return { ...dto, ...profs };
  }
}
