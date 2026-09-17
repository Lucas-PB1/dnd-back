import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbFeatCategory } from '@entities/views/v-phb-feat-category.entity';
import { FeatCategoryResponseDto } from '../dto/feat-category-response.dto';

@Injectable()
export class FindFeatCategoriesQuery {
  constructor(
    @InjectRepository(VPhbFeatCategory)
    private readonly categories: Repository<VPhbFeatCategory>,
  ) {}

  async execute(): Promise<FeatCategoryResponseDto[]> {
    const rows = await this.categories.find({
      order: { sortOrder: 'ASC', slug: 'ASC' },
    });
    return rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      typeLabel: row.typeLabel,
      sortOrder: row.sortOrder,
    }));
  }
}
