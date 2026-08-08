import { Controller, Get, Query } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { CombatMechanicalCatalogResponseDto } from './dto/combat-mechanical-catalog-response.dto';
import { CombatMechanicalQueryDto } from './dto/combat-mechanical-query.dto';
import { FindCombatMechanicalCatalogQuery } from './queries/find-combat-mechanical-catalog.query';

@ApiTags('catalog-combat-mechanical')
@Controller('combat-mechanical-catalog')
export class CombatMechanicalController {
  constructor(
    private readonly findCombatMechanicalCatalog: FindCombatMechanicalCatalogQuery,
  ) {}

  @Get()
  @ApiOperation({
    summary:
      'Catálogo mecânico de combate (Golpe Astuto, máscaras, precaução, manobras, …). Filtros opcionais por classe/subclasse.',
  })
  @ApiOkResponse({ type: CombatMechanicalCatalogResponseDto })
  findAll(
    @Query() query: CombatMechanicalQueryDto,
  ): Promise<CombatMechanicalCatalogResponseDto> {
    return this.findCombatMechanicalCatalog.execute({
      classSlug: query.classSlug,
      subclassSlug: query.subclassSlug,
    });
  }
}
