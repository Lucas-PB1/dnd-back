import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { FindSpeciesQuery } from './queries/find-species.query';
import { FindSpeciesBySlugQuery } from './queries/find-species-by-slug.query';
import { FindSpeciesTraitsQuery } from './queries/find-species-traits.query';
import { FindSpeciesTraitChoicesQuery } from './queries/find-species-trait-choices.query';
import { SpeciesResponseDto } from './dto/species-response.dto';

@ApiTags('catalog-species')
@Controller('species')
export class SpeciesController {
  constructor(
    private readonly findSpecies: FindSpeciesQuery,
    private readonly findSpeciesBySlug: FindSpeciesBySlugQuery,
    private readonly findSpeciesTraits: FindSpeciesTraitsQuery,
    private readonly findSpeciesTraitChoices: FindSpeciesTraitChoicesQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB species (paginated)' })
  @ApiOkResponse({ description: 'Paginated species list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.findSpecies.execute(query.page, query.limit);
  }

  @Get(':slug/traits')
  @ApiOperation({ summary: 'List traits for a species (paginated)' })
  @ApiParam({ name: 'slug', example: 'elf' })
  @ApiOkResponse({ description: 'Paginated species traits' })
  @ApiNotFoundResponse({ description: 'Species not found' })
  findTraits(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findSpeciesTraits.execute(slug, query.page, query.limit);
  }

  @Get(':slug/trait-choices')
  @ApiOperation({ summary: 'List trait choice options for a species (paginated)' })
  @ApiParam({ name: 'slug', example: 'elf' })
  @ApiOkResponse({ description: 'Paginated trait choices (lineage, ancestry, etc.)' })
  @ApiNotFoundResponse({ description: 'Species not found or no choices' })
  findTraitChoices(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findSpeciesTraitChoices.execute(slug, query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get species by slug' })
  @ApiParam({ name: 'slug', example: 'elf' })
  @ApiOkResponse({ type: SpeciesResponseDto })
  @ApiNotFoundResponse({ description: 'Species not found' })
  findOne(@Param('slug') slug: string): Promise<SpeciesResponseDto> {
    return this.findSpeciesBySlug.execute(slug);
  }
}
