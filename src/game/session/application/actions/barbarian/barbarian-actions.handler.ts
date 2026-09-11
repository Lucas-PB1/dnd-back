import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { LoadEffectCatalog } from '@game/effects';
import { isBarbarianClass } from '@game/combat/domain/barbarian';
import { SyncCharacterCompanionHandler } from '@game/actor/application/sync-character-companion.handler';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseBarbarianTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { applyDeclaredEconomyTableAction } from '../../core/apply-declared-economy-table-action';

@Injectable()
export class BarbarianActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
    private readonly syncCompanion: SyncCharacterCompanionHandler,
    @InjectDataSource()
    private readonly dataSource: DataSource,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseBarbarianTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isBarbarianClass(character.classSlug)) {
      throw new BadRequestException('Barbarian action is not available');
    }

    return applyDeclaredEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
        companion: {
          dataSource: this.dataSource,
          syncCompanion: this.syncCompanion,
        },
      },
      character,
      dto.actionSlug,
      {
        userId,
        diceCount: dto.diceCount,
        companionCommand: dto.companionCommand,
      },
    );
  }
}
