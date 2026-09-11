import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { LoadEffectCatalog } from '@game/effects';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseRogueTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { applyDeclaredEconomyTableAction } from '../../core/apply-declared-economy-table-action';
import { applyPsychicBladeTableAction } from '../../core/apply-psychic-blade-table-action';
import { assertCharacterSubclass } from '../../core/table-action-guards';

@Injectable()
export class RogueActionsHandler {
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
    dto: UseRogueTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (character.classSlug !== 'rogue') {
      throw new BadRequestException('Rogue action is not available');
    }

    if (dto.actionSlug.startsWith('psychic-')) {
      assertCharacterSubclass(character, 'soulknife', 'Soulknife');
    }

    if (dto.actionSlug === 'psychic-blade-main') {
      return applyPsychicBladeTableAction({
        state: this.state,
        character,
        getProficiencyBonus: (level) => this.domain.getProficiencyBonus(level),
        bonusAttack: false,
      });
    }
    if (dto.actionSlug === 'psychic-blade-bonus') {
      return applyPsychicBladeTableAction({
        state: this.state,
        character,
        getProficiencyBonus: (level) => this.domain.getProficiencyBonus(level),
        bonusAttack: true,
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
        checkTotal: dto.checkTotal,
        dc: dto.dc,
        usePsiDie: dto.usePsiDie,
      },
    );
  }
}
