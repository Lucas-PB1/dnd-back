import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { In, Repository } from 'typeorm';
import { VPhbFeat } from '../../../entities/views/v-phb-feat.entity';
import { FeatResponseDto } from '../dto/feat-response.dto';
import { FeatsMapper } from '../feats.mapper';

@Injectable()
export class FindFeatsBySlugsQuery {
  constructor(
    @InjectRepository(VPhbFeat)
    private readonly featsRepo: Repository<VPhbFeat>,
    private readonly mapper: FeatsMapper,
  ) {}

  async execute(slugs: string[]): Promise<FeatResponseDto[]> {
    if (slugs.length === 0) return [];
    const rows = await this.featsRepo.find({
      where: { featSlug: In(slugs) },
      order: { featName: 'ASC' },
    });
    const bySlug = new Map(rows.map((row) => [row.featSlug, row]));
    return slugs
      .map((slug) => bySlug.get(slug))
      .filter((row): row is VPhbFeat => row != null)
      .map((row) => this.mapper.toDto(row));
  }
}
