import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackgroundSkill } from '@entities/views/v-phb-background-skill.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { BackgroundSkillResponseDto } from '../dto/background-skill-response.dto';
import { BackgroundsMapper } from '../backgrounds.mapper';

@Injectable()
export class FindBackgroundSkillsQuery {
  constructor(
    @InjectRepository(VPhbBackgroundSkill)
    private readonly skillsRepo: Repository<VPhbBackgroundSkill>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: BackgroundsMapper,
  ) {}

  async execute(
    backgroundSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<BackgroundSkillResponseDto>> {
    await this.catalogLookup.findBackgroundOrFail(backgroundSlug);
    const rows = await this.skillsRepo.find({
      where: { backgroundSlug },
      order: { skillName: 'ASC', skillSlug: 'ASC' },
    });
    requireNonEmpty(rows, `Background '${backgroundSlug}' has no fixed skills`);
    return paginateByKeys(
      rows.map((row) => this.mapper.toSkillDto(row)),
      {
        cursor,
        limit,
        keyNames: ['name', 'slug'],
        encodeRow: (row) => ({ name: row.name, slug: row.slug }),
      },
    );
  }
}
