import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSpell } from '../../../entities/views/v-phb-spell.entity';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { SpellResponseDto } from '../dto/spell-response.dto';
import { SpellsMapper } from '../spells.mapper';

@Injectable()
export class FindSpellsQuery {
  constructor(
    @InjectRepository(VPhbSpell)
    private readonly spellsRepo: Repository<VPhbSpell>,
    private readonly mapper: SpellsMapper,
  ) {}

  async execute(page = 1, limit = 20): Promise<PaginatedResponseDto<SpellResponseDto>> {
    const rows = await this.spellsRepo.find({ order: { level: 'ASC', name: 'ASC' } });
    return paginate(rows.map((row) => this.mapper.toDto(row)), page, limit);
  }
}
