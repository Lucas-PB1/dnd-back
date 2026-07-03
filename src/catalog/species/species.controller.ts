import { Controller, Get, Param, Query } from '@nestjs/common';
import {
  ApiNotFoundResponse,
  ApiOkResponse,
  ApiOperation,
  ApiParam,
  ApiTags,
} from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { SpeciesService } from './species.service';
import { SpeciesResponseDto } from './dto/species-response.dto';

@ApiTags('catalog-species')
@Controller('species')
export class SpeciesController {
  constructor(private readonly speciesService: SpeciesService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB species (paginated)' })
  @ApiOkResponse({ description: 'Paginated species list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.speciesService.findAll(query.page, query.limit);
  }

  @Get(':slug')
  @ApiOperation({ summary: 'Get species by slug' })
  @ApiParam({ name: 'slug', example: 'elf' })
  @ApiOkResponse({ type: SpeciesResponseDto })
  @ApiNotFoundResponse({ description: 'Species not found' })
  findOne(@Param('slug') slug: string): Promise<SpeciesResponseDto> {
    return this.speciesService.findBySlug(slug);
  }
}
