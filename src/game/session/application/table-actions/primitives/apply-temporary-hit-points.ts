import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';


export async function applyTemporaryHitPoints(
  stateRepo: CharacterStateRepository,
  character: PlayerCharacter,
  amount: number,
): Promise<CharacterStateResponseDto> {
  const current = (await stateRepo.buildResponse(character)).tempHp ?? 0;
  return stateRepo.patch(character, {
    tempHp: Math.max(current, amount),
  });
}
