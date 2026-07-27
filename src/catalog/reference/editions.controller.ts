import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { FindEditionsQuery } from './queries/find-editions.query';
import { EditionResponseDto } from './dto/edition-response.dto';

@ApiTags('catalog-reference')
@Controller('editions')
export class EditionsController {
  constructor(private readonly findEditions: FindEditionsQuery) {}

  @Get()
  @ApiOperation({
    summary: 'List active rulebook editions (PHB 2024)',
  })
  @ApiOkResponse({ type: [EditionResponseDto] })
  findAll(): Promise<EditionResponseDto[]> {
    return this.findEditions.execute();
  }
}
