import { BadRequestException, Injectable } from '@nestjs/common';
import { isClericClass } from '@game/combat/domain/cleric-features';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
  UseClericTableActionDto,
} from '@game/session/dto/character-state.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { ClericActionDeps } from './cleric/cleric-action-deps';
import {
  resolveDivineIntervention,
  resolveDivineSpark,
  resolvePreserveLife,
  resolveTurnUndead,
} from './cleric/base-actions';
import {
  resolveCrownOfLight,
  resolveGuidedStrike,
  resolveInvokeDuplicity,
  resolveRadianceOfDawn,
  resolveTrickstersBlessing,
  resolveWardingFlare,
  resolveWarGodsBlessing,
  resolveWarPriest,
} from './cleric/subclass-actions';

@Injectable()
export class ClericActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  private deps(): ClericActionDeps {
    return { state: this.state, domain: this.domain };
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseClericTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isClericClass(character.classSlug)) {
      throw new BadRequestException('Cleric action is not available');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'divine-spark-heal':
        return resolveDivineSpark(deps, character, 'heal');
      case 'divine-spark-damage':
        return resolveDivineSpark(deps, character, 'damage');
      case 'turn-undead':
        return resolveTurnUndead(deps, character);
      case 'divine-intervention':
        return resolveDivineIntervention(deps, character);
      case 'preserve-life':
        return resolvePreserveLife(deps, character);
      case 'radiance-of-dawn':
        return resolveRadianceOfDawn(deps, character);
      case 'warding-flare':
        return resolveWardingFlare(deps, character);
      case 'crown-of-light':
        return resolveCrownOfLight(deps, character);
      case 'tricksters-blessing':
        return resolveTrickstersBlessing(deps, character);
      case 'invoke-duplicity':
        return resolveInvokeDuplicity(deps, character);
      case 'guided-strike':
        return resolveGuidedStrike(deps, character);
      case 'war-priest':
        return resolveWarPriest(deps, character);
      case 'war-gods-blessing':
        return resolveWarGodsBlessing(deps, character);
    }
  }
}
