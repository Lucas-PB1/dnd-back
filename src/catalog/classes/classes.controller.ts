import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiQuery,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { ClassesService } from './classes.service';
import { ClassResponseDto } from './dto/class-response.dto';
import { ClassSpellsQueryDto } from './dto/class-spells-query.dto';

@ApiTags('catalog-classes')
@Controller('classes')
export class ClassesController {
  constructor(private readonly classesService: ClassesService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB classes (paginated)' })
  @ApiOkResponse({ description: 'Paginated class list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.classesService.findAll(query.page, query.limit);
  }

  @Get(':slug/subclasses')
  @ApiOperation({ summary: 'List subclasses for a PHB class (paginated)' })
  @ApiParam({ name: 'slug', example: 'fighter' })
  @ApiOkResponse({ description: 'Paginated subclass list' })
  @ApiNotFoundResponse({ description: 'Class not found' })
  findSubclasses(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.classesService.findSubclassesByClassSlug(slug, query.page, query.limit);
  }

  @Get(':slug/spells')
  @ApiOperation({ summary: 'List spells available to a class (paginated)' })
  @ApiParam({ name: 'slug', example: 'wizard' })
  @ApiQuery({ name: 'maxLevel', required: false, type: Number, description: 'Max spell circle (0–9)' })
  @ApiOkResponse({ description: 'Paginated class spell list' })
  @ApiNotFoundResponse({ description: 'Class not found' })
  findSpells(@Param('slug') slug: string, @Query() query: ClassSpellsQueryDto) {
    return this.classesService.findSpellsByClassSlug(slug, query.page, query.limit, query.maxLevel);
  }

  @Get(':slug/spell-slots')
  @ApiOperation({ summary: 'Spell slot progression by class level (paginated)' })
  @ApiParam({ name: 'slug', example: 'wizard' })
  @ApiOkResponse({ description: 'Paginated spell slot table' })
  @ApiNotFoundResponse({ description: 'Class not found or no spellcasting' })
  findSpellSlots(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.classesService.findSpellSlotsByClassSlug(slug, query.page, query.limit);
  }

  @Get(':slug/equipment')
  @ApiOperation({ summary: 'Starting equipment options for a class (paginated)' })
  @ApiParam({ name: 'slug', example: 'fighter' })
  @ApiOkResponse({ description: 'Paginated starting equipment list' })
  @ApiNotFoundResponse({ description: 'Class not found or no equipment data' })
  findEquipment(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.classesService.findEquipmentByClassSlug(slug, query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get class by slug' })
  @ApiParam({ name: 'slug', example: 'fighter' })
  @ApiOkResponse({ type: ClassResponseDto })
  @ApiNotFoundResponse({ description: 'Class not found' })
  findOne(@Param('slug') slug: string): Promise<ClassResponseDto> {
    return this.classesService.findBySlug(slug);
  }
}
