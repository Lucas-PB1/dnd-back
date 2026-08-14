import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PhbSpeciesTrait } from '@entities/phb-species-trait.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import {
  PaginatedResponseDto,
  paginateByKeys,
} from '@common/dto/pagination.dto';
import { SpeciesTraitResponseDto } from '../dto/species-trait-response.dto';
import { SpeciesMapper } from '../species.mapper';

@Injectable()
export class FindSpeciesTraitsQuery {
  constructor(
    @InjectRepository(PhbSpeciesTrait)
    private readonly traitsRepo: Repository<PhbSpeciesTrait>,
    private readonly catalogLookup: CatalogLookupService,
    private readonly mapper: SpeciesMapper,
  ) {}

  async execute(
    speciesSlug: string,
    cursor?: string,
    limit = 20,
  ): Promise<PaginatedResponseDto<SpeciesTraitResponseDto>> {
    await this.catalogLookup.findSpeciesOrFail(speciesSlug);

    const rows = await this.traitsRepo.find({
      where: { species: { slug: speciesSlug } },
      order: { name: 'ASC' },
    });
    return paginateByKeys(
      rows.map((row) => this.mapper.toTraitDto(row)),
      {
        cursor,
        limit,
        keyNames: ['name'],
        encodeRow: (row) => ({ name: row.name }),
      },
    );
  }
}
