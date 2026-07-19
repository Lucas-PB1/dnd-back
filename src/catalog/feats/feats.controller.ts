import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto, PaginatedResponseDto } from '../../common/dto/pagination.dto';
import { FeatsQueryDto } from './dto/feats-query.dto';
import { FindFeatsQuery } from './queries/find-feats.query';
import { FindFeatBySlugQuery } from './queries/find-feat-by-slug.query';
import { FindFeatOptionsQuery } from './queries/find-feat-options.query';
import { FeatResponseDto } from './dto/feat-response.dto';
import { FeatOptionResponseDto } from './dto/feat-option-response.dto';

@ApiTags('catalog-feats')
@Controller('feats')
export class FeatsController {
  constructor(
    private readonly findFeats: FindFeatsQuery,
    private readonly findFeatBySlug: FindFeatBySlugQuery,
    private readonly findFeatOptions: FindFeatOptionsQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB feats (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated feat list' })
  findAll(@Query() query: FeatsQueryDto) {
    return this.findFeats.execute(
      query.page,
      query.limit,
      query.q,
      query.category,
    );
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get feat by slug' })
  @ApiParam({ name: 'slug', example: 'alert' })
  @ApiOkResponse({ type: FeatResponseDto })
  @ApiNotFoundResponse({ description: 'Feat not found' })
  findOne(@Param('slug') slug: string): Promise<FeatResponseDto> {
    return this.findFeatBySlug.execute(slug);
  }

  @Get(':slug/options')
  @ApiOperation({ summary: 'Selectable internal options for a feat (paginated)' })
  @ApiParam({ name: 'slug', example: 'magic-initiate' })
  @ApiOkResponse({ description: 'Paginated feat option definitions' })
  @ApiNotFoundResponse({ description: 'Feat not found' })
  findOptions(
    @Param('slug') slug: string,
    @Query() query: PaginationQueryDto,
  ): Promise<PaginatedResponseDto<FeatOptionResponseDto>> {
    return this.findFeatOptions.execute(slug, query.page, query.limit);
  }
}
