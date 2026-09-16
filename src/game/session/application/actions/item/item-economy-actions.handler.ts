import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DataSource, Repository } from 'typeorm';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { LoadEffectCatalog } from '@game/effects';
import { PlayerCharacterItem } from '@game/inventory/infrastructure/player-character-item.entity';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import { UseItemTableActionDto } from '@game/session/dto/table-actions/table-actions-item.dto';
import { applyItemEconomyTableAction } from '../../table-actions/item';

@Injectable()
export class ItemEconomyActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
    private readonly dataSource: DataSource,
    @InjectRepository(PlayerCharacterItem)
    private readonly items: Repository<PlayerCharacterItem>,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseItemTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return applyItemEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
        items: this.items,
        dataSource: this.dataSource,
      },
      character,
      dto.itemSlug,
      dto.actionSlug,
    );
  }
}
