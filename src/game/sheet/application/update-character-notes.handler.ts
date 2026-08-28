import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import {
  CharacterNotesResponseDto,
  UpdateCharacterNotesDto,
} from '../dto/character-notes.dto';

@Injectable()
export class UpdateCharacterNotesHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    @InjectRepository(PlayerCharacter)
    private readonly characters: Repository<PlayerCharacter>,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: UpdateCharacterNotesDto,
  ): Promise<CharacterNotesResponseDto> {
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    character.sessionNotes = dto.notes.trim();
    const saved = await this.characters.save(character);
    return {
      characterId: saved.id,
      notes: saved.sessionNotes,
      createdAt: saved.createdAt.toISOString(),
      updatedAt: saved.updatedAt.toISOString(),
    };
  }
}
