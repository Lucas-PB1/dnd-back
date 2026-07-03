import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { FindSpellsQuery } from './queries/find-spells.query';
import { FindSpellBySlugQuery } from './queries/find-spell-by-slug.query';
import { SpellResponseDto } from './dto/spell-response.dto';

@ApiTags('catalog-spells')
@Controller('spells')
export class SpellsController {
  constructor(
    private readonly findSpells: FindSpellsQuery,
    private readonly findSpellBySlug: FindSpellBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB spells (paginated)' })
  @ApiOkResponse({ description: 'Paginated spell list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.findSpells.execute(query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get spell by slug' })
  @ApiParam({ name: 'slug', example: 'alarme' })
  @ApiOkResponse({ type: SpellResponseDto })
  @ApiNotFoundResponse({ description: 'Spell not found' })
  findOne(@Param('slug') slug: string): Promise<SpellResponseDto> {
    return this.findSpellBySlug.execute(slug);
  }
}
