import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { ArmorQueryDto } from './dto/armor-query.dto';
import { FindArmorQuery } from './queries/find-armor.query';
import { FindArmorBySlugQuery } from './queries/find-armor-by-slug.query';
import { ArmorResponseDto } from './dto/armor-response.dto';

@ApiTags('catalog-armor')
@Controller('armor')
export class ArmorController {
  constructor(
    private readonly findArmor: FindArmorQuery,
    private readonly findArmorBySlug: FindArmorBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB armor (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated armor list' })
  findAll(@Query() query: ArmorQueryDto) {
    return this.findArmor.execute(
      query.page,
      query.limit,
      query.q,
      query.category,
    );
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get armor by slug' })
  @ApiParam({ name: 'slug', example: 'leather-armor' })
  @ApiOkResponse({ type: ArmorResponseDto })
  @ApiNotFoundResponse({ description: 'Armor not found' })
  findOne(@Param('slug') slug: string): Promise<ArmorResponseDto> {
    return this.findArmorBySlug.execute(slug);
  }
}
