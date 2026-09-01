import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbBackground } from '@entities/views/v-phb-background.entity';
import { FeatOriginBackgroundDto } from '../dto/feat-response.dto';

@Injectable()
export class FindFeatOriginBackgroundsQuery {
  constructor(
    @InjectRepository(VPhbBackground)
    private readonly backgroundsRepo: Repository<VPhbBackground>,
  ) {}

  async execute(featSlug: string): Promise<FeatOriginBackgroundDto[]> {
    const rows = await this.backgroundsRepo
      .createQueryBuilder('bg')
      .where('bg.featSlug = :featSlug', { featSlug })
      .orWhere(':featSlug = ANY(bg.originFeatChoiceSlugs)', { featSlug })
      .orderBy('bg.backgroundName', 'ASC')
      .getMany();

    return rows.map((row) => ({
      slug: row.backgroundSlug,
      name: row.backgroundName,
    }));
  }
}
