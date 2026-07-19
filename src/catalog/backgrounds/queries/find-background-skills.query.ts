import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackgroundSkill } from '../../../entities/views/v-phb-background-skill.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginateOrNotFound } from '../../../common/dto/pagination.dto';
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
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<BackgroundSkillResponseDto>> {
    await this.catalogLookup.findBackgroundOrFail(backgroundSlug);
    const rows = await this.skillsRepo.find({
      where: { backgroundSlug },
      order: { skillName: 'ASC' },
    });
    return paginateOrNotFound(
      rows,
      (row) => this.mapper.toSkillDto(row),
      page,
      limit,
      `Background '${backgroundSlug}' has no fixed skills`,
    );
  }
}
