import { BadRequestException, Injectable } from '@nestjs/common';
import { isBarbarianClass } from '@game/combat/domain/barbarian';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  CharacterStateResponseDto,
  TableActionResponseDto,
  ToggleRageDto,
  ToggleRecklessDto,
  UseBarbarianTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import type { BarbarianActionDeps } from './barbarian/barbarian-action-deps';
import {
  resolveRecoverAllRage,
  resolveToggleRage,
  resolveToggleReckless,
} from './barbarian/base-actions';
import {
  resolveBranchesOfTheTree,
  resolveBurningHandsSlap,
  resolveCantripMageHand,
  resolveCantripShockingGrasp,
  resolveCantripSureStrike,
  resolveChampionOfTheGods,
  resolveFanaticalFocus,
  resolveFrenzy,
  resolveICastFist,
  resolveIntimidatingPresence,
  resolveMagicMissileThrows,
  resolveRageOfTheGods,
  resolveRestoreIntimidatingPresence,
  resolveRestoreZealousPresence,
  resolveRetaliation,
  resolveRevitalizingStrength,
  resolveShieldBlock,
  resolveTraverseTheTree,
  resolveUndeniableMagicRage,
  resolveWildHeartEagle,
  resolveZealousPresence,
} from './barbarian/subclass-actions';

@Injectable()
export class BarbarianActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
  ) {}

  private deps(): BarbarianActionDeps {
    return {
      access: this.access,
      state: this.state,
      domain: this.domain,
    };
  }

  /** @deprecated Prefer POST …/barbarian/table-action (toggle-rage). */
  async toggleRage(
    userId: string,
    characterId: string,
    dto: ToggleRageDto,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.martial.toggleRage(character, dto.active);
  }

  /** @deprecated Prefer POST …/barbarian/table-action (toggle-reckless). */
  async toggleReckless(
    userId: string,
    characterId: string,
    dto: ToggleRecklessDto,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.martial.toggleReckless(character, dto.active);
  }

  /** @deprecated Prefer POST …/barbarian/table-action (recover-all-rage). */
  async recoverAllRage(
    userId: string,
    characterId: string,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.martial.recoverAllRage(character);
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseBarbarianTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isBarbarianClass(character.classSlug)) {
      throw new BadRequestException('Barbarian action is not available');
    }

    const deps = this.deps();
    switch (dto.actionSlug) {
      case 'toggle-rage':
        return resolveToggleRage(deps, character);
      case 'toggle-reckless':
        return resolveToggleReckless(deps, character);
      case 'recover-all-rage':
        return resolveRecoverAllRage(deps, character);
      case 'frenzy':
        return resolveFrenzy(deps, character);
      case 'wild-heart-eagle':
        return resolveWildHeartEagle(deps, character);
      case 'fanatical-focus':
        return resolveFanaticalFocus(deps, character);
      case 'retaliation':
        return resolveRetaliation(deps, character);
      case 'intimidating-presence':
        return resolveIntimidatingPresence(deps, character);
      case 'restore-intimidating-presence':
        return resolveRestoreIntimidatingPresence(deps, character);
      case 'champion-of-the-gods':
        return resolveChampionOfTheGods(deps, character, dto.diceCount);
      case 'zealous-presence':
        return resolveZealousPresence(deps, character);
      case 'restore-zealous-presence':
        return resolveRestoreZealousPresence(deps, character);
      case 'rage-of-the-gods':
        return resolveRageOfTheGods(deps, character);
      case 'revitalizing-strength':
        return resolveRevitalizingStrength(deps, character);
      case 'branches-of-the-tree':
        return resolveBranchesOfTheTree(deps, character);
      case 'traverse-the-tree':
        return resolveTraverseTheTree(deps, character);
      case 'undeniable-magic-rage':
        return resolveUndeniableMagicRage(deps, character);
      case 'cantrip-mage-hand':
        return resolveCantripMageHand(deps, character);
      case 'cantrip-shocking-grasp':
        return resolveCantripShockingGrasp(deps, character);
      case 'cantrip-sure-strike':
        return resolveCantripSureStrike(deps, character);
      case 'burning-hands-slap':
        return resolveBurningHandsSlap(deps, character);
      case 'magic-missile-throws':
        return resolveMagicMissileThrows(deps, character);
      case 'shield-block':
        return resolveShieldBlock(deps, character);
      case 'i-cast-fist':
        return resolveICastFist(deps, character);
    }
  }
}
