import { Controller, Get, Query } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { EldritchInvocationResponseDto } from './dto/eldritch-invocation-response.dto';
import { EldritchInvocationsQueryDto } from './dto/eldritch-invocations-query.dto';
import { FindEldritchInvocationsQuery } from './queries/find-eldritch-invocations.query';

@ApiTags('catalog-eldritch-invocations')
@Controller('eldritch-invocations')
export class EldritchInvocationsController {
  constructor(private readonly findAll: FindEldritchInvocationsQuery) {}

  @Get()
  @ApiOperation({ summary: 'List PHB Eldritch Invocations (Warlock)' })
  @ApiOkResponse({ type: [EldritchInvocationResponseDto] })
  list(
    @Query() query: EldritchInvocationsQueryDto,
  ): Promise<EldritchInvocationResponseDto[]> {
    return this.findAll.execute(query.maxMinLevel);
  }
}
