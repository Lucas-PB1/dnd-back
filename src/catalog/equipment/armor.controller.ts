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
import { ArmorResponseDto } from './dto/armor-response.dto';

@ApiTags('catalog-armor')
@Controller('armor')
export class ArmorController {
  constructor(private readonly equipmentService: EquipmentService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB armor (paginated)' })
  @ApiOkResponse({ description: 'Paginated armor list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.equipmentService.findAllArmor(query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get armor by slug' })
  @ApiParam({ name: 'slug', example: 'leather-armor' })
  @ApiOkResponse({ type: ArmorResponseDto })
  @ApiNotFoundResponse({ description: 'Armor not found' })
  findOne(@Param('slug') slug: string): Promise<ArmorResponseDto> {
    return this.equipmentService.findArmorBySlug(slug);
  }
}
