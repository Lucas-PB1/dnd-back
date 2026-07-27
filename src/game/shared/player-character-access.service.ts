import { Injectable } from '@nestjs/common';
import { CharacterRepository } from './infrastructure/character.repository';
import { PlayerCharacter } from './infrastructure/player-character.entity';
import type { CharacterAccessMode } from '../campaign/infrastructure/campaign-character-access.service';

/** Acesso a `player_character` (dono ou membro de campanha). */
@Injectable()
export class PlayerCharacterAccessService {
  constructor(private readonly characters: CharacterRepository) {}

  findOwnedOrFail(userId: string, id: string): Promise<PlayerCharacter> {
    return this.characters.findOwnedOrFail(userId, id);
  }

  findAccessibleOrFail(
    userId: string,
    id: string,
    mode: CharacterAccessMode = 'write',
  ): Promise<PlayerCharacter> {
    return this.characters.findAccessibleOrFail(userId, id, mode);
  }
}
