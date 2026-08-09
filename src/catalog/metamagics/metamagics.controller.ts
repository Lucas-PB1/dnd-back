import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { MetamagicResponseDto } from './dto/metamagic-response.dto';
import { FindMetamagicsQuery } from './queries/find-metamagics.query';

@ApiTags('catalog-metamagics')
@Controller('metamagics')
export class MetamagicsController {
  constructor(private readonly findAll: FindMetamagicsQuery) {}

  @Get()
  @ApiOperation({ summary: 'List PHB Metamagic options (Sorcerer)' })
  @ApiOkResponse({ type: [MetamagicResponseDto] })
  list(): Promise<MetamagicResponseDto[]> {
    return this.findAll.execute();
  }
}
