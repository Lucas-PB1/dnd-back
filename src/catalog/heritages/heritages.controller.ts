import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '@common/dto/pagination.dto';
import { HeritageQueryDto } from './dto/heritage-query.dto';
import { FindHeritagesQuery } from './queries/find-heritages.query';
import { FindHeritageBySlugQuery } from './queries/find-heritage-by-slug.query';
import { FindHeritageTraitsQuery } from './queries/find-heritage-traits.query';
import { FindHeritageTraitChoicesQuery } from './queries/find-heritage-trait-choices.query';
import { FindHeritageTraditionalBuildQuery } from './queries/find-heritage-traditional-build.query';
import { HeritageResponseDto } from './dto/heritage-response.dto';

@ApiTags('catalog-heritages')
@Controller('heritages')
export class HeritagesController {
  constructor(
    private readonly findHeritages: FindHeritagesQuery,
    private readonly findHeritageBySlug: FindHeritageBySlugQuery,
    private readonly findHeritageTraits: FindHeritageTraitsQuery,
    private readonly findHeritageTraitChoices: FindHeritageTraitChoicesQuery,
    private readonly findHeritageTraditionalBuild: FindHeritageTraditionalBuildQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB heritages (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated heritages list' })
  findAll(@Query() query: HeritageQueryDto) {
    return this.findHeritages.execute(
      query.cursor,
      query.limit,
      query.q,
      query.editionSlugs,
      query.fields,
      query.includeCatalogOnly,
    );
  }

  @Get(':slug/traits')
  @ApiOperation({ summary: 'List fixed identity traits for a heritage (paginated)' })
  @ApiParam({ name: 'slug', example: 'gh-dwarf' })
  @ApiOkResponse({ description: 'Paginated heritage traits' })
  @ApiNotFoundResponse({ description: 'Heritage not found' })
  findTraits(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findHeritageTraits.execute(slug, query.cursor, query.limit);
  }

  @Get(':slug/trait-choices')
  @ApiOperation({ summary: 'List modular trait choice options for a heritage (paginated)' })
  @ApiParam({ name: 'slug', example: 'gh-dwarf' })
  @ApiOkResponse({ description: 'Paginated trait choices (8 slots + optional speed/size)' })
  @ApiNotFoundResponse({ description: 'Heritage not found or no choices' })
  findTraitChoices(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findHeritageTraitChoices.execute(slug, query.cursor, query.limit);
  }

  @Get(':slug/traditional-build')
  @ApiOperation({ summary: 'Suggested traditional build (8 traits) for a heritage' })
  @ApiParam({ name: 'slug', example: 'gh-dwarf' })
  @ApiOkResponse({ description: 'Traditional trait picks in sort order' })
  @ApiNotFoundResponse({ description: 'Heritage not found' })
  findTraditionalBuild(
    @Param('slug') slug: string,
    @Query() query: PaginationQueryDto,
  ) {
    return this.findHeritageTraditionalBuild.execute(slug, query.cursor, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get heritage by slug' })
  @ApiParam({ name: 'slug', example: 'gh-dwarf' })
  @ApiOkResponse({ type: HeritageResponseDto })
  @ApiNotFoundResponse({ description: 'Heritage not found' })
  findOne(
    @Param('slug') slug: string,
    @Query() query: Pick<HeritageQueryDto, 'editionSlugs'>,
  ): Promise<HeritageResponseDto> {
    return this.findHeritageBySlug.execute(slug, query.editionSlugs);
  }
}
