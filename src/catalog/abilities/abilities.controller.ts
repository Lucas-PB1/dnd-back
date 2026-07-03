import { Controller, Get, Query } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { FindAbilitiesQuery } from './queries/find-abilities.query';

@ApiTags('catalog-abilities')
@Controller('abilities')
export class AbilitiesController {
  constructor(private readonly findAbilities: FindAbilitiesQuery) {}

  @Get()
  @ApiOperation({ summary: 'List PHB abilities (paginated)' })
  @ApiOkResponse({ description: 'Paginated ability list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.findAbilities.execute(query.page, query.limit);
  }
}
