import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isBarbarianClass } from '@game/combat/domain/barbarian';
import { SyncCharacterCompanionHandler } from '@game/actor/application/sync-character-companion.handler';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseBarbarianTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { resolveDeclaredEconomyTableAction } from '../../core/resolve-declared-economy-table-action';
import {
  resolveCompanionCommand,
  resolveCompanionSummon,
} from '../shared/companion-table-actions';
import type { BarbarianActionDeps } from './barbarian-action-deps';
import {
  resolveRecoverAllRage,
  resolveToggleRage,
  resolveToggleReckless,
} from './base-actions';
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
  resolveShapeOfTheWild,
  resolveShapeOfTheWildRageRecover,
} from './subclass-actions';

@Injectable()
export class BarbarianActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly syncCompanion: SyncCharacterCompanionHandler,
    @InjectDataSource()
    private readonly dataSource: DataSource,
  ) {}

  private deps(): BarbarianActionDeps {
    return {
      access: this.access,
      state: this.state,
      domain: this.domain,
      mechanicalCatalog: this.mechanicalCatalog,
    };
  }

  private companionDeps() {
    return {
      state: this.state,
      dataSource: this.dataSource,
      syncCompanion: this.syncCompanion,
    };
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
      case 'primal-companion-summon':
        return resolveCompanionSummon(
          this.companionDeps(),
          userId,
          character,
          'pathofthe-primal-spirit',
          'Espírito Primal',
          'Invocar Companheiro Primal',
        );
      case 'primal-companion-restore':
        return resolveCompanionSummon(
          this.companionDeps(),
          userId,
          character,
          'pathofthe-primal-spirit',
          'Espírito Primal',
          'Restaurar Companheiro Primal',
          true,
        );
      case 'primal-companion':
        return resolveCompanionCommand(
          this.companionDeps(),
          character,
          'pathofthe-primal-spirit',
          'Espírito Primal',
          'Companheiro Primal',
          dto.companionCommand ?? 'strike',
        );
      case 'shape-of-the-wild':
      case 'shape-of-the-wild-action':
        return resolveShapeOfTheWild(
          deps,
          this.companionDeps(),
          userId,
          character,
        );
      case 'shape-of-the-wild-rage-recover':
        return resolveShapeOfTheWildRageRecover(deps, character);
      default:
        return resolveDeclaredEconomyTableAction(
          { state: this.state, mechanicalCatalog: this.mechanicalCatalog },
          character,
          dto.actionSlug,
        );
    }
  }
}
