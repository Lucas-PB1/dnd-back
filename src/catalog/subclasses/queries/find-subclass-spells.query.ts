import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSubclassPreparedSpell } from '@entities/views/v-phb-subclass-prepared-spell.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { requireNonEmpty } from '@common/require-found';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { SubclassSpellResponseDto } from '../dto/subclass-spell-response.dto';
import { SubclassesMapper } from '../subclasses.mapper';

@Injectable()
export class FindSubclassSpellsQuery {
  constructor(
    @InjectRepository(VPhbSubclassPreparedSpell)
    private readonly spellsRepo: Repository<VPhbSubclassPreparedSpell>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: SubclassesMapper,
  ) {}

  async execute(
    subclassSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<SubclassSpellResponseDto>> {
    await this.catalogLookup.findSubclassOrFail(subclassSlug);
    const rows = await this.spellsRepo.find({
      where: { subclassSlug },
      order: { unlockLevel: 'ASC', spellName: 'ASC', spellSlug: 'ASC' },
    });
    requireNonEmpty(rows, `Subclass '${subclassSlug}' has no prepared spells`);
    return paginateByKeys(
      rows.map((row) => this.mapper.toSpellDto(row)),
      {
        cursor,
        limit,
        keyNames: ['unlockLevel', 'slug'],
        encodeRow: (row) => ({
          unlockLevel: row.unlockLevel,
          slug: row.slug,
        }),
      },
    );
  }
}
