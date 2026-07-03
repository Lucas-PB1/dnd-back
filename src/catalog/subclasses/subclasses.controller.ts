import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { FindSubclassBySlugQuery } from './queries/find-subclass-by-slug.query';
import { FindSubclassMechanicsQuery } from './queries/find-subclass-mechanics.query';
import { FindSubclassSpellsQuery } from './queries/find-subclass-spells.query';
import { SubclassResponseDto } from './dto/subclass-response.dto';

@ApiTags('catalog-subclasses')
@Controller('subclasses')
export class SubclassesController {
  constructor(
    private readonly findSubclassBySlug: FindSubclassBySlugQuery,
    private readonly findSubclassMechanics: FindSubclassMechanicsQuery,
    private readonly findSubclassSpells: FindSubclassSpellsQuery,
  ) {}

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

  @Get(':slug')
  @ApiOperation({ summary: 'Get subclass by slug' })
  @ApiParam({ name: 'slug', example: 'champion' })
  @ApiOkResponse({ type: SubclassResponseDto })
  @ApiNotFoundResponse({ description: 'Subclass not found' })
  findOne(@Param('slug') slug: string): Promise<SubclassResponseDto> {
    return this.findSubclassBySlug.execute(slug);
  }
}
