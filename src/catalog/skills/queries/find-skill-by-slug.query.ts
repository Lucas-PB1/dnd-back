import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSkill } from '../../../entities/phb-skill.entity';
import { SkillResponseDto } from '../dto/skill-response.dto';
import { SkillsMapper } from '../skills.mapper';

@Injectable()
export class FindSkillBySlugQuery {
  constructor(
    @InjectRepository(PhbSkill)
    private readonly skillsRepo: Repository<PhbSkill>,
    private readonly mapper: SkillsMapper,
  ) {}

  async execute(slug: string): Promise<SkillResponseDto> {
    const row = await this.skillsRepo.findOne({ where: { slug } });
    if (!row) {
      throw new NotFoundException(`Skill '${slug}' not found`);
    }
    return this.mapper.toDto(row);
  }
}
