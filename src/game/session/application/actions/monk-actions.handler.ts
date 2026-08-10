import { BadRequestException, Injectable } from '@nestjs/common';
import { isMonkClass } from '@game/combat/domain/monk';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
  UseMonkTableActionDto,
} from '@game/session/dto';
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
  resolveAirDash,
  resolveCloakOfShadows,
  resolveElementalAttunement,
  resolveElementalBlast,
  resolveEnergyBurst,
  resolveFlurryOfHealingAndHarm,
  resolveGuardBreaker,
  resolveHandOfHarm,
  resolveHandOfHealing,
  resolveHandOfUltimateMercy,
  resolveImprovedShadowStep,
  resolveKnockout,
  resolveOpenHandTechnique,
  resolveRecoverKnockout,
  resolveShadowArts,
  resolveShadowStep,
  resolveStreetCombo,
  resolveUppercut,
  resolveVibratingPalm,
  resolveWholenessOfBody,
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
  ): Promise<TableActionResponseDto> {
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
      case 'wholeness-of-body':
        return resolveWholenessOfBody(deps, character);
      case 'vibrating-palm':
        return resolveVibratingPalm(deps, character);
      case 'elemental-attunement':
        return resolveElementalAttunement(deps, character);
      case 'elemental-blast':
        return resolveElementalBlast(deps, character);
      case 'hand-of-healing':
        return resolveHandOfHealing(deps, character);
      case 'hand-of-harm':
        return resolveHandOfHarm(deps, character);
      case 'flurry-of-healing-and-harm':
        return resolveFlurryOfHealingAndHarm(deps, character);
      case 'hand-of-ultimate-mercy':
        return resolveHandOfUltimateMercy(deps, character);
      case 'shadow-arts':
        return resolveShadowArts(deps, character);
      case 'shadow-step':
        return resolveShadowStep(deps, character);
      case 'improved-shadow-step':
        return resolveImprovedShadowStep(deps, character);
      case 'cloak-of-shadows':
        return resolveCloakOfShadows(deps, character);
      case 'street-combo':
        return resolveStreetCombo(deps, character);
      case 'energy-burst':
        return resolveEnergyBurst(deps, character);
      case 'guard-breaker':
        return resolveGuardBreaker(deps, character);
      case 'uppercut':
        return resolveUppercut(deps, character);
      case 'air-dash':
        return resolveAirDash(deps, character);
      case 'knockout':
        return resolveKnockout(deps, character);
      case 'recover-knockout':
        return resolveRecoverKnockout(deps, character);
      default:
        throw new BadRequestException(
          `Ação de Monge desconhecida: ${dto.actionSlug as string}`,
        );
    }
  }
}
