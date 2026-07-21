import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSpeciesTraitChoices } from '../../../entities/views/v-phb-species-trait-choices.entity';
import { CatalogLookupService } from '../../catalog-lookup.service';
import { PaginatedResponseDto, paginateOrNotFound } from '../../../common/dto/pagination.dto';
import { SpeciesTraitChoiceResponseDto } from '../dto/species-trait-choice-response.dto';
import { SpeciesMapper } from '../species.mapper';

@Injectable()
export class FindSpeciesTraitChoicesQuery {
  constructor(
    @InjectRepository(VPhbSpeciesTraitChoices)
    private readonly traitChoicesRepo: Repository<VPhbSpeciesTraitChoices>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: SpeciesMapper,
  ) {}

  async execute(
    speciesSlug: string,
    page = 1,
    limit = 100,
  ): Promise<PaginatedResponseDto<SpeciesTraitChoiceResponseDto>> {
    await this.catalogLookup.findSpeciesOrFail(speciesSlug);
    const rows = await this.traitChoicesRepo.find({
      where: { speciesSlug },
      order: { traitName: 'ASC', choiceName: 'ASC' },
    });
    return paginateOrNotFound(
      rows,
      (row) => this.mapper.toTraitChoiceDto(row),
      page,
      limit,
      `Species '${speciesSlug}' has no trait choices`,
    );
  }
}
