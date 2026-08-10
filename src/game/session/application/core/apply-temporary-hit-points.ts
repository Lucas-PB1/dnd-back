import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateResponseDto } from '@game/session/dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

/**
 * PV temporários na ficha: fica o maior entre o atual e o novo (5e).
 * Usar quando a ação concede PV temp. a si mesmo; se for aliado/distribuição,
 * ainda aplica na ficha do personagem e a nota pede ajuste manual.
 */
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
