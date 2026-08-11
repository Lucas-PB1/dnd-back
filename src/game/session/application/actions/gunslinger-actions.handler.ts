import { BadRequestException, Injectable } from '@nestjs/common';
import { isGunslingerClass } from '@game/combat/domain/gunslinger';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  TableActionResponseDto,
  UseGunslingerTableActionDto,
  UseManeuverResponseDto,
} from '@game/session/dto';

@Injectable()
export class GunslingerActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
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
    if (!isGunslingerClass(character.classSlug)) {
      throw new BadRequestException('Gunslinger action is not available');
    }

    switch (dto.actionSlug) {
      case 'use-maneuver': {
        if (!dto.maneuverSlug?.trim()) {
          throw new BadRequestException('maneuverSlug é obrigatório');
        }
        return this.state.martial.useManeuver(character, dto.maneuverSlug);
      }
      case 'recover-risk': {
        if (character.level < 15) {
          throw new BadRequestException(
            'Gambito Terrível requires Gunslinger level 15+',
          );
        }
        const state = await this.state.recoverClassResource(
          character,
          'risk',
          1,
        );
        return {
          state,
          actionName: 'Gambito Terrível',
          resourceSpent: false,
          note: 'Gambito Terrível: recuperou 1 Dado de Risco (marque quando rolar Iniciativa ou obtiver um Acerto Crítico).',
        };
      }
      case 'reload-firearm': {
        const itemSlug = requireItemSlug(dto.itemSlug);
        const state = await this.state.martial.reloadFirearm(
          character,
          itemSlug,
        );
        return {
          state,
          actionName: 'Recarregar',
          resourceSpent: false,
          note: `Recarregou ${itemSlug}.`,
        };
      }
      case 'fire-chamber': {
        const itemSlug = requireItemSlug(dto.itemSlug);
        const shots = dto.shots ?? 1;
        const state = await this.state.martial.fireChamber(
          character,
          itemSlug,
          shots,
        );
        return {
          state,
          actionName: 'Disparar',
          resourceSpent: false,
          note: `Gastou ${shots} tiro(s) de ${itemSlug}.`,
        };
      }
      default:
        throw new BadRequestException(
          `Ação de Pistoleiro desconhecida: ${dto.actionSlug as string}`,
        );
    }
  }
}

function requireItemSlug(itemSlug: string | undefined): string {
  if (!itemSlug?.trim()) {
    throw new BadRequestException('itemSlug é obrigatório');
  }
  return itemSlug.trim();
}
