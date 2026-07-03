import { Controller, Get, Query } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { ReferenceService } from './reference.service';

@ApiTags('catalog-reference')
@Controller('character-levels')
export class CharacterLevelsController {
  constructor(private readonly referenceService: ReferenceService) {}

  @Get()
  @ApiOperation({ summary: 'Character level table — XP thresholds and proficiency bonus (paginated)' })
  @ApiOkResponse({ description: 'Paginated character level table' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.referenceService.findAllCharacterLevels(query.page, query.limit);
  }
}
