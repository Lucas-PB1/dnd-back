import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { WeaponsQueryDto } from './dto/weapons-query.dto';
import { FindWeaponsQuery } from './queries/find-weapons.query';
import { FindWeaponBySlugQuery } from './queries/find-weapon-by-slug.query';
import { WeaponResponseDto } from './dto/weapon-response.dto';

@ApiTags('catalog-weapons')
@Controller('weapons')
export class WeaponsController {
  constructor(
    private readonly findWeapons: FindWeaponsQuery,
    private readonly findWeaponBySlug: FindWeaponBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB weapons (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated weapon list' })
  findAll(@Query() query: WeaponsQueryDto) {
    return this.findWeapons.execute(
      query.page,
      query.limit,
      query.q,
      query.category,
    );
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get weapon by slug' })
  @ApiParam({ name: 'slug', example: 'longsword' })
  @ApiOkResponse({ type: WeaponResponseDto })
  @ApiNotFoundResponse({ description: 'Weapon not found' })
  findOne(@Param('slug') slug: string): Promise<WeaponResponseDto> {
    return this.findWeaponBySlug.execute(slug);
  }
}
