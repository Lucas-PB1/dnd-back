import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VSpellByClass } from '../../../entities/views/v-spell-by-class.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
import { ClassSpellResponseDto } from '../dto/class-spell-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassSpellsQuery {
  constructor(
    @InjectRepository(VSpellByClass)
    private readonly spellsByClassRepo: Repository<VSpellByClass>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    classSlug: string,
    page = 1,
    limit = 20,
    maxLevel?: number,
  ): Promise<PaginatedResponseDto<ClassSpellResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);

    let rows = await this.spellsByClassRepo.find({
      where: { classSlug },
      order: { spellLevel: 'ASC', spellName: 'ASC' },
    });
    if (maxLevel !== undefined) {
      rows = rows.filter((row) => row.spellLevel <= maxLevel);
    }
    return paginate(rows.map((row) => this.mapper.toClassSpellDto(row)), page, limit);
  }
}
