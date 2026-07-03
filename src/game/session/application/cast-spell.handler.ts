import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '../../shared/player-character-access.service';
import { CharacterStateRepository } from '../infrastructure/character-state.repository';
import { CastSpellDto, CastSpellResponseDto } from '../dto/character-state.dto';

@Injectable()
export class CastSpellHandler {
  constructor(
    private readonly access: PlayerCharacterAccessService,
    private readonly state: CharacterStateRepository,
  ) {}

  async execute(
    userId: string,
    characterId: string,
    dto: CastSpellDto,
  ): Promise<CastSpellResponseDto> {
    const character = await this.access.findOwnedOrFail(userId, characterId);
    const result = await this.state.castSpell(character, dto);
    return {
      spellSlug: dto.spellSlug,
      slotLevelUsed: result.slotLevelUsed,
      state: result.state,
    };
  }
}
