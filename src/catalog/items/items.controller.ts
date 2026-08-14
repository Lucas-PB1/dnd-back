import {
  Controller,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import {
  ApiBearerAuth,
  ApiNoContentResponse,
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';
import { SupabaseAuthGuard } from '@identity/guards/supabase-auth.guard';
import { CatalogLookupService } from '@catalog/catalog-lookup.service';
import { ItemResponseDto } from './dto/item-response.dto';
import { ItemsQueryDto } from './dto/items-query.dto';
import { RecordItemCatalogStatsService } from './application/record-item-catalog-stats.service';
import { FindItemBySlugQuery } from './queries/find-item-by-slug.query';
import { FindItemsQuery } from './queries/find-items.query';
import { FindPopularItemsQuery } from './queries/find-popular-items.query';

@ApiTags('catalog-items')
@Controller('items')
export class ItemsController {
  constructor(
    private readonly findItems: FindItemsQuery,
    private readonly findItemBySlug: FindItemBySlugQuery,
    private readonly findPopular: FindPopularItemsQuery,
    private readonly catalogLookup: CatalogLookupService,
    private readonly catalogStats: RecordItemCatalogStatsService,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB items (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated item list' })
  findAll(@Query() query: ItemsQueryDto) {
    return this.findItems.execute(query.cursor, query.limit, query.q, {
      itemType: query.itemType,
      magic:
        query.magic === 'true' ? true : query.magic === 'false' ? false : undefined,
      rarity: query.rarity,
      editionSlugs: query.editionSlugs,
      fields: query.fields,
      hasCost:
        query.hasCost === 'true'
          ? true
          : query.hasCost === 'false'
            ? false
            : undefined,
      kind: query.kind,
      consumable:
        query.consumable === 'true'
          ? true
          : query.consumable === 'false'
            ? false
            : undefined,
      excludeCoverage:
        query.excludeCoverage === 'true'
          ? true
          : query.excludeCoverage === 'false'
            ? false
            : undefined,
      requiresAttunement:
        query.requiresAttunement === 'true'
          ? true
          : query.requiresAttunement === 'false'
            ? false
            : undefined,
      sort: query.sort,
    });
  }

  @Get('popular')
  @ApiOperation({ summary: 'Most purchased or viewed catalog items (tips)' })
  @ApiOkResponse({ description: 'Item summaries ordered by metric' })
  popular(
    @Query('metric') metric?: 'purchase' | 'view',
    @Query('limit') limitRaw?: string,
  ) {
    const limit = limitRaw ? Number.parseInt(limitRaw, 10) : 8;
    return this.findPopular.execute(
      metric === 'view' ? 'view' : 'purchase',
      Number.isFinite(limit) ? limit : 8,
    );
  }

  @Post(':slug/view')
  @HttpCode(HttpStatus.NO_CONTENT)
  @UseGuards(SupabaseAuthGuard)
  @ApiBearerAuth()
  @ApiUnauthorizedResponse({ description: 'Missing or invalid Bearer token' })
  @ApiOperation({ summary: 'Record a catalog item view (Beyond shop telemetry)' })
  @ApiNoContentResponse()
  @ApiNotFoundResponse()
  async recordView(@Param('slug') slug: string): Promise<void> {
    await this.catalogLookup.assertItemInCatalog(slug);
    await this.catalogStats.recordView(slug);
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
