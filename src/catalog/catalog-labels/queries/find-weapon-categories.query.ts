import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbWeaponCategory } from '@entities/views/v-phb-weapon-category.entity';
import { CatalogNamedLabelDto } from '../dto/catalog-named-label.dto';

@Injectable()
export class FindWeaponCategoriesQuery {
  constructor(
    @InjectRepository(VPhbWeaponCategory)
    private readonly categories: Repository<VPhbWeaponCategory>,
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
