import { Controller, Get } from '@nestjs/common';
import { ApiOkResponse, ApiOperation, ApiTags } from '@nestjs/swagger';
import { CatalogNamedLabelDto } from './dto/catalog-named-label.dto';
import { FeatCategoryResponseDto } from './dto/feat-category-response.dto';
import { ToolPoolResponseDto } from './dto/tool-pool-response.dto';
import { FindArmorCategoriesQuery } from './queries/find-armor-categories.query';
import { FindFeatCategoriesQuery } from './queries/find-feat-categories.query';
import { FindItemTypesQuery } from './queries/find-item-types.query';
import { FindSpellSchoolsQuery } from './queries/find-spell-schools.query';
import { FindToolPoolsQuery } from './queries/find-tool-pools.query';
import { FindWeaponCategoriesQuery } from './queries/find-weapon-categories.query';

@ApiTags('catalog-labels')
@Controller()
export class CatalogLabelsController {
  constructor(
    private readonly spellSchools: FindSpellSchoolsQuery,
    private readonly featCategories: FindFeatCategoriesQuery,
    private readonly weaponCategories: FindWeaponCategoriesQuery,
    private readonly armorCategories: FindArmorCategoriesQuery,
    private readonly itemTypes: FindItemTypesQuery,
    private readonly toolPools: FindToolPoolsQuery,
  ) {}

  @Get('spell-schools')
  @ApiOperation({ summary: 'PHB spell schools (slug + name)' })
  @ApiOkResponse({ type: [CatalogNamedLabelDto] })
  findSpellSchools(): Promise<CatalogNamedLabelDto[]> {
    return this.spellSchools.execute();
  }

  @Get('feat-categories')
  @ApiOperation({ summary: 'Feat category labels from v_phb_feat_category' })
  @ApiOkResponse({ type: [FeatCategoryResponseDto] })
  findFeatCategories(): Promise<FeatCategoryResponseDto[]> {
    return this.featCategories.execute();
  }

  @Get('weapon-categories')
  @ApiOperation({ summary: 'Weapon category labels (simple | martial | advanced)' })
  @ApiOkResponse({ type: [CatalogNamedLabelDto] })
  findWeaponCategories(): Promise<CatalogNamedLabelDto[]> {
    return this.weaponCategories.execute();
  }

  @Get('armor-categories')
  @ApiOperation({ summary: 'Armor category labels from phb_armor_category' })
  @ApiOkResponse({ type: [CatalogNamedLabelDto] })
  findArmorCategories(): Promise<CatalogNamedLabelDto[]> {
    return this.armorCategories.execute();
  }

  @Get('item-types')
  @ApiOperation({ summary: 'Item type labels (rpg.item_type)' })
  @ApiOkResponse({ type: [CatalogNamedLabelDto] })
  findItemTypes(): Promise<CatalogNamedLabelDto[]> {
    return this.itemTypes.execute();
  }

  @Get('tool-pools')
  @ApiOperation({
    summary: 'Instrument, gaming set and artisan tool variants for pickers',
  })
  @ApiOkResponse({ type: [ToolPoolResponseDto] })
  findToolPools(): Promise<ToolPoolResponseDto[]> {
    return this.toolPools.execute();
  }
}
