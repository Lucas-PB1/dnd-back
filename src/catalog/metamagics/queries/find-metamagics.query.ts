import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbMetamagic } from '@entities/phb-metamagic.entity';
import { MetamagicResponseDto } from '../dto/metamagic-response.dto';

@Injectable()
export class FindMetamagicsQuery {
  constructor(
    @InjectRepository(PhbMetamagic)
    private readonly repo: Repository<PhbMetamagic>,
  ) {}

  async execute(): Promise<MetamagicResponseDto[]> {
    const rows = await this.repo.find({
      order: { sortOrder: 'ASC', name: 'ASC' },
    });
    return rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      description: row.description,
      cost: row.cost,
      stacksWithOther: row.stacksWithOther,
      sortOrder: row.sortOrder,
    }));
  }
}
