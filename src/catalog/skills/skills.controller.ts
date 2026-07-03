import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { SkillsService } from './skills.service';
import { SkillResponseDto } from './dto/skill-response.dto';

@ApiTags('catalog-skills')
@Controller('skills')
export class SkillsController {
  constructor(private readonly skillsService: SkillsService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB skills (paginated)' })
  @ApiOkResponse({ description: 'Paginated skill list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.skillsService.findAll(query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get skill by slug' })
  @ApiParam({ name: 'slug', example: 'atletismo' })
  @ApiOkResponse({ type: SkillResponseDto })
  @ApiNotFoundResponse({ description: 'Skill not found' })
  findOne(@Param('slug') slug: string): Promise<SkillResponseDto> {
    return this.skillsService.findBySlug(slug);
  }
}
