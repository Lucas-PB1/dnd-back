import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { SkillsQueryDto } from './dto/skills-query.dto';
import { FindSkillsQuery } from './queries/find-skills.query';
import { FindSkillBySlugQuery } from './queries/find-skill-by-slug.query';
import { SkillResponseDto } from './dto/skill-response.dto';

@ApiTags('catalog-skills')
@Controller('skills')
export class SkillsController {
  constructor(
    private readonly findSkills: FindSkillsQuery,
    private readonly findSkillBySlug: FindSkillBySlugQuery,
  ) {}

  @Get()
  @ApiOperation({ summary: 'List PHB skills (paginated, searchable)' })
  @ApiOkResponse({ description: 'Paginated skill list' })
  findAll(@Query() query: SkillsQueryDto) {
    return this.findSkills.execute(
      query.page,
      query.limit,
      query.q,
      query.ability,
    );
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get skill by slug' })
  @ApiParam({ name: 'slug', example: 'atletismo' })
  @ApiOkResponse({ type: SkillResponseDto })
  @ApiNotFoundResponse({ description: 'Skill not found' })
  findOne(@Param('slug') slug: string): Promise<SkillResponseDto> {
    return this.findSkillBySlug.execute(slug);
  }
}
