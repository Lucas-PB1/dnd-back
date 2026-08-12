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
  resolveCoordinatedMovement,
  resolveMantleOfInspiration,
  resolveMantleOfMajesty,
  resolvePeerlessSkill,
  resolvePersonaAngel,
  resolvePersonaDevil,
  resolvePersonaDragon,
  resolvePersonaGladiator,
  resolvePersonaJester,
  resolveSetPersonaMasks,
  resolveUnarmedDance,
  resolveUnbreakableMajesty,
  resolveVirtuosoSkill,
} from './bard/subclass-actions';
import { resolveBragiRune } from './bard/northlands-bard-actions';
import { resolveDeclaredEconomyTableAction } from '../core/resolve-declared-economy-table-action';

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
      case 'peerless-skill':
        return resolvePeerlessSkill(deps, character);
      case 'mantle-of-inspiration':
        return resolveMantleOfInspiration(deps, character);
      case 'bragi-rune':
        return resolveBragiRune(deps, character);
      case 'mantle-of-majesty':
        return resolveMantleOfMajesty(deps, character);
      case 'unbreakable-majesty':
        return resolveUnbreakableMajesty(deps, character);
      case 'agile-response':
        return resolveAgileResponse(deps, character);
      case 'coordinated-movement':
        return resolveCoordinatedMovement(deps, character);
      case 'unarmed-dance':
        return resolveUnarmedDance(deps, character);
      case 'combat-inspiration':
        return resolveCombatInspiration(deps, character);
      case 'superior-inspiration':
        return resolveSuperiorInspiration(deps, character);
      case 'virtuoso-skill':
        return resolveVirtuosoSkill(deps, character);
      case 'persona-angel':
        return resolvePersonaAngel(deps, character);
      case 'persona-devil':
        return resolvePersonaDevil(deps, character);
      case 'persona-dragon':
        return resolvePersonaDragon(deps, character);
      case 'persona-gladiator':
        return resolvePersonaGladiator(deps, character);
      case 'persona-jester':
        return resolvePersonaJester(deps, character);
      case 'set-persona-masks':
        return resolveSetPersonaMasks(deps, character, dto.masks ?? []);
      default:
        return resolveDeclaredEconomyTableAction(
          { state: this.state, mechanicalCatalog: this.mechanicalCatalog },
          character,
          dto.actionSlug,
        );
    }
  }
}
