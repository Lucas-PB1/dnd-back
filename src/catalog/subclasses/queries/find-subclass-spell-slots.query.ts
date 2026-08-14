import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VSubclassSpellSlots } from '@entities/views/v-subclass-spell-slots.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { SubclassSpellSlotsResponseDto } from '../dto/subclass-spellcasting-response.dto';

@Injectable()
export class FindSubclassSpellSlotsQuery {
  constructor(
    @InjectRepository(VSubclassSpellSlots)
    private readonly spellSlotsRepo: Repository<VSubclassSpellSlots>,
    private readonly catalogLookup: CatalogLookupService,
  ) {}

  async execute(
    subclassSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<SubclassSpellSlotsResponseDto>> {
    await this.catalogLookup.findSubclassOrFail(subclassSlug);
    const rows = await this.spellSlotsRepo.find({
      where: { subclassSlug },
      order: { classLevel: 'ASC' },
    });
    requireNonEmpty(
      rows,
      `Subclass '${subclassSlug}' has no spell slot progression`,
    );
    return paginateByKeys(
      rows.map((row) => ({
        classLevel: row.classLevel,
        patternSlug: row.patternSlug,
        patternName: row.patternName,
        proficiencyBonus: row.proficiencyBonus,
        cantrips: row.cantrips,
        preparedSpells: row.preparedSpells,
        spellListClassSlug: row.spellListClassSlug,
        spellSlots: row.spellSlots,
      })),
      {
        cursor,
        limit,
        keyNames: ['classLevel'],
        encodeRow: (row) => ({ classLevel: row.classLevel }),
      },
    );
  }
}
