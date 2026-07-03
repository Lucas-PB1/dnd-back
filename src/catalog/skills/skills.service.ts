import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSkill } from '../../entities/phb-skill.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { SkillResponseDto } from './dto/skill-response.dto';

@Injectable()
export class SkillsService {
  constructor(
    @InjectRepository(PhbSkill)
    private readonly skillsRepo: Repository<PhbSkill>,
  ) {}

  async findAll(page = 1, limit = 20): Promise<PaginatedResponseDto<SkillResponseDto>> {
    const rows = await this.skillsRepo.find({ order: { name: 'ASC' } });
    return paginate(rows.map((row) => this.toDto(row)), page, limit);
  }

  async findBySlug(slug: string): Promise<SkillResponseDto> {
    const row = await this.skillsRepo.findOne({ where: { slug } });
    if (!row) {
      throw new NotFoundException(`Skill '${slug}' not found`);
    }
    return this.toDto(row);
  }

  private toDto(row: PhbSkill): SkillResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      abilitySlug: row.ability.slug,
      abilityName: row.ability.name,
      description: row.description,
    };
  }
}
