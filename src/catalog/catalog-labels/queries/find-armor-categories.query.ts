import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbArmorCategory } from '@entities/equipment/phb-armor-category.entity';
import { CatalogNamedLabelDto } from '../dto/catalog-named-label.dto';

@Injectable()
export class FindArmorCategoriesQuery {
  constructor(
    @InjectRepository(PhbArmorCategory)
    private readonly categories: Repository<PhbArmorCategory>,
  ) {}

  async execute(): Promise<CatalogNamedLabelDto[]> {
    const rows = await this.categories.find({
      order: { sortOrder: 'ASC', slug: 'ASC' },
    });
    return rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      sortOrder: row.sortOrder,
    }));
  }
}
