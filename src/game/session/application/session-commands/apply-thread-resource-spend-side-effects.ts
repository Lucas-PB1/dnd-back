import { applyCurrentHitPoints } from '../table-actions/primitives/apply-current-hit-points';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type {
  CharacterStateResponseDto,
} from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

export const DOOM_DELAYED_RESOURCE = 'doom-delayed';
export const LAST_ACT_OF_FATE_RESOURCE = 'last-act-of-fate';
export const GLORIOUS_END_RESOURCE = 'glorious-end';

const UNCONSCIOUS = 'unconscious';

const LAST_ACT_NOTE =
  'Último Ato: 1 PV, condições limpas. Neste turno: imunidade + vantagem + dano +nível. Após o turno: morte permanente (mesa). Fim Glorioso: aliados testemunhas — vantagem em d20 por 24h.';

const GLORIOUS_END_NOTE =
  'Fim Glorioso: aliados testemunhas — vantagem em testes d20 por 24 horas.';

/**
 * Efeitos colaterais ao gastar recurso de Character Thread (spend-resource).
 */
export async function applyThreadResourceSpendSideEffects(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  resourceSlug: string;
  currentState: CharacterStateResponseDto;
}): Promise<{ state: CharacterStateResponseDto; note: string | null }> {
  const { state, character, resourceSlug, currentState } = input;

  if (resourceSlug === DOOM_DELAYED_RESOURCE) {
    return applyDoomDelayed(state, character);
  }
  if (resourceSlug === LAST_ACT_OF_FATE_RESOURCE) {
    return applyLastActOfFate(state, character);
  }
  if (resourceSlug === GLORIOUS_END_RESOURCE) {
    return { state: currentState, note: GLORIOUS_END_NOTE };
  }

  return { state: currentState, note: null };
}

async function applyDoomDelayed(
  state: CharacterStateRepository,
  character: PlayerCharacter,
): Promise<{ state: CharacterStateResponseDto; note: string }> {
  const afterHp = await applyCurrentHitPoints(state, character, 0);
  const conditions = afterHp.conditions.includes(UNCONSCIOUS)
    ? afterHp.conditions
    : [...afterHp.conditions, UNCONSCIOUS];

  const next = await state.patch(character, {
    deathSaveSuccesses: 3,
    deathSaveFailures: 0,
    conditions,
  });

  return {
    state: next,
    note: 'Ruína Adiada: estável a 0 PV (1/DL).',
  };
}

async function applyLastActOfFate(
  state: CharacterStateRepository,
  character: PlayerCharacter,
): Promise<{ state: CharacterStateResponseDto; note: string }> {
  await applyCurrentHitPoints(state, character, 1);
  const next = await state.patch(character, {
    deathSaveSuccesses: 0,
    deathSaveFailures: 0,
    conditions: [],
  });

  return {
    state: next,
    note: LAST_ACT_NOTE,
  };
}
