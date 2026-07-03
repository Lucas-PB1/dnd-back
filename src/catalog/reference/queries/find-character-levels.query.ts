import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbCharacterLevel } from '../../../entities/phb-character-level.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { CharacterLevelResponseDto } from '../dto/character-level-response.dto';
import { ReferenceMapper } from '../reference.mapper';

@Injectable()
export class FindCharacterLevelsQuery {
  constructor(
    @InjectRepository(PhbCharacterLevel)
    private readonly characterLevelsRepo: Repository<PhbCharacterLevel>,
    private readonly mapper: ReferenceMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<CharacterLevelResponseDto>> {
    const rows = await this.characterLevelsRepo.find({ order: { level: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toCharacterLevelDto(row)), page, limit);
  }
}
