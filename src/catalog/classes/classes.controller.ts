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
import { FindClassesQuery } from './queries/find-classes.query';
import { FindClassBySlugQuery } from './queries/find-class-by-slug.query';
import { FindClassSubclassesQuery } from './queries/find-class-subclasses.query';
import { FindClassSpellsQuery } from './queries/find-class-spells.query';
import { FindClassSpellSlotsQuery } from './queries/find-class-spell-slots.query';
import { FindClassEquipmentQuery } from './queries/find-class-equipment.query';
import { FindClassSkillsQuery } from './queries/find-class-skills.query';
import { FindClassFeaturesQuery } from './queries/find-class-features.query';
import { ClassResponseDto } from './dto/class-response.dto';
import { ClassSpellsQueryDto } from './dto/class-spells-query.dto';
import { ClassFeaturesQueryDto } from './dto/class-features-query.dto';

@ApiTags('catalog-classes')
@Controller('classes')
export class ClassesController {
  constructor(
    private readonly findClasses: FindClassesQuery,
    private readonly findClassBySlug: FindClassBySlugQuery,
    private readonly findClassSubclasses: FindClassSubclassesQuery,
    private readonly findClassSpells: FindClassSpellsQuery,
    private readonly findClassSpellSlots: FindClassSpellSlotsQuery,
    private readonly findClassEquipment: FindClassEquipmentQuery,
    private readonly findClassSkills: FindClassSkillsQuery,
    private readonly findClassFeatures: FindClassFeaturesQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB classes (paginated)' })
  @ApiOkResponse({ description: 'Paginated class list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.findClasses.execute(query.page, query.limit);
  }

  @Get(':slug/subclasses')
  @ApiOperation({ summary: 'List subclasses for a PHB class (paginated)' })
  @ApiParam({ name: 'slug', example: 'fighter' })
  @ApiOkResponse({ description: 'Paginated subclass list' })
  @ApiNotFoundResponse({ description: 'Class not found' })
  findSubclasses(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findClassSubclasses.execute(slug, query.page, query.limit);
  }

  @Get(':slug/spells')
  @ApiOperation({ summary: 'List spells available to a class (paginated)' })
  @ApiParam({ name: 'slug', example: 'wizard' })
  @ApiQuery({ name: 'maxLevel', required: false, type: Number, description: 'Max spell circle (0–9)' })
  @ApiOkResponse({ description: 'Paginated class spell list' })
  @ApiNotFoundResponse({ description: 'Class not found' })
  findSpells(@Param('slug') slug: string, @Query() query: ClassSpellsQueryDto) {
    return this.findClassSpells.execute(slug, query.page, query.limit, query.maxLevel);
  }

  @Get(':slug/spell-slots')
  @ApiOperation({ summary: 'Spell slot progression by class level (paginated)' })
  @ApiParam({ name: 'slug', example: 'wizard' })
  @ApiOkResponse({ description: 'Paginated spell slot table' })
  @ApiNotFoundResponse({ description: 'Class not found or no spellcasting' })
  findSpellSlots(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findClassSpellSlots.execute(slug, query.page, query.limit);
  }

  @Get(':slug/equipment')
  @ApiOperation({ summary: 'Starting equipment options for a class (paginated)' })
  @ApiParam({ name: 'slug', example: 'fighter' })
  @ApiOkResponse({ description: 'Paginated starting equipment list' })
  @ApiNotFoundResponse({ description: 'Class not found or no equipment data' })
  findEquipment(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findClassEquipment.execute(slug, query.page, query.limit);
  }

  @Get(':slug/skills')
  @ApiOperation({ summary: 'Skill pool available to a class (paginated)' })
  @ApiParam({ name: 'slug', example: 'fighter' })
  @ApiOkResponse({ description: 'Paginated class skill list' })
  @ApiNotFoundResponse({ description: 'Class not found or no skill pool' })
  findSkills(@Param('slug') slug: string, @Query() query: PaginationQueryDto) {
    return this.findClassSkills.execute(slug, query.page, query.limit);
  }

  @Get(':slug/features')
  @ApiOperation({ summary: 'Class features by level (paginated)' })
  @ApiParam({ name: 'slug', example: 'bard' })
  @ApiQuery({ name: 'maxLevel', required: false, type: Number, description: 'Max class level (1–20)' })
  @ApiOkResponse({ description: 'Paginated class feature list' })
  @ApiNotFoundResponse({ description: 'Class not found or no features data' })
  findFeatures(@Param('slug') slug: string, @Query() query: ClassFeaturesQueryDto) {
    return this.findClassFeatures.execute(slug, query.page, query.limit, query.maxLevel);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get class by slug' })
  @ApiParam({ name: 'slug', example: 'fighter' })
  @ApiOkResponse({ type: ClassResponseDto })
  @ApiNotFoundResponse({ description: 'Class not found' })
  findOne(@Param('slug') slug: string): Promise<ClassResponseDto> {
    return this.findClassBySlug.execute(slug);
  }
}
