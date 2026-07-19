import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { FindConditionsQuery } from './queries/find-conditions.query';
import { ConditionResponseDto } from './dto/condition-response.dto';

@ApiTags('catalog-reference')
@Controller('conditions')
export class ConditionsController {
  constructor(private readonly findConditions: FindConditionsQuery) {}

  @Get()
  @ApiOperation({ summary: 'PHB conditions (slug EN + name PT)' })
  @ApiOkResponse({ type: [ConditionResponseDto] })
  findAll(): Promise<ConditionResponseDto[]> {
    return this.findConditions.execute();
  }
}
