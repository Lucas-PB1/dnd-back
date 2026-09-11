import { BadRequestException, Injectable } from '@nestjs/common';
import { LoadCombatMechanicalCatalog } from '@game/combat/application/load-combat-mechanical-catalog';
import { isGunslingerClass } from '@game/combat/domain/gunslinger';
import {
  canUseFirearmTableActions,
  isBlackPowderPistolSlug,
  isFirearmTableActionSlug,
} from '@game/combat/domain/feat/grim-hollow-cap4-weapon-rules';
import { LoadEffectCatalog } from '@game/effects';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterSheetRepository } from '@game/sheet/infrastructure/character-sheet.repository';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  TableActionResponseDto,
} from '@game/session/dto/fighter/fighter-session.dto';
import {
  UseGunslingerTableActionDto,
} from '@game/session/dto/table-actions/table-actions-martial.dto';
import {
  UseManeuverResponseDto,
} from '@game/session/dto/core/session-commands.dto';
import { applyDeclaredEconomyTableAction } from '../../core/apply-declared-economy-table-action';
import {
  applyFireChamberTableAction,
  applyReloadFirearmTableAction,
} from '../../core/apply-gunslinger-maneuver-table-action';

@Injectable()
export class GunslingerActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
    private readonly sheet: CharacterSheetRepository,
    private readonly mechanicalCatalog: LoadCombatMechanicalCatalog,
    private readonly effectCatalog: LoadEffectCatalog,
  ) {}

  async listManeuvers(userId: string, characterId: string) {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    return this.state.martial.listManeuvers(character);
  }

  async useTableAction(
    userId: string,
    characterId: string,
    dto: UseGunslingerTableActionDto,
  ): Promise<UseManeuverResponseDto | TableActionResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    const isGunslinger = isGunslingerClass(character.classSlug);
    if (!isGunslinger) {
      await this.assertNonGunslingerFirearmAction(character.id, dto);
      const itemSlug = dto.itemSlug!.trim();
      if (dto.actionSlug === 'reload-firearm') {
        return applyReloadFirearmTableAction({
          state: this.state,
          character,
          itemSlug,
        });
      }
      return applyFireChamberTableAction({
        state: this.state,
        character,
        itemSlug,
        shots: dto.shots ?? 1,
      });
    }

    return applyDeclaredEconomyTableAction(
      {
        state: this.state,
        mechanicalCatalog: this.mechanicalCatalog,
        effectCatalog: this.effectCatalog,
        sheet: this.sheet,
      },
      character,
      dto.actionSlug,
      {
        maneuverSlug: dto.maneuverSlug,
        itemSlug: dto.itemSlug,
        shots: dto.shots,
      },
    );
  }

  private async assertNonGunslingerFirearmAction(
    characterId: string,
    dto: UseGunslingerTableActionDto,
  ): Promise<void> {
    if (!isFirearmTableActionSlug(dto.actionSlug)) {
      throw new BadRequestException('Gunslinger action is not available');
    }
    const sheet = await this.sheet.load(characterId);
    const featSlugs = sheet.characterFeats.map((feat) => feat.featSlug);
    if (!canUseFirearmTableActions({ classSlug: '', featSlugs })) {
      throw new BadRequestException('Gunslinger action is not available');
    }
    const itemSlug = dto.itemSlug?.trim();
    if (!itemSlug) {
      throw new BadRequestException('itemSlug é obrigatório');
    }
    if (!isBlackPowderPistolSlug(itemSlug)) {
      throw new BadRequestException(
        'Ação disponível apenas para pistola de pólvora',
      );
    }
  }
}
