import { BadRequestException, Injectable } from '@nestjs/common';
import { isMonkClass } from '@game/combat/domain/monk-features';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  FighterTableActionResponseDto,
  UseMonkTableActionDto,
} from '@game/session/dto/character-state.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { MonkActionDeps } from './monk/monk-action-deps';
import {
  resolveFlurryOfBlows,
  resolvePatientDefense,
  resolveStepOfTheWind,
  resolveStunningStrike,
} from './monk/base-actions';
import {
  resolveElementalBlast,
  resolveHandOfHarm,
  resolveHandOfHealing,
  resolveOpenHandTechnique,
  resolveShadowStep,
} from './monk/subclass-actions';

@Injectable()
export class MonkActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  private deps(): MonkActionDeps {
    return { state: this.state, domain: this.domain };
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseMonkTableActionDto,
  ): Promise<FighterTableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isMonkClass(character.classSlug)) {
      throw new BadRequestException('Monk action is not available');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'flurry-of-blows':
        return resolveFlurryOfBlows(deps, character);
      case 'patient-defense':
        return resolvePatientDefense(deps, character);
      case 'step-of-the-wind':
        return resolveStepOfTheWind(deps, character);
      case 'stunning-strike':
        return resolveStunningStrike(deps, character);
      case 'open-hand-technique':
        return resolveOpenHandTechnique(deps, character);
      case 'elemental-blast':
        return resolveElementalBlast(deps, character);
      case 'hand-of-healing':
        return resolveHandOfHealing(deps, character);
      case 'hand-of-harm':
        return resolveHandOfHarm(deps, character);
      case 'shadow-step':
        return resolveShadowStep(deps, character);
    }
  }
}
