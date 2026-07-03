import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import {
  CharacterStateResponseDto,
  PatchCharacterStateDto,
} from '../dto/character-state.dto';

@Injectable()
export class PatchCharacterStateHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: PatchCharacterStateDto,
  ): Promise<CharacterStateResponseDto> {
    const character = await this.access.findOwnedOrFail(userId, characterId);
    return this.state.patch(character, dto);
  }
}
