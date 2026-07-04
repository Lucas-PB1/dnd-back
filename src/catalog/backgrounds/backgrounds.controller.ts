import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { FindBackgroundsQuery } from './queries/find-backgrounds.query';
import { FindBackgroundBySlugQuery } from './queries/find-background-by-slug.query';
import { FindBackgroundEquipmentQuery } from './queries/find-background-equipment.query';
import { FindBackgroundSkillsQuery } from './queries/find-background-skills.query';
import { FindBackgroundToolsQuery } from './queries/find-background-tools.query';
import { BackgroundResponseDto } from './dto/background-response.dto';

@ApiTags('catalog-backgrounds')
@Controller('backgrounds')
export class BackgroundsController {
  constructor(
    private readonly findBackgrounds: FindBackgroundsQuery,
    private readonly findBackgroundBySlug: FindBackgroundBySlugQuery,
    private readonly findBackgroundEquipment: FindBackgroundEquipmentQuery,
    private readonly findBackgroundSkills: FindBackgroundSkillsQuery,
    private readonly findBackgroundTools: FindBackgroundToolsQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB backgrounds (paginated)' })
  @ApiOkResponse({ description: 'Paginated backgrounds list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.findBackgrounds.execute(query.page, query.limit);
  }

  @Get(':slug/equipment')
  @ApiOperation({ summary: 'Starting equipment for a background (paginated)' })
  @ApiParam({ name: 'slug', example: 'acolyte' })
  @ApiOkResponse({ description: 'Paginated starting equipment list' })
  @ApiNotFoundResponse({ description: 'Background not found or no equipment data' })
  findEquipment(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findBackgroundEquipment.execute(slug, query.page, query.limit);
  }

  @Get(':slug/skills')
  @ApiOperation({ summary: 'Fixed proficient skills granted by a background (paginated)' })
  @ApiParam({ name: 'slug', example: 'acolyte' })
  @ApiOkResponse({ description: 'Paginated background skills list' })
  @ApiNotFoundResponse({ description: 'Background not found or no skills data' })
  findSkills(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findBackgroundSkills.execute(slug, query.page, query.limit);
  }

  @Get(':slug/tools')
  @ApiOperation({ summary: 'Tool proficiency options for a background (paginated)' })
  @ApiParam({ name: 'slug', example: 'artisan' })
  @ApiOkResponse({ description: 'Paginated tool choice list' })
  @ApiNotFoundResponse({ description: 'Background not found or no tool choices' })
  findTools(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findBackgroundTools.execute(slug, query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get background by slug' })
  @ApiParam({ name: 'slug', example: 'acolyte' })
  @ApiOkResponse({ type: BackgroundResponseDto })
  @ApiNotFoundResponse({ description: 'Background not found' })
  findOne(@Param('slug') slug: string): Promise<BackgroundResponseDto> {
    return this.findBackgroundBySlug.execute(slug);
  }
}
