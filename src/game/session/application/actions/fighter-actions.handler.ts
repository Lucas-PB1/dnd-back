import { BadRequestException, Injectable } from '@nestjs/common';
import { isFighterClass } from '@game/combat/domain/fighter';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { CharacterDomainService } from '@game/sheet/domain/core/character-domain.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import type {
  ActionSurgeResponseDto,
  SecondWindResponseDto,
  TableActionResponseDto,
  TacticalMindDto,
  TacticalMindResponseDto,
  UseBattleMasterManeuverDto,
  UseDungeonPrecautionDto,
  UseFighterTableActionDto,
  UsePsiWarriorActionDto,
} from '@game/session/dto';
import type { FighterActionDeps } from './fighter/fighter-action-deps';
import {
  useActionSurgeAction,
  useSecondWindAction,
  useTacticalMindAction,
} from './fighter/core-actions';
import {
  listBattleMasterManeuversAction,
  useBattleMasterManeuverAction,
} from './fighter/battle-master-actions';
import { useDungeonPrecautionAction } from './fighter/dungeoneer-actions';
import { usePsiWarriorAction } from './fighter/psi-warrior-actions';

const PSI_PREFIX = 'psi:';

@Injectable()
export class FighterActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly domain: CharacterDomainService,
    private readonly sheet: CharacterSheetRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
  ) {}

  private deps(): FighterActionDeps {
    return {
      access: this.access,
      state: this.state,
      domain: this.domain,
      sheet: this.sheet,
      mechanicalCatalog: this.mechanicalCatalog,
    };
  }

  listBattleMasterManeuvers(userId: string, characterId: string) {
    return listBattleMasterManeuversAction(this.deps(), userId, characterId);
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseFighterTableActionDto,
  ): Promise<TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isFighterClass(character.classSlug)) {
      throw new BadRequestException('Fighter action is not available');
    }

    const deps = this.deps();
    const slug = dto.actionSlug;

    if (slug.startsWith(PSI_PREFIX)) {
      const psiSlug = slug.slice(PSI_PREFIX.length) as UsePsiWarriorActionDto['actionSlug'];
      return usePsiWarriorAction(deps, userId, characterId, {
        actionSlug: psiSlug,
        usePsiDie: dto.usePsiDie,
      });
    }

    switch (slug) {
      case 'second-wind': {
        const result = await useSecondWindAction(deps, userId, characterId);
        return mapSecondWind(result);
      }
      case 'action-surge': {
        const result = await useActionSurgeAction(deps, userId, characterId);
        return mapActionSurge(result);
      }
      case 'tactical-mind': {
        const mindDto: TacticalMindDto = {
          checkTotal: dto.checkTotal,
          dc: dto.dc,
        };
        const result = await useTacticalMindAction(
          deps,
          userId,
          characterId,
          mindDto,
        );
        return mapTacticalMind(result);
      }
      case 'use-maneuver': {
        if (!dto.maneuverSlug) {
          throw new BadRequestException('maneuverSlug é obrigatório');
        }
        const maneuverDto: UseBattleMasterManeuverDto = {
          maneuverSlug: dto.maneuverSlug,
          useRelentless: dto.useRelentless,
        };
        return useBattleMasterManeuverAction(
          deps,
          userId,
          characterId,
          maneuverDto,
        );
      }
      case 'dungeon-precaution': {
        if (!dto.spellSlug) {
          throw new BadRequestException('spellSlug é obrigatório');
        }
        const precautionDto: UseDungeonPrecautionDto = {
          spellSlug: dto.spellSlug,
        };
        return useDungeonPrecautionAction(
          deps,
          userId,
          characterId,
          precautionDto,
        );
      }
      default:
        throw new BadRequestException(`Ação de Guerreiro desconhecida: ${slug}`);
    }
  }
}

function mapSecondWind(result: SecondWindResponseDto): TableActionResponseDto {
  const note =
    result.note != null && result.note.length > 0
      ? `Recuperar Fôlego: ${result.expression} → +${result.healAmount} PV · ${result.note}`
      : `Recuperar Fôlego: ${result.expression} → +${result.healAmount} PV`;
  return {
    state: result.state,
    actionName: 'Recuperar Fôlego',
    expression: result.expression,
    total: result.healAmount,
    resourceSpent: true,
    note,
  };
}

function mapActionSurge(
  result: ActionSurgeResponseDto,
): TableActionResponseDto {
  return {
    state: result.state,
    actionName: 'Surto de Ação',
    resourceSpent: true,
    note: result.note,
  };
}

function mapTacticalMind(
  result: TacticalMindResponseDto,
): TableActionResponseDto {
  return {
    state: result.state,
    actionName: 'Mente Tática',
    expression: result.expression,
    roll: result.roll,
    total: result.newTotal,
    resourceSpent: result.resourceSpent,
    note: result.note,
  };
}
