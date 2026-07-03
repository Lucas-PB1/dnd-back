import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { BackgroundsService } from './backgrounds.service';
import { BackgroundResponseDto } from './dto/background-response.dto';

@ApiTags('catalog-backgrounds')
@Controller('backgrounds')
export class BackgroundsController {
  constructor(private readonly backgroundsService: BackgroundsService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB backgrounds (paginated)' })
  @ApiOkResponse({ description: 'Paginated backgrounds list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.backgroundsService.findAll(query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get background by slug' })
  @ApiParam({ name: 'slug', example: 'acolyte' })
  @ApiOkResponse({ type: BackgroundResponseDto })
  @ApiNotFoundResponse({ description: 'Background not found' })
  findOne(@Param('slug') slug: string): Promise<BackgroundResponseDto> {
    return this.backgroundsService.findBySlug(slug);
  }
}
