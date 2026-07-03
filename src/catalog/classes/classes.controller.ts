import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { ClassesService } from './classes.service';
import { ClassResponseDto } from './dto/class-response.dto';

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

  @Get(':slug')
  @ApiOperation({ summary: 'Get class by slug' })
  @ApiParam({ name: 'slug', example: 'fighter' })
  @ApiOkResponse({ type: ClassResponseDto })
  @ApiNotFoundResponse({ description: 'Class not found' })
  findOne(@Param('slug') slug: string): Promise<ClassResponseDto> {
    return this.classesService.findBySlug(slug);
  }
}
