import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbItemType } from '@entities/views/v-phb-item-type.entity';
import { CatalogNamedLabelDto } from '../dto/catalog-named-label.dto';

@Injectable()
export class FindItemTypesQuery {
  constructor(
    @InjectRepository(VPhbItemType)
    private readonly types: Repository<VPhbItemType>,
  ) {}

  async execute(): Promise<CatalogNamedLabelDto[]> {
    const rows = await this.types.find({
      order: { sortOrder: 'ASC', slug: 'ASC' },
    });
    return rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      sortOrder: row.sortOrder,
    }));
  }
}
