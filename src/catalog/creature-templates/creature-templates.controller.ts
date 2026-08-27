import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { CreatureTemplateQueryDto } from './dto/creature-template-query.dto';
import {
  CreatureTemplateResponseDto,
} from './dto/creature-template-response.dto';
import {
  FindCreatureTemplateBySlugQuery,
  FindCreatureTemplatesQuery,
} from './queries/find-creature-templates.query';

@ApiTags('catalog-creature-templates')
@Controller('creature-templates')
export class CreatureTemplatesController {
  constructor(
    private readonly findTemplates: FindCreatureTemplatesQuery,
    private readonly findBySlug: FindCreatureTemplateBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List creature templates (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated creature templates' })
  findAll(@Query() query: CreatureTemplateQueryDto) {
    return this.findTemplates.execute(
      query.cursor,
      query.limit,
      query.q,
      query.editionSlugs,
      query.fields,
    );
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get creature template bundle by slug' })
  @ApiParam({ name: 'slug', example: 'primal-companion-earth' })
  @ApiOkResponse({ type: CreatureTemplateResponseDto })
  @ApiNotFoundResponse()
  findOne(@Param('slug') slug: string): Promise<CreatureTemplateResponseDto> {
    return this.findBySlug.execute(slug);
  }
}
