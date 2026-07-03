import { Controller, Get, Query } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { FindLanguagesQuery } from './queries/find-languages.query';

@ApiTags('catalog-reference')
@Controller('languages')
export class LanguagesController {
  constructor(private readonly findLanguages: FindLanguagesQuery) {}

  @Get()
  @ApiOperation({ summary: 'List PHB languages (paginated)' })
  @ApiOkResponse({ description: 'Paginated language list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.findLanguages.execute(query.page, query.limit);
  }
}
