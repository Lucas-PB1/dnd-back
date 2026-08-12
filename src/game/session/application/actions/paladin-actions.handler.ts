import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isPaladinClass } from '@game/combat/domain/paladin';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  TableActionResponseDto,
  UsePaladinTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { resolveDeclaredEconomyTableAction } from '../core/resolve-declared-economy-table-action';
import type { PaladinActionDeps } from './paladin/paladin-action-deps';
import {
  resolveAbjureEnemies,
  resolveCurePoison,
  resolveDivineSense,
  resolveLayOnHands,
} from './paladin/base-actions';
import {
  resolveGloriousDefense,
  resolveInspiringSmite,
  resolveOathChannel,
  resolvePeerlessAthlete,
  resolveReveler,
  resolveUndyingSentinel,
} from './paladin/oath-actions';

@Injectable()
export class PaladinActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  private deps(): PaladinActionDeps {
    return {
      access: this.access,
      state: this.state,
      domain: this.domain,
    };
  }

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

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'lay-on-hands':
        return resolveLayOnHands(deps, character, dto.amount);
      case 'cure-poison':
        return resolveCurePoison(deps, character);
      case 'divine-sense':
        return resolveDivineSense(deps, character);
      case 'abjure-enemies':
        return resolveAbjureEnemies(deps, character);
      case 'oath-channel':
        return resolveOathChannel(deps, character);
      case 'inspiring-smite':
        return resolveInspiringSmite(deps, character);
      case 'peerless-athlete':
        return resolvePeerlessAthlete(deps, character);
      case 'glorious-defense':
        return resolveGloriousDefense(deps, character);
      case 'undying-sentinel':
        return resolveUndyingSentinel(deps, character);
      case 'reveler':
        return resolveReveler(deps, character);
      default:
        return resolveDeclaredEconomyTableAction(
          { state: this.state, mechanicalCatalog: this.mechanicalCatalog },
          character,
          dto.actionSlug,
        );
    }
  }
}
