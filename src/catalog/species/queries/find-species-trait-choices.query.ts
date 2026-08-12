import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { VPhbSpeciesTraitChoices } from '@entities/views/v-phb-species-trait-choices.entity';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { PaginatedResponseDto, paginateOrNotFound } from '@common/dto/pagination.dto';
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
    editionSlugs?: string[],
  ): Promise<PaginatedResponseDto<SpeciesTraitChoiceResponseDto>> {
    await this.catalogLookup.findSpeciesOrFail(speciesSlug);

    const qb = this.traitChoicesRepo
      .createQueryBuilder('c')
      .where('c.species_slug = :speciesSlug', { speciesSlug })
      .orderBy('c.trait_name', 'ASC')
      .addOrderBy('c.choice_name', 'ASC');

    if (editionSlugs?.length) {
      qb.andWhere(
        '(c.edition_slug IS NULL OR c.edition_slug IN (:...editionSlugs))',
        { editionSlugs },
      );
    }

    const rows = await qb.getMany();
    return paginateOrNotFound(
      rows,
      (row) => this.mapper.toTraitChoiceDto(row),
      page,
      limit,
      `Species '${speciesSlug}' has no trait choices`,
    );
  }
}
