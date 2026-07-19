import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { requireFound } from '../../../common/require-found';
import { VPhbFeat } from '../../../entities/views/v-phb-feat.entity';
import { FeatResponseDto } from '../dto/feat-response.dto';
import { FeatsMapper } from '../feats.mapper';

@Injectable()
export class FindFeatBySlugQuery {
  constructor(
    @InjectRepository(VPhbFeat)
    private readonly featsRepo: Repository<VPhbFeat>,
    private readonly mapper: FeatsMapper,
  ) {}

  async execute(slug: string): Promise<FeatResponseDto> {
    const row = requireFound(
      await this.featsRepo.findOne({ where: { featSlug: slug } }),
      `Feat '${slug}' not found`,
    );
    return this.mapper.toDto(row);
  }
}
