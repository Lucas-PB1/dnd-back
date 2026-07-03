import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSkill } from '../../../entities/phb-skill.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { SkillResponseDto } from '../dto/skill-response.dto';
import { SkillsMapper } from '../skills.mapper';

@Injectable()
export class FindSkillsQuery {
  constructor(
    @InjectRepository(PhbSkill)
    private readonly skillsRepo: Repository<PhbSkill>,
    private readonly mapper: SkillsMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<SkillResponseDto>> {
    const rows = await this.skillsRepo.find({ order: { name: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toDto(row)), page, limit);
  }
}
