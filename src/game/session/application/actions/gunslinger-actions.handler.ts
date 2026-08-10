import { BadRequestException, Injectable } from '@nestjs/common';
import { isGunslingerClass } from '@game/combat/domain/gunslinger';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  CharacterStateResponseDto,
  FireChamberDto,
  ReloadFirearmDto,
  TableActionResponseDto,
  UseGunslingerTableActionDto,
  UseManeuverDto,
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

  async useManeuver(
    userId: string,
    characterId: string,
    dto: UseManeuverDto,
  ): Promise<UseManeuverResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.martial.useManeuver(character, dto.maneuverSlug);
  }

  async reloadFirearm(
    userId: string,
    characterId: string,
    dto: ReloadFirearmDto,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.martial.reloadFirearm(character, dto.itemSlug);
  }

  async fireChamber(
    userId: string,
    characterId: string,
    dto: FireChamberDto,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.martial.fireChamber(
      character,
      dto.itemSlug,
      dto.shots ?? 1,
    );
  }

  /** Gambito Terrível (nv.15): recupera 1 Dado de Risco (marca de mesa). */
  async recoverRisk(
    userId: string,
    characterId: string,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (!isGunslingerClass(character.classSlug) || character.level < 15) {
      return this.state.buildResponse(character);
    }
    return this.state.recoverClassResource(character, 'risk', 1);
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
      default:
        throw new BadRequestException(
          `Ação de Pistoleiro desconhecida: ${dto.actionSlug as string}`,
        );
    }
  }
}
