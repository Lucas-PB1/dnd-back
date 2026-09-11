import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isDruidClass } from '@game/combat/domain/druid';
import { LoadEffectCatalog } from '@game/effects';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseDruidTableActionDto,
} from '@game/session/dto/table-actions/table-actions-caster.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { applyDeclaredEconomyTableAction } from '../../core/apply-declared-economy-table-action';
import {
  applyMoonCombatWildShapeTableAction,
  applyRestoreLunarStepTableAction,
} from '../../core/apply-wild-resurgence-table-action';

@Injectable()
export class DruidActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseDruidTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isDruidClass(character.classSlug)) {
      throw new BadRequestException('Druid action is not available');
    }

    if (dto.actionSlug === 'moon-combat-wild-shape') {
      return applyMoonCombatWildShapeTableAction({
        state: this.state,
        character,
      });
    }
    if (dto.actionSlug === 'restore-lunar-step') {
      return applyRestoreLunarStepTableAction({
        state: this.state,
        character,
        slotLevel: dto.slotLevel,
      });
    }

    return applyDeclaredEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
        getProficiencyBonus: (level) => this.domain.getProficiencyBonus(level),
      },
      character,
      dto.actionSlug,
      {
        slotLevel: dto.slotLevel,
      },
    );
  }
}
