import { Injectable } from '@nestjs/common';
import { listBattleMasterManeuvers } from '../../combat/domain/battle-master-maneuvers';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import {
  ActionSurgeResponseDto,
  SecondWindResponseDto,
  TacticalMindDto,
  TacticalMindResponseDto,
} from '../dto/character-state.dto';

@Injectable()
export class FighterActionsHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
  ) {}

  async useSecondWind(
    userId: string,
    characterId: string,
  ): Promise<SecondWindResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.useSecondWind(character);
  }

  async useTacticalMind(
    userId: string,
    characterId: string,
    dto: TacticalMindDto,
  ): Promise<TacticalMindResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.useTacticalMind(character, dto.checkTotal, dto.dc);
  }

  async useActionSurge(
    userId: string,
    characterId: string,
  ): Promise<ActionSurgeResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    return this.state.useActionSurge(character);
  }

  async listBattleMasterManeuvers(userId: string, characterId: string) {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    if (
      character.classSlug !== 'fighter' ||
      character.subclassSlug !== 'battle-master' ||
      character.level < 3
    ) {
      return [];
    }
    return listBattleMasterManeuvers();
  }
}
