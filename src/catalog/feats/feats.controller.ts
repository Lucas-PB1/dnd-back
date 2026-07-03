import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { FeatsService } from './feats.service';
import { FeatResponseDto } from './dto/feat-response.dto';

@ApiTags('catalog-feats')
@Controller('feats')
export class FeatsController {
  constructor(private readonly featsService: FeatsService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB feats (paginated)' })
  @ApiOkResponse({ description: 'Paginated feat list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.featsService.findAll(query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get feat by slug' })
  @ApiParam({ name: 'slug', example: 'alert' })
  @ApiOkResponse({ type: FeatResponseDto })
  @ApiNotFoundResponse({ description: 'Feat not found' })
  findOne(@Param('slug') slug: string): Promise<FeatResponseDto> {
    return this.featsService.findBySlug(slug);
  }
}
