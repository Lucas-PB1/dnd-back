import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { FightingStylesQueryDto } from './dto/fighting-styles-query.dto';
import { FightingStyleResponseDto } from './dto/fighting-style-response.dto';
import { FindFightingStylesQuery } from './queries/find-fighting-styles.query';
import { FindFightingStyleBySlugQuery } from './queries/find-fighting-style-by-slug.query';

@ApiTags('catalog-fighting-styles')
@Controller('fighting-styles')
export class FightingStylesController {
  constructor(
    private readonly findFightingStyles: FindFightingStylesQuery,
    private readonly findFightingStyleBySlug: FindFightingStyleBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({
    summary: 'List PHB fighting styles (paginated, optional class filter)',
  })
  @ApiOkResponse({ description: 'Paginated fighting style list' })
  findAll(@Query() query: FightingStylesQueryDto) {
    return this.findFightingStyles.execute(
      query.cursor,
      query.limit,
      query.class,
      query.q,
    );
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get fighting style by slug' })
  @ApiParam({ name: 'slug', example: 'dueling' })
  @ApiOkResponse({ type: FightingStyleResponseDto })
  @ApiNotFoundResponse({ description: 'Fighting style not found' })
  findOne(@Param('slug') slug: string): Promise<FightingStyleResponseDto> {
    return this.findFightingStyleBySlug.execute(slug);
  }
}
