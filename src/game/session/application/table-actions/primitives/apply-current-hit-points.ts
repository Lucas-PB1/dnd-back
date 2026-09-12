import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export async function applyCurrentHitPoints(
  stateRepo: CharacterStateRepository,
  character: PlayerCharacter,
  hitPointsCurrent: number,
): Promise<CharacterStateResponseDto> {
  return stateRepo.applyCurrentHitPoints(character, hitPointsCurrent);
}
