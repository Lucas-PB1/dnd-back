import { Controller, Get, Query } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { ReferenceService } from './reference.service';

@ApiTags('catalog-reference')
@Controller('alignments')
export class AlignmentsController {
  constructor(private readonly referenceService: ReferenceService) {}

  @Get()
  @ApiOperation({ summary: 'List PHB alignments (paginated)' })
  @ApiOkResponse({ description: 'Paginated alignment list' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.referenceService.findAllAlignments(query.page, query.limit);
  }
}
