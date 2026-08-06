import { BadRequestException, Injectable } from '@nestjs/common';
import { isPaladinClass } from '../../../combat/domain/paladin-features';
import { CharacterDomainService } from '../../../sheet/domain/core/character-domain.service';
import { PlayerCharacterAccessService } from '../../../shared/player-character-access.service';
import {
  FighterTableActionResponseDto,
  UsePaladinTableActionDto,
} from '../../dto/character-state.dto';
import { CharacterStateRepository } from '../../infrastructure/character-state.repository';
import type { PaladinActionDeps } from './paladin/paladin-action-deps';
import {
  resolveAbjureEnemies,
  resolveCurePoison,
  resolveDivineSense,
  resolveLayOnHands,
} from './paladin/base-actions';
import { resolveOathChannel } from './paladin/oath-actions';

@Injectable()
export class PaladinActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
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
  ): Promise<FighterTableActionResponseDto> {
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
    }
  }
}
