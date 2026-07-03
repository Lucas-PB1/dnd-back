import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbAlignment } from '../../entities/phb-alignment.entity';
import { PhbLanguage } from '../../entities/phb-language.entity';
import { PhbCharacterLevel } from '../../entities/phb-character-level.entity';
import { PaginatedResponseDto, paginate } from '../../common/dto/pagination.dto';
import { AlignmentResponseDto } from './dto/alignment-response.dto';
import { LanguageResponseDto } from './dto/language-response.dto';
import { CharacterLevelResponseDto } from './dto/character-level-response.dto';

@Injectable()
export class ReferenceService {
  constructor(
    @InjectRepository(PhbAlignment)
    private readonly alignmentsRepo: Repository<PhbAlignment>,
    @InjectRepository(PhbLanguage)
    private readonly languagesRepo: Repository<PhbLanguage>,
    @InjectRepository(PhbCharacterLevel)
    private readonly characterLevelsRepo: Repository<PhbCharacterLevel>,
  ) {}

  async findAllAlignments(page = 1, limit = 20): Promise<PaginatedResponseDto<AlignmentResponseDto>> {
    const rows = await this.alignmentsRepo.find({ order: { name: 'ASC' } });
    return paginate(rows.map((row) => this.toAlignmentDto(row)), page, limit);
  }

  async findAllLanguages(page = 1, limit = 20): Promise<PaginatedResponseDto<LanguageResponseDto>> {
    const rows = await this.languagesRepo.find({ order: { name: 'ASC' } });
    return paginate(rows.map((row) => this.toLanguageDto(row)), page, limit);
  }

  async findAllCharacterLevels(
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<CharacterLevelResponseDto>> {
    const rows = await this.characterLevelsRepo.find({ order: { level: 'ASC' } });
    return paginate(rows.map((row) => this.toCharacterLevelDto(row)), page, limit);
  }

  private toAlignmentDto(row: PhbAlignment): AlignmentResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      abbreviation: row.abbreviation,
      description: row.description,
    };
  }

  private toLanguageDto(row: PhbLanguage): LanguageResponseDto {
    return {
      slug: row.slug,
      name: row.name,
      script: row.script,
      typicalSpeakers: row.typicalSpeakers,
      isRare: row.isRare,
    };
  }

  private toCharacterLevelDto(row: PhbCharacterLevel): CharacterLevelResponseDto {
    return {
      level: row.level,
      proficiencyBonus: row.proficiencyBonus,
      xpThreshold: row.xpThreshold,
    };
  }
}
