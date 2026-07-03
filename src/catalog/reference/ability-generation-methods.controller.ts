import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { FindAbilityGenerationMethodsQuery } from './queries/find-ability-generation-methods.query';
import { AbilityGenerationMethodResponseDto } from './dto/ability-generation-method-response.dto';

@ApiTags('catalog-reference')
@Controller('ability-generation-methods')
export class AbilityGenerationMethodsController {
  constructor(private readonly findMethods: FindAbilityGenerationMethodsQuery) {}

  @Get()
  @ApiOperation({ summary: 'PHB ability score generation methods' })
  @ApiOkResponse({ type: [AbilityGenerationMethodResponseDto] })
  findAll(): Promise<AbilityGenerationMethodResponseDto[]> {
    return this.findMethods.execute();
  }
}
