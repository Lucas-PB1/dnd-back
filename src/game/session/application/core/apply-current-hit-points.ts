import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateResponseDto } from '@game/session/dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

/**
 * Atualiza PV atuais na ficha (dano/cura aplicados pelo handler) e devolve o state.
 */
export async function applyCurrentHitPoints(
  stateRepo: CharacterStateRepository,
  character: PlayerCharacter,
  hitPointsCurrent: number,
): Promise<CharacterStateResponseDto> {
  return stateRepo.applyCurrentHitPoints(character, hitPointsCurrent);
}
