import { BadRequestException, Injectable } from '@nestjs/common';
import { isWarlockClass } from '@game/combat/domain/warlock-features';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import {
  TableActionResponseDto,
  UseWarlockTableActionDto,
} from '@game/session/dto/character-state.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type { WarlockActionDeps } from './warlock/warlock-action-deps';
import {
  resolveDarkOnesOwnLuck,
  resolveHealingLight,
  resolveMagicalCunning,
} from './warlock/base-actions';
import {
  resolveAwakenedMind,
  resolveFeyStepEffect,
  resolveFiendishResilience,
} from './warlock/patron-actions';

@Injectable()
export class WarlockActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  private deps(): WarlockActionDeps {
    return {
      access: this.access,
      state: this.state,
      domain: this.domain,
    };
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseWarlockTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isWarlockClass(character.classSlug)) {
      throw new BadRequestException('Warlock action is not available');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'magical-cunning':
        return resolveMagicalCunning(deps, character);
      case 'healing-light':
        return resolveHealingLight(deps, character);
      case 'dark-ones-luck':
        return resolveDarkOnesOwnLuck(deps, character);
      case 'fey-step-effect':
        return resolveFeyStepEffect(deps, character);
      case 'awakened-mind':
        return resolveAwakenedMind(deps, character);
      case 'fiendish-resilience':
        return resolveFiendishResilience(deps, character);
    }
  }
}
