import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { SubclassesQueryDto } from './dto/subclasses-query.dto';
import { FindSubclassesQuery } from './queries/find-subclasses.query';
import { FindSubclassBySlugQuery } from './queries/find-subclass-by-slug.query';
import { FindSubclassMechanicsQuery } from './queries/find-subclass-mechanics.query';
import { FindSubclassOptionsQuery } from './queries/find-subclass-options.query';
import { FindSubclassSpellsQuery } from './queries/find-subclass-spells.query';
import { FindSubclassSpellSlotsQuery } from './queries/find-subclass-spell-slots.query';
import { FindSubclassSpellcastingQuery } from './queries/find-subclass-spellcasting.query';
import { SubclassResponseDto } from './dto/subclass-response.dto';
import { SubclassSpellcastingResponseDto } from './dto/subclass-spellcasting-response.dto';

@ApiTags('catalog-subclasses')
@Controller('subclasses')
export class SubclassesController {
  constructor(
    private readonly findSubclasses: FindSubclassesQuery,
    private readonly findSubclassBySlug: FindSubclassBySlugQuery,
    private readonly findSubclassMechanics: FindSubclassMechanicsQuery,
    private readonly findSubclassOptions: FindSubclassOptionsQuery,
    private readonly findSubclassSpells: FindSubclassSpellsQuery,
    private readonly findSubclassSpellSlots: FindSubclassSpellSlotsQuery,
    private readonly findSubclassSpellcasting: FindSubclassSpellcastingQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB subclasses (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated subclass list' })
  findAll(@Query() query: SubclassesQueryDto) {
    return this.findSubclasses.execute(
      query.page,
      query.limit,
      query.q,
      query.class,
      query.editionSlugs,
    );
  }

  @Get(':slug/options')
  @ApiOperation({ summary: 'Selectable subclass options by character level (paginated)' })
  @ApiParam({ name: 'slug', example: 'battle-master' })
  @ApiOkResponse({ description: 'Paginated subclass option groups with values' })
  @ApiNotFoundResponse({ description: 'Subclass not found or no options at this level' })
  findOptions(
    @Param('slug') slug: string,
    @Query() query: PaginationQueryDto & { level?: number },
  ) {
    const level = query.level !== undefined ? Number(query.level) : 20;
    return this.findSubclassOptions.execute(slug, level, query.page, query.limit);
  }

  @Get(':slug/mechanics')
  @ApiOperation({ summary: 'Subclass features and resources (paginated)' })
  @ApiParam({ name: 'slug', example: 'champion' })
  @ApiOkResponse({ description: 'Paginated subclass mechanics list' })
  @ApiNotFoundResponse({ description: 'Subclass not found or no mechanics data' })
  findMechanics(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findSubclassMechanics.execute(slug, query.page, query.limit);
  }

  @Get(':slug/spells')
  @ApiOperation({ summary: 'Prepared spells granted by subclass (paginated)' })
  @ApiParam({ name: 'slug', example: 'life' })
  @ApiOkResponse({ description: 'Paginated subclass spell list' })
  @ApiNotFoundResponse({ description: 'Subclass not found or no prepared spells' })
  findSpells(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findSubclassSpells.execute(slug, query.page, query.limit);
  }

  @Get(':slug/spell-slots')
  @ApiOperation({ summary: 'Spell slot progression for a casting subclass' })
  @ApiParam({ name: 'slug', example: 'spellslinger' })
  @ApiOkResponse({ description: 'Paginated subclass spell slot table' })
  @ApiNotFoundResponse({ description: 'Subclass not found or no spellcasting slots' })
  findSpellSlots(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findSubclassSpellSlots.execute(slug, query.page, query.limit);
  }

  @Get(':slug/spellcasting')
  @ApiOperation({ summary: 'Subclass spellcasting profile (list class, ability, mode)' })
  @ApiParam({ name: 'slug', example: 'spellslinger' })
  @ApiOkResponse({ type: SubclassSpellcastingResponseDto })
  @ApiNotFoundResponse({ description: 'Subclass not found or no spellcasting' })
  findSpellcasting(
    @Param('slug') slug: string,
  ): Promise<SubclassSpellcastingResponseDto> {
    return this.findSubclassSpellcasting.execute(slug);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get subclass by slug' })
  @ApiParam({ name: 'slug', example: 'champion' })
  @ApiOkResponse({ type: SubclassResponseDto })
  @ApiNotFoundResponse({ description: 'Subclass not found' })
  findOne(@Param('slug') slug: string): Promise<SubclassResponseDto> {
    return this.findSubclassBySlug.execute(slug);
  }
}
