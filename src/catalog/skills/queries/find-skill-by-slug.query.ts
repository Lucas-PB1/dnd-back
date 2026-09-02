import { Injectable } from '@nestjs/common';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { SkillResponseDto } from '../dto/skill-response.dto';
import { SkillsMapper } from '../skills.mapper';

@Injectable()
export class FindSkillBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: SkillsMapper,
  ) {}

  async execute(slug: string): Promise<SkillResponseDto> {
    const row = await this.catalogLookup.findSkillOrFail(slug);
    return this.mapper.toDto(row);
  }
}
