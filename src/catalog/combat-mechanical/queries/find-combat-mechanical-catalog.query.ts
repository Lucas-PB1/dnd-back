import { Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '../../../game/combat/application/load-combat-mechanical-catalog';
import { CombatMechanicalCatalogResponseDto } from '../dto/combat-mechanical-catalog-response.dto';
import {
  filterCombatMechanicalCatalog,
  type CombatMechanicalCatalogFilters,
} from './filter-combat-mechanical-catalog';

@Injectable()
export class FindCombatMechanicalCatalogQuery {
  constructor(
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  async execute(
    filters: CombatMechanicalCatalogFilters = {},
  ): Promise<CombatMechanicalCatalogResponseDto> {
    const catalog = await this.mechanicalCatalog.load();

    const dto: CombatMechanicalCatalogResponseDto = {
      gunslingerManeuvers: catalog.gunslingerManeuvers,
      battleMasterManeuvers: catalog.battleMasterManeuvers,
      cunningStrikeEffects: catalog.cunningStrikeEffects.map((effect) => ({
        slug: effect.slug,
        name: effect.name,
        cost: effect.cost,
        unlockLevel: effect.unlockLevel,
        saveAbility: effect.saveAbility,
        subclassSlug: effect.subclassSlug,
        note: effect.note,
      })),
      tableActions: catalog.tableActions,
      personaMasks: catalog.personaMasks,
      beastborneAspectBenefits: catalog.beastborneAspectBenefits,
      dungeoneerSlayerLabels: catalog.dungeoneerSlayerLabels,
      precautionSpells: catalog.precautionSpells,
      economyActions: catalog.economyActions,
      panelActions: catalog.panelActions,
    };

    return filterCombatMechanicalCatalog(dto, filters);
  }
}
