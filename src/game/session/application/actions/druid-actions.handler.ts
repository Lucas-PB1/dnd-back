import { BadRequestException, Injectable } from '@nestjs/common';
import { isDruidClass } from '@game/combat/domain/druid';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
  UseDruidTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { DruidActionDeps } from './druid/druid-action-deps';
import {
  resolveWildResurgenceShape,
  resolveWildResurgenceSlot,
  resolveWildShape,
} from './druid/wild-shape-actions';
import {
  resolveCityShape,
  resolveCosmicOmen,
  resolveMoonCombatWildShape,
  resolveOceanManifestation,
  resolveStarryFormArcher,
  resolveStarryFormChalice,
  resolveStarryFormDragon,
  resolveStarryFormEnd,
  resolveStellarGuidance,
  resolveWallWarp,
  resolveWrathOfTheSea,
} from './druid/subclass-actions';
import {
  resolveLunarStep,
  resolveRestoreLunarStep,
} from './druid/moon-actions';
import {
  resolveLandAid,
  resolveNaturalRecovery,
  resolveNatureSanctuary,
} from './druid/land-actions';

const NATURAL_RECOVERY_SLUGS = {
  'natural-recovery-1': 1,
  'natural-recovery-2': 2,
  'natural-recovery-3': 3,
  'natural-recovery-4': 4,
  'natural-recovery-5': 5,
} as const;

@Injectable()
export class DruidActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  private deps(): DruidActionDeps {
    return { state: this.state, domain: this.domain };
  }

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

    const deps = this.deps();
    const recoveryLevel =
      NATURAL_RECOVERY_SLUGS[
        dto.actionSlug as keyof typeof NATURAL_RECOVERY_SLUGS
      ];
    if (recoveryLevel != null) {
      return resolveNaturalRecovery(deps, character, recoveryLevel);
    }

    switch (dto.actionSlug) {
      case 'wild-shape':
        return resolveWildShape(deps, character);
      case 'wild-resurgence-slot':
        return resolveWildResurgenceSlot(deps, character);
      case 'wild-resurgence-shape':
        return resolveWildResurgenceShape(deps, character);
      case 'starry-form-archer':
        return resolveStarryFormArcher(deps, character);
      case 'starry-form-chalice':
        return resolveStarryFormChalice(deps, character);
      case 'starry-form-dragon':
        return resolveStarryFormDragon(deps, character);
      case 'starry-form-end':
        return resolveStarryFormEnd(deps, character);
      case 'stellar-guidance':
        return resolveStellarGuidance(deps, character);
      case 'cosmic-omen':
        return resolveCosmicOmen(deps, character);
      case 'wrath-of-the-sea':
        return resolveWrathOfTheSea(deps, character);
      case 'ocean-manifestation':
        return resolveOceanManifestation(deps, character);
      case 'moon-combat-wild-shape':
        return resolveMoonCombatWildShape(deps, character);
      case 'lunar-step':
        return resolveLunarStep(deps, character);
      case 'restore-lunar-step':
        return resolveRestoreLunarStep(deps, character, dto.slotLevel);
      case 'land-aid':
        return resolveLandAid(deps, character);
      case 'nature-sanctuary':
        return resolveNatureSanctuary(deps, character);
      case 'city-shape':
        return resolveCityShape(deps, character);
      case 'wall-warp':
        return resolveWallWarp(deps, character);
      default:
        throw new BadRequestException(
          `Ação de druida desconhecida: ${String(dto.actionSlug)}`,
        );
    }
  }
}
