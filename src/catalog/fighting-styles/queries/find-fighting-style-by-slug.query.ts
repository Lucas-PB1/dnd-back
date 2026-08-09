import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { requireFound } from '@common/require-found';
import { PhbFightingStyle } from '@entities/phb-fighting-style.entity';
import { FightingStyleResponseDto } from '../dto/fighting-style-response.dto';
import { FightingStylesMapper } from '../fighting-styles.mapper';

@Injectable()
export class FindFightingStyleBySlugQuery {
  constructor(
    @InjectRepository(PhbFightingStyle)
    private readonly stylesRepo: Repository<PhbFightingStyle>,
    private readonly mapper: FightingStylesMapper,
  ) {}

  async execute(slug: string): Promise<FightingStyleResponseDto> {
    const row = requireFound(
      await this.stylesRepo.findOne({ where: { slug } }),
      `Fighting style '${slug}' not found`,
    );
    return this.mapper.toDto(row);
  }
}
