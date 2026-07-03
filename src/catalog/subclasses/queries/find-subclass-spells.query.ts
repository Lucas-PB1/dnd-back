import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSubclassPreparedSpell } from '../../../entities/views/v-phb-subclass-prepared-spell.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
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
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<SubclassSpellResponseDto>> {
    await this.catalogLookup.findSubclassOrFail(subclassSlug);

    const rows = await this.spellsRepo.find({
      where: { subclassSlug },
      order: { unlockLevel: 'ASC', spellName: 'ASC' },
    });
    if (rows.length === 0) {
      throw new NotFoundException(`Subclass '${subclassSlug}' has no prepared spells`);
    }
    return paginate(rows.map((row) => this.mapper.toSpellDto(row)), page, limit);
  }
}
