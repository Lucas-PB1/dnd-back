import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSpell } from '../../entities/views/v-phb-spell.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { SpellResponseDto } from './dto/spell-response.dto';

@Injectable()
export class SpellsService {
  constructor(
    @InjectRepository(VPhbSpell)
    private readonly spellsRepo: Repository<VPhbSpell>,
  ) {}

  async findAll(page = 1, limit = 20): Promise<PaginatedResponseDto<SpellResponseDto>> {
    const rows = await this.spellsRepo.find({ order: { level: 'ASC', name: 'ASC' } });
    return paginate(rows.map((row) => this.toDto(row)), page, limit);
  }

  async findBySlug(slug: string): Promise<SpellResponseDto> {
    const row = await this.spellsRepo.findOne({ where: { slug } });
    if (!row) {
      throw new NotFoundException(`Spell '${slug}' not found`);
    }
    return this.toDto(row);
  }

  private toDto(row: VPhbSpell): SpellResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      level: row.level,
      levelLabel: row.levelLabel,
      schoolSlug: row.schoolSlug,
      schoolName: row.schoolName,
      castingTime: row.castingTime,
      range: row.range,
      hasVerbal: row.hasVerbal,
      hasSomatic: row.hasSomatic,
      hasMaterial: row.hasMaterial,
      materialDescription: row.materialDescription,
      componentsLabel: row.componentsLabel,
      duration: row.duration,
      concentration: row.concentration,
      ritual: row.ritual,
      description: row.description,
      higherLevels: row.higherLevels,
      sourceChapter: row.sourceChapter,
      editionSlug: row.editionSlug,
    };
  }
}
