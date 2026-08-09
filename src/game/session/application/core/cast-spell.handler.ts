import { Injectable } from '@nestjs/common';
import { PlayerCharacterAccessService } from '@game/shared/player-character-access.service';
import { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import { CastSpellDto, CastSpellResponseDto } from '@game/session/dto/character-state.dto';

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
    const character = await this.access.findAccessibleOrFail(
      userId,
      characterId,
      'write',
    );
    const result = await this.state.castSpell(character, dto);
    return {
      spellSlug: dto.spellSlug,
      slotLevelUsed: result.slotLevelUsed,
      note: result.note,
      state: result.state,
    };
  }
}
