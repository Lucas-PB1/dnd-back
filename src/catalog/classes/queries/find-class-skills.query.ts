import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbClassSkillChoice } from '@entities/views/v-phb-class-skill-choice.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
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
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassSkillResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);
    const rows = await this.skillsRepo.find({
      where: { classSlug },
      order: { skillName: 'ASC', skillSlug: 'ASC' },
    });
    requireNonEmpty(rows, `Class '${classSlug}' has no skill choices`);
    return paginateByKeys(
      rows.map((row) => this.mapper.toClassSkillDto(row)),
      {
        cursor,
        limit,
        keyNames: ['name', 'slug'],
        encodeRow: (row) => ({ name: row.name, slug: row.slug }),
      },
    );
  }
}
