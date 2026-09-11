import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isMonkClass } from '@game/combat/domain/monk';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseMonkTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { MonkActionDeps } from './monk-action-deps';
import {
  resolveFlurryOfBlows,
  resolvePatientDefense,
  resolveStepOfTheWind,
  resolveStunningStrike,
} from './base-actions';
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
  resolveShadowArts,
  resolveShadowStep,
  resolveStreetCombo,
  resolveUppercut,
  resolveVibratingPalm,
  resolveWholenessOfBody,
} from './subclass-actions';
import { resolveDeclaredEconomyTableAction } from '../../core/resolve-declared-economy-table-action';

@Injectable()
export class MonkActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  private deps(): MonkActionDeps {
    return {
      state: this.state,
      domain: this.domain,
      mechanicalCatalog: this.mechanicalCatalog,
    };
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
      default:
        return resolveDeclaredEconomyTableAction(
          { state: this.state, mechanicalCatalog: this.mechanicalCatalog },
          character,
          dto.actionSlug,
        );
    }
  }
}
