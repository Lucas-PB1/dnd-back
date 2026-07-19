import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClassSkillChoice } from '../../../entities/views/v-phb-class-skill-choice.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginateOrNotFound } from '../../../common/dto/pagination.dto';
import { ClassSkillResponseDto } from '../dto/class-skill-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassSkillsQuery {
  constructor(
    @InjectRepository(VPhbClassSkillChoice)
    private readonly skillsRepo: Repository<VPhbClassSkillChoice>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    classSlug: string,
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassSkillResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);
    const rows = await this.skillsRepo.find({
      where: { classSlug },
      order: { skillName: 'ASC' },
    });
    return paginateOrNotFound(
      rows,
      (row) => this.mapper.toClassSkillDto(row),
      page,
      limit,
      `Class '${classSlug}' has no skill choices`,
    );
  }
}
