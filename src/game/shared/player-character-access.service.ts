import { Injectable } from '@nestjs/common';
import { CharacterRepository } from './infrastructure/character.repository';
import { PlayerCharacter } from './infrastructure/player-character.entity';

/** Verifica ownership de `player_character` para submódulos que não são o sheet. */
@Injectable()
export class PlayerCharacterAccessService {
  constructor(private readonly characters: CharacterRepository) {}

  findOwnedOrFail(userId: string, id: string): Promise<PlayerCharacter> {
    return this.characters.findOwnedOrFail(userId, id);
  }
}
