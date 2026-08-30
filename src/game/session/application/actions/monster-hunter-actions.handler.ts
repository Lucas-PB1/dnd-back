import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isMonsterHunterClass } from '@game/combat/domain/monster-hunter/class';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  TableActionResponseDto,
  UseMonsterHunterTableActionDto,
} from '@game/session/dto';
import { resolveDeclaredEconomyTableAction } from '../core/resolve-declared-economy-table-action';

@Injectable()
export class MonsterHunterActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseMonsterHunterTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isMonsterHunterClass(character.classSlug)) {
      throw new BadRequestException(
        'Ação de Caçador de Monstros indisponível para esta classe',
      );
    }

    return resolveDeclaredEconomyTableAction(
      { state: this.state, mechanicalCatalog: this.mechanicalCatalog },
      character,
      dto.actionSlug,
    );
  }
}
