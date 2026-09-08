import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { SpellsQueryDto } from './dto/spells-query.dto';
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
  @ApiOperation({ summary: 'List PHB spells (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated spell list' })
  findAll(@Query() query: SpellsQueryDto) {
    return this.findSpells.execute({
      cursor: query.cursor,
      limit: query.limit,
      q: query.q,
      level: query.level,
      school: query.school,
      editionSlugs: query.editionSlugs,
      fields: query.fields,
      sangromancy: query.sangromancy,
      ritual: query.ritual,
      concentration: query.concentration,
      roll: query.roll,
      castingTime: query.castingTime,
      saveAbility: query.saveAbility,
      rangeKind: query.rangeKind,
    });
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
