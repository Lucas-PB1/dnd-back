import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateResponseDto } from '@game/session/dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

const WEREKIN_SHIFT_ASPECT = 'werekin-shift-aspect';

/** PB 5e: L1–4 → 2, L5–8 → 3, … */
export function proficiencyBonusForLevel(level: number): number {
  return 2 + Math.floor((level - 1) / 4);
}

/**
 * Efeitos colaterais ao gastar recurso de espécie (spend-resource).
 * Werekin Mudar Aspecto → Força Bestial (PV temp. = 2× PB).
 */
export async function applySpeciesResourceSpendSideEffects(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  resourceSlug: string;
  currentState: CharacterStateResponseDto;
}): Promise<{ state: CharacterStateResponseDto; note: string | null }> {
  const { state, character, resourceSlug, currentState } = input;

  if (resourceSlug !== WEREKIN_SHIFT_ASPECT) {
    return { state: currentState, note: null };
  }

  if (character.speciesSlug !== 'werekin') {
    return { state: currentState, note: null };
  }

  const tempHp = 2 * proficiencyBonusForLevel(character.level);
  const next = await applyTemporaryHitPoints(state, character, tempHp);
  return {
    state: next,
    note: `Mudar Aspecto — Força Bestial: ${tempHp} PV temp. (2× PB) aplicados. Selvageria Primal / Caçador Veloz: declare na mesa e ignore estes PV temp. se não for Força Bestial.`,
  };
}
