import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { ItemResponseDto } from './dto/item-response.dto';
import { ItemsQueryDto } from './dto/items-query.dto';
import { FindItemBySlugQuery } from './queries/find-item-by-slug.query';
import { FindItemsQuery } from './queries/find-items.query';

@ApiTags('catalog-items')
@Controller('items')
export class ItemsController {
  constructor(
    private readonly findItems: FindItemsQuery,
    private readonly findItemBySlug: FindItemBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB items (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated item list' })
  findAll(@Query() query: ItemsQueryDto) {
    return this.findItems.execute(query.page, query.limit, query.q, query.itemType);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get item by slug' })
  @ApiParam({ name: 'slug', example: 'longsword' })
  @ApiOkResponse({ type: ItemResponseDto })
  @ApiNotFoundResponse({ description: 'Item not found' })
  findOne(@Param('slug') slug: string): Promise<ItemResponseDto> {
    return this.findItemBySlug.execute(slug);
  }
}
