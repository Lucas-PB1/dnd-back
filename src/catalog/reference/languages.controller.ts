import { Controller, Get, Query } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { ReferenceService } from './reference.service';

@ApiTags('catalog-reference')
@Controller('languages')
export class LanguagesController {
  constructor(private readonly referenceService: ReferenceService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB languages (paginated)' })
  @ApiOkResponse({ description: 'Paginated language list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.referenceService.findAllLanguages(query.page, query.limit);
  }
}
