import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import {
  CharacterStateResponseDto,
  FireChamberDto,
  ReloadFirearmDto,
  UseManeuverDto,
  UseManeuverResponseDto,
} from '../dto/character-state.dto';

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
    return this.state.listManeuvers(character);
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
    return this.state.useManeuver(character, dto.maneuverSlug);
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
    return this.state.reloadFirearm(character, dto.itemSlug);
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
    return this.state.fireChamber(character, dto.itemSlug, dto.shots ?? 1);
  }

  /** Gambito Terrível (nv.15): recupera 1 Dado de Risco. */
  async recoverRisk(
    userId: string,
    characterId: string,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    if (character.classSlug !== 'gunslinger' || character.level < 15) {
      return this.state.buildResponse(character);
    }
    return this.state.recoverClassResource(character, 'risk', 1);
  }
}
