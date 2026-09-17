import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PhbClassRef } from '@entities/class/phb-class-ref.entity';
import { ClassResponseDto } from '../dto/class-response.dto';
import { ClassesMapper } from '../classes.mapper';
import { ClassProficienciesQuery } from './class-proficiencies.query';

@Injectable()
export class FindClassBySlugQuery {
  constructor(
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
    private readonly proficiencies: ClassProficienciesQuery,
    @InjectRepository(PhbClassRef)
    private readonly classRef: Repository<PhbClassRef>,
  ) {}

  async execute(slug: string): Promise<ClassResponseDto> {
    const row = await this.catalogLookup.findClassOrFail(slug);
    const dto = this.mapper.toClassDto(row);
    const profs = await this.proficiencies.forClassSlug(slug);
    const meta = await this.classRef.findOne({
      where: { slug },
      select: ['subclassUnlockLevel', 'jackOfAllTradesLevel'],
    });
    return {
      ...dto,
      ...profs,
      subclassUnlockLevel: meta?.subclassUnlockLevel ?? null,
      jackOfAllTradesLevel: meta?.jackOfAllTradesLevel ?? null,
    };
  }
}
