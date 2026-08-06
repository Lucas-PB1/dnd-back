import { Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '../../../combat/application/load-combat-mechanical-catalog';
import { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '../../../sheet/infrastructure/character-sheet.repository';
import { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import { CharacterStateRepository } from '../../infrastructure/character-state.repository';
import type {
  ActionSurgeResponseDto,
  FighterTableActionResponseDto,
  SecondWindResponseDto,
  TacticalMindDto,
  TacticalMindResponseDto,
  UseBattleMasterManeuverDto,
  UseDungeonPrecautionDto,
  UsePsiWarriorActionDto,
} from '../../dto/character-state.dto';
import type { FighterActionDeps } from './fighter/fighter-action-deps';
import {
  useActionSurgeAction,
  useSecondWindAction,
  useTacticalMindAction,
} from './fighter/core-actions';
import {
  listBattleMasterManeuversAction,
  useBattleMasterManeuverAction,
} from './fighter/battle-master-actions';
import { useDungeonPrecautionAction } from './fighter/dungeoneer-actions';
import { usePsiWarriorAction } from './fighter/psi-warrior-actions';

@Injectable()
export class FighterActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly sheet: CharacterSheetRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  private deps(): FighterActionDeps {
    return {
      access: this.access,
      state: this.state,
      domain: this.domain,
      sheet: this.sheet,
      mechanicalCatalog: this.mechanicalCatalog,
    };
  }

  useSecondWind(
    userId: string,
    characterId: string,
  ): Promise<SecondWindResponseDto> {
    return useSecondWindAction(this.deps(), userId, characterId);
  }

  useTacticalMind(
    userId: string,
    characterId: string,
    dto: TacticalMindDto = {},
  ): Promise<TacticalMindResponseDto> {
    return useTacticalMindAction(this.deps(), userId, characterId, dto);
  }

  useActionSurge(
    userId: string,
    characterId: string,
  ): Promise<ActionSurgeResponseDto> {
    return useActionSurgeAction(this.deps(), userId, characterId);
  }

  listBattleMasterManeuvers(userId: string, characterId: string) {
    return listBattleMasterManeuversAction(this.deps(), userId, characterId);
  }

  useBattleMasterManeuver(
    userId: string,
    characterId: string,
    dto: UseBattleMasterManeuverDto,
  ): Promise<FighterTableActionResponseDto> {
    return useBattleMasterManeuverAction(
      this.deps(),
      userId,
      characterId,
      dto,
    );
  }

  usePsiWarriorAction(
    userId: string,
    characterId: string,
    dto: UsePsiWarriorActionDto,
  ): Promise<FighterTableActionResponseDto> {
    return usePsiWarriorAction(this.deps(), userId, characterId, dto);
  }

  useDungeonPrecaution(
    userId: string,
    characterId: string,
    dto: UseDungeonPrecautionDto,
  ): Promise<FighterTableActionResponseDto> {
    return useDungeonPrecautionAction(this.deps(), userId, characterId, dto);
  }
}
