import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterNotesResponseDto } from '../dto/character-notes.dto';

@Injectable()
export class GetCharacterNotesQuery {
  constructor(private readonly access: PlayerCharacterAccessService) {}

  async execute(
    userId: string,
    characterId: string,
  ): Promise<CharacterNotesResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'read',
    );
    return {
      characterId: character.id,
      notes: character.sessionNotes ?? '',
      createdAt: character.createdAt.toISOString(),
      updatedAt: character.updatedAt.toISOString(),
    };
  }
}
