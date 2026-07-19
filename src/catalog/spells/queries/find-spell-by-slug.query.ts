import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { requireFound } from '../../../common/require-found';
import { VPhbSpell } from '../../../entities/views/v-phb-spell.entity';
import { SpellResponseDto } from '../dto/spell-response.dto';
import { SpellsMapper } from '../spells.mapper';

@Injectable()
export class FindSpellBySlugQuery {
  constructor(
    @InjectRepository(VPhbSpell)
    private readonly spellsRepo: Repository<VPhbSpell>,
    private readonly mapper: SpellsMapper,
  ) {}

  async execute(slug: string): Promise<SpellResponseDto> {
    const row = requireFound(
      await this.spellsRepo.findOne({ where: { slug } }),
      `Spell '${slug}' not found`,
    );
    return this.mapper.toDto(row);
  }
}
