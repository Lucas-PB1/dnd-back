import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VClassSpellSlots } from '../../../entities/views/v-class-spell-slots.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginate } from '../../../common/dto/pagination.dto';
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
    page = 1,
    limit = 20,
  ): Promise<PaginatedResponseDto<ClassSpellSlotsResponseDto>> {
    await this.catalogLookup.findClassOrFail(classSlug);

    const rows = await this.spellSlotsRepo.find({
      where: { classSlug },
      order: { classLevel: 'ASC' },
    });
    if (rows.length === 0) {
      throw new NotFoundException(`Class '${classSlug}' has no spell slot progression`);
    }
    return paginate(rows.map((row) => this.mapper.toSpellSlotsDto(row)), page, limit);
  }
}
