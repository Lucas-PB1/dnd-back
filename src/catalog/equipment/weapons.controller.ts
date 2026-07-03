import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { EquipmentService } from './equipment.service';
import { WeaponResponseDto } from './dto/weapon-response.dto';

@ApiTags('catalog-weapons')
@Controller('weapons')
export class WeaponsController {
  constructor(private readonly equipmentService: EquipmentService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB weapons (paginated)' })
  @ApiOkResponse({ description: 'Paginated weapon list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.equipmentService.findAllWeapons(query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get weapon by slug' })
  @ApiParam({ name: 'slug', example: 'longsword' })
  @ApiOkResponse({ type: WeaponResponseDto })
  @ApiNotFoundResponse({ description: 'Weapon not found' })
  findOne(@Param('slug') slug: string): Promise<WeaponResponseDto> {
    return this.equipmentService.findWeaponBySlug(slug);
  }
}
