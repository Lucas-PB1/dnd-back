import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isRangerClass } from '@game/combat/domain/ranger';
import { LoadEffectCatalog } from '@game/effects';
import { SyncCharacterCompanionHandler } from '@game/actor/application/sync-character-companion.handler';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseRangerTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { applyDeclaredEconomyTableAction } from '../../core/apply-declared-economy-table-action';

@Injectable()
export class RangerActionsHandler {
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
    dto: UseRangerTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isRangerClass(character.classSlug)) {
      throw new BadRequestException('Ranger action is not available');
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
        companionCommand: dto.companionCommand,
        level: dto.level,
      },
    );
  }
}
