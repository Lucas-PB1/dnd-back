import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VClassSpellSlots } from '@entities/views/v-class-spell-slots.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { ClassSpellSlotsResponseDto } from '../dto/class-spell-slots-response.dto';
import { ClassesMapper } from '../classes.mapper';

@Injectable()
export class FindClassSpellSlotsQuery {
  constructor(
    @InjectRepository(VClassSpellSlots)
    private readonly spellSlotsRepo: Repository<VClassSpellSlots>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: ClassesMapper,
  ) {}

  async execute(
    classSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassSpellSlotsResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);
    const rows = await this.spellSlotsRepo.find({
      where: { classSlug },
      order: { classLevel: 'ASC' },
    });
    requireNonEmpty(rows, `Class '${classSlug}' has no spell slot progression`);
    return paginateByKeys(
      rows.map((row) => this.mapper.toSpellSlotsDto(row)),
      {
        cursor,
        limit,
        keyNames: ['classLevel'],
        encodeRow: (row) => ({ classLevel: row.classLevel }),
      },
    );
  }
}
