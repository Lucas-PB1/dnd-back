import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbToolPoolItem } from '@entities/views/v-phb-tool-pool-item.entity';
import { ToolPoolResponseDto } from '../dto/tool-pool-response.dto';

const POOL_ORDER = ['instrument', 'gaming', 'artisan'] as const;

@Injectable()
export class FindToolPoolsQuery {
  constructor(
    @InjectRepository(VPhbToolPoolItem)
    private readonly items: Repository<VPhbToolPoolItem>,
  ) {}

  async execute(): Promise<ToolPoolResponseDto[]> {
    const rows = await this.items.find({ order: { name: 'ASC', slug: 'ASC' } });
    return POOL_ORDER.map((pool) => ({
      pool,
      items: rows
        .filter((row) => row.pool === pool)
        .map((row) => ({ slug: row.slug, name: row.name })),
    }));
  }
}
