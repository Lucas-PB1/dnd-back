import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isBardClass } from '@game/combat/domain/bard';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
  UseBardTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { BardActionDeps } from './bard/bard-action-deps';
import {
  resolveCombatInspiration,
  resolveCuttingWords,
  resolveGrantInspiration,
  resolveSuperiorInspiration,
} from './bard/inspiration-actions';
import {
  resolveAgileResponse,
  resolveEnthrallingPerformance,
  resolveSetPersonaMasks,
  resolveUnarmedDance,
} from './bard/subclass-actions';

@Injectable()
export class BardActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  private deps(): BardActionDeps {
    return {
      access: this.access,
      state: this.state,
      domain: this.domain,
      mechanicalCatalog: this.mechanicalCatalog,
    };
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseBardTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isBardClass(character.classSlug)) {
      throw new BadRequestException('Bard action is not available');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'grant-inspiration':
        return resolveGrantInspiration(deps, character);
      case 'cutting-words':
        return resolveCuttingWords(deps, character);
      case 'enthralling-performance':
        return resolveEnthrallingPerformance(deps, character);
      case 'agile-response':
        return resolveAgileResponse(deps, character);
      case 'unarmed-dance':
        return resolveUnarmedDance(deps, character);
      case 'combat-inspiration':
        return resolveCombatInspiration(deps, character);
      case 'superior-inspiration':
        return resolveSuperiorInspiration(deps, character);
      case 'set-persona-masks':
        return resolveSetPersonaMasks(deps, character, dto.masks ?? []);
    }
  }
}
