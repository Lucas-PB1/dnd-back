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
      'Catálogo mecânico de combate. Filtros: classSlug, subclassSlug, featSlug, itemSlug, speciesSlug, threadSlug, heritageTraitSlug.',
  })
  @ApiOkResponse({ type: CombatMechanicalCatalogResponseDto })
  findAll(
    @Query() query: CombatMechanicalQueryDto,
  ): Promise<CombatMechanicalCatalogResponseDto> {
    return this.findCombatMechanicalCatalog.execute({
      classSlug: query.classSlug,
      subclassSlug: query.subclassSlug,
      featSlug: query.featSlug,
      itemSlug: query.itemSlug,
      speciesSlug: query.speciesSlug,
      threadSlug: query.threadSlug,
      heritageTraitSlug: query.heritageTraitSlug,
    });
  }
}
