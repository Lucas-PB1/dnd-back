import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { VehicleTemplateQueryDto } from './dto/vehicle-template-query.dto';
import { VehicleTemplateResponseDto } from './dto/vehicle-template-response.dto';
import {
  FindVehicleTemplateBySlugQuery,
  FindVehicleTemplatesQuery,
} from './queries/find-vehicle-templates.query';

@ApiTags('catalog-vehicle-templates')
@Controller('vehicle-templates')
export class VehicleTemplatesController {
  constructor(
    private readonly findTemplates: FindVehicleTemplatesQuery,
    private readonly findBySlug: FindVehicleTemplateBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List vehicle templates (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated vehicle templates' })
  findAll(@Query() query: VehicleTemplateQueryDto) {
    return this.findTemplates.execute(
      query.cursor,
      query.limit,
      query.q,
      query.editionSlugs,
      query.fields,
    );
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get vehicle template bundle by slug' })
  @ApiParam({ name: 'slug', example: 'rowboat' })
  @ApiOkResponse({ type: VehicleTemplateResponseDto })
  @ApiNotFoundResponse()
  findOne(@Param('slug') slug: string): Promise<VehicleTemplateResponseDto> {
    return this.findBySlug.execute(slug);
  }
}
