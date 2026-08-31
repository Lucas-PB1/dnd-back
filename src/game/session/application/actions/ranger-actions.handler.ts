import { BadRequestException, Injectable } from '@nestjs/common';
import { InjectDataSource } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isRangerClass } from '@game/combat/domain/ranger';
import { SyncCharacterCompanionHandler } from '@game/actor/application/sync-character-companion.handler';
import {
  TableActionResponseDto,
  UseRangerTableActionDto,
} from '@game/session/dto';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { resolveDeclaredEconomyTableAction } from '../core/resolve-declared-economy-table-action';
import {
  resolveCompanionCommand,
  resolveCompanionSummon,
} from './shared/companion-table-actions';
import type { RangerActionDeps } from './ranger/ranger-action-deps';
import {
  resolveFeralHowl,
  resolveFeyReinforcements,
  resolveGloomStalkerDodge,
  resolveHunterDefense,
  resolveMistyWanderer,
  resolveSetBestialAspect,
} from './ranger/subclass-actions';
import {
  resolveHuntersMarkFree,
  resolveNaturesVeil,
  resolveTireless,
} from './ranger/base-actions';

@Injectable()
export class RangerActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly syncCompanion: SyncCharacterCompanionHandler,
    @InjectDataSource()
    private readonly dataSource: DataSource,
  ) {}

  private deps(): RangerActionDeps {
    return {
      state: this.state,
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
    dto: UseRangerTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isRangerClass(character.classSlug)) {
      throw new BadRequestException('Ranger action is not available');
    }

    const deps = this.deps();
    const companionDeps = this.companionDeps();
    switch (dto.actionSlug) {
      case 'hunters-mark-free':
        return resolveHuntersMarkFree(deps, character);
      case 'tireless':
        return resolveTireless(deps, character);
      case 'natures-veil':
        return resolveNaturesVeil(deps, character);
      case 'fey-reinforcements':
        return resolveFeyReinforcements(deps, character);
      case 'misty-wanderer':
        return resolveMistyWanderer(deps, character);
      case 'primal-companion-summon':
        return resolveCompanionSummon(
          companionDeps,
          userId,
          character,
          'beast-master',
          'Senhor das Feras',
          'Invocar Companheiro Primal',
        );
      case 'primal-companion-restore':
        return resolveCompanionSummon(
          companionDeps,
          userId,
          character,
          'beast-master',
          'Senhor das Feras',
          'Restaurar Companheiro Primal',
          true,
        );
      case 'primal-companion':
        return resolveCompanionCommand(
          companionDeps,
          character,
          'beast-master',
          'Senhor das Feras',
          'Companheiro Primal',
          dto.companionCommand ?? 'strike',
        );
      case 'hunter-defense':
        return resolveHunterDefense(deps, character);
      case 'gloom-stalker-dodge':
        return resolveGloomStalkerDodge(deps, character);
      case 'set-bestial-aspect':
        return resolveSetBestialAspect(deps, character, dto.level);
      case 'feral-howl':
        return resolveFeralHowl(deps, character);
      default:
        return resolveDeclaredEconomyTableAction(
          deps,
          character,
          dto.actionSlug,
        );
    }
  }
}
