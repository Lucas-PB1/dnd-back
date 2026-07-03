import { Controller, Get, Query } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { AbilitiesService } from './abilities.service';

@ApiTags('catalog-abilities')
@Controller('abilities')
export class AbilitiesController {
  constructor(private readonly abilitiesService: AbilitiesService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB abilities (paginated)' })
  @ApiOkResponse({ description: 'Paginated ability list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.abilitiesService.findAll(query.page, query.limit);
  }
}
