import { BadRequestException, Injectable } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isSorcererClass } from '@game/combat/domain/sorcerer';
import { LoadEffectCatalog } from '@game/effects';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseSorcererTableActionDto,
} from '@game/session/dto/table-actions/table-actions-caster.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { applyDeclaredEconomyTableAction } from '../../table-actions/apply-declared-economy';

@Injectable()
export class SorcererActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly dataSource: DataSource,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
  ) {}

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseSorcererTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isSorcererClass(character.classSlug)) {
      throw new BadRequestException('Sorcerer action is not available');
    }

    return applyDeclaredEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
        dataSource: this.dataSource,
        getProficiencyBonus: (level) => this.domain.getProficiencyBonus(level),
      },
      character,
      dto.actionSlug,
      {
        metamagicSlug: dto.metamagicSlug,
        amount: dto.pointsSpent ?? dto.amount,
      },
    ) as Promise<TableActionResponseDto>;
  }
}
