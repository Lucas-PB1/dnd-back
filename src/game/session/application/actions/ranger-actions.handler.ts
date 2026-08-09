import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isRangerClass } from '@game/combat/domain/ranger';
import {
  TableActionResponseDto,
  UseRangerTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { RangerActionDeps } from './ranger/ranger-action-deps';
import {
  resolveHuntersMarkFree,
  resolveNaturesVeil,
  resolveTireless,
} from './ranger/base-actions';
import {
  resolveFeralHowl,
  resolveFeyReinforcements,
  resolveGloomStalkerDodge,
  resolveHunterDefense,
  resolveMistyWanderer,
  resolvePrimalCompanion,
  resolveSetBestialAspect,
} from './ranger/subclass-actions';

@Injectable()
export class RangerActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  private deps(): RangerActionDeps {
    return {
      state: this.state,
      mechanicalCatalog: this.mechanicalCatalog,
    };
  }

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

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'hunters-mark-free':
        return resolveHuntersMarkFree(deps, character);
      case 'tireless':
        return resolveTireless(deps, character);
      case 'natures-veil':
        return resolveNaturesVeil(deps, character);
      case 'fey-reinforcements':
        return resolveFeyReinforcements(deps, character);
      case 'misty-wanderer':
        return resolveMistyWanderer(deps, character);
      case 'primal-companion':
        return resolvePrimalCompanion(deps, character);
      case 'hunter-defense':
        return resolveHunterDefense(deps, character);
      case 'gloom-stalker-dodge':
        return resolveGloomStalkerDodge(deps, character);
      case 'set-bestial-aspect':
        return resolveSetBestialAspect(deps, character, dto.level);
      case 'feral-howl':
        return resolveFeralHowl(deps, character);
    }
  }
}
