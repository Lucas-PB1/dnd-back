import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isPaladinClass } from '@game/combat/domain/paladin';
import { LoadEffectCatalog } from '@game/effects';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UsePaladinTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { applyDeclaredEconomyTableAction } from '../../table-actions/apply-declared-economy';

@Injectable()
export class PaladinActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UsePaladinTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isPaladinClass(character.classSlug)) {
      throw new BadRequestException('Paladin action is not available');
    }

    const amount =
      dto.amount ?? (dto.actionSlug === 'lay-on-hands' ? 1 : undefined);

    return applyDeclaredEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
      },
      character,
      dto.actionSlug,
      amount != null ? { amount } : {},
    ) as Promise<TableActionResponseDto>;
  }
}
