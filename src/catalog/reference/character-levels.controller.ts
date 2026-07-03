import { Controller, Get, Query } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { PaginationQueryDto } from '../../common/dto/pagination.dto';
import { FindCharacterLevelsQuery } from './queries/find-character-levels.query';

@ApiTags('catalog-reference')
@Controller('character-levels')
export class CharacterLevelsController {
  constructor(private readonly findCharacterLevels: FindCharacterLevelsQuery) {}

  @Get()
  @ApiOperation({ summary: 'Character level table — XP thresholds and proficiency bonus (paginated)' })
  @ApiOkResponse({ description: 'Paginated character level table' })
  findAll(@Query() query: PaginationQueryDto) {
    return this.findCharacterLevels.execute(query.page, query.limit);
  }
}
