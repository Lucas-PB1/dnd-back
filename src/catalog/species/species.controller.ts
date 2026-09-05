import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '@common/dto/pagination.dto';
import { SpeciesQueryDto } from './dto/species-query.dto';
import { FindSpeciesQuery } from './queries/find-species.query';
import { FindSpeciesBySlugQuery } from './queries/find-species-by-slug.query';
import { FindSpeciesTraitsQuery } from './queries/find-species-traits.query';
import { FindSpeciesTraitChoicesQuery } from './queries/find-species-trait-choices.query';
import { SpeciesResponseDto } from './dto/species-response.dto';
import { FindOwnerEffectsQuery } from '@catalog/effects/queries/find-owner-effects.query';
import { EffectSummaryResponseDto } from '@catalog/effects/dto/effect-summary-response.dto';

@ApiTags('catalog-species')
@Controller('species')
export class SpeciesController {
  constructor(
    private readonly findSpecies: FindSpeciesQuery,
    private readonly findSpeciesBySlug: FindSpeciesBySlugQuery,
    private readonly findSpeciesTraits: FindSpeciesTraitsQuery,
    private readonly findSpeciesTraitChoices: FindSpeciesTraitChoicesQuery,
    private readonly findOwnerEffects: FindOwnerEffectsQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB species (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated species list' })
  findAll(@Query() query: SpeciesQueryDto) {
    return this.findSpecies.execute(
      query.cursor,
      query.limit,
      query.q,
      query.editionSlugs,
      query.fields,
      query.includeCatalogOnly,
    );
  }

  @Get(':slug/traits')
  @ApiOperation({ summary: 'List traits for a species (paginated)' })
  @ApiParam({ name: 'slug', example: 'elf' })
  @ApiOkResponse({ description: 'Paginated species traits' })
  @ApiNotFoundResponse({ description: 'Species not found' })
  findTraits(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findSpeciesTraits.execute(slug, query.cursor, query.limit);
  }

  @Get(':slug/trait-choices')
  @ApiOperation({ summary: 'List trait choice options for a species (paginated)' })
  @ApiParam({ name: 'slug', example: 'elf' })
  @ApiOkResponse({ description: 'Paginated trait choices (lineage, ancestry, etc.)' })
  @ApiNotFoundResponse({ description: 'Species not found or no choices' })
  findTraitChoices(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findSpeciesTraitChoices.execute(
      slug,
      query.cursor,
      query.limit,
      query.editionSlugs,
    );
  }

  @Get(':slug/effects')
  @ApiOperation({ summary: 'Typed catalog effects for a species' })
  @ApiParam({ name: 'slug', example: 'elf' })
  @ApiOkResponse({ type: [EffectSummaryResponseDto] })
  @ApiNotFoundResponse({ description: 'Species not found' })
  findEffects(
    @Param('slug') slug: string,
  ): Promise<EffectSummaryResponseDto[]> {
    return this.findOwnerEffects.execute('species', slug);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get species by slug' })
  @ApiParam({ name: 'slug', example: 'elf' })
  @ApiOkResponse({ type: SpeciesResponseDto })
  @ApiNotFoundResponse({ description: 'Species not found' })
  findOne(
    @Param('slug') slug: string,
    @Query() query: Pick<SpeciesQueryDto, 'editionSlugs'>,
  ): Promise<SpeciesResponseDto> {
    return this.findSpeciesBySlug.execute(slug, query.editionSlugs);
  }
}
