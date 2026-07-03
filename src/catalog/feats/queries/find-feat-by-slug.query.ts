import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
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
    const row = await this.featsRepo.findOne({ where: { featSlug: slug } });
    if (!row) {
      throw new NotFoundException(`Feat '${slug}' not found`);
    }
    return this.mapper.toDto(row);
  }
}
