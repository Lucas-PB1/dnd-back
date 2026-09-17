import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpellSchool } from '@entities/spell/phb-spell-school.entity';
import { CatalogNamedLabelDto } from '../dto/catalog-named-label.dto';

@Injectable()
export class FindSpellSchoolsQuery {
  constructor(
    @InjectRepository(PhbSpellSchool)
    private readonly schools: Repository<PhbSpellSchool>,
  ) {}

  async execute(): Promise<CatalogNamedLabelDto[]> {
    const rows = await this.schools.find({
      order: { sortOrder: 'ASC', slug: 'ASC' },
    });
    return rows.map((row) => ({
      slug: row.slug,
      name: row.name,
      sortOrder: row.sortOrder,
    }));
  }
}
