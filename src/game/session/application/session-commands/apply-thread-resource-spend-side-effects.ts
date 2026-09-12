import type { DataSource } from 'typeorm';
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

const FATEBOUND_SPEND_RESOURCES = new Set([
  DOOM_DELAYED_RESOURCE,
  LAST_ACT_OF_FATE_RESOURCE,
  GLORIOUS_END_RESOURCE,
]);

export async function loadThreadSpendSideEffectNote(
  dataSource: DataSource,
  resourceSlug: string,
): Promise<string | null> {
  const rows = await dataSource.query<{ note: string | null }[]>(
    `SELECT spend_side_effect_note AS note
     FROM rpg.phb_character_thread_milestone_benefit
     WHERE benefit_key = $1
       AND spend_side_effect_note IS NOT NULL
     LIMIT 1`,
    [resourceSlug],
  );
  return rows[0]?.note?.trim() || null;
}

export async function applyThreadResourceSpendSideEffects(input: {
  dataSource: DataSource;
  state: CharacterStateRepository;
  character: PlayerCharacter;
  resourceSlug: string;
  currentState: CharacterStateResponseDto;
}): Promise<{ state: CharacterStateResponseDto; note: string | null }> {
  const { dataSource, state, character, resourceSlug, currentState } = input;

  if (!FATEBOUND_SPEND_RESOURCES.has(resourceSlug)) {
    return { state: currentState, note: null };
  }

  const note = await loadThreadSpendSideEffectNote(dataSource, resourceSlug);

  if (resourceSlug === DOOM_DELAYED_RESOURCE) {
    const next = await applyDoomDelayed(state, character);
    return { state: next, note };
  }
  if (resourceSlug === LAST_ACT_OF_FATE_RESOURCE) {
    const next = await applyLastActOfFate(state, character);
    return { state: next, note };
  }

  return { state: currentState, note };
}

async function applyDoomDelayed(
  state: CharacterStateRepository,
  character: PlayerCharacter,
): Promise<CharacterStateResponseDto> {
  const afterHp = await applyCurrentHitPoints(state, character, 0);
  const conditions = afterHp.conditions.includes(UNCONSCIOUS)
    ? afterHp.conditions
    : [...afterHp.conditions, UNCONSCIOUS];

  return state.patch(character, {
    deathSaveSuccesses: 3,
    deathSaveFailures: 0,
    conditions,
  });
}

async function applyLastActOfFate(
  state: CharacterStateRepository,
  character: PlayerCharacter,
): Promise<CharacterStateResponseDto> {
  await applyCurrentHitPoints(state, character, 1);
  return state.patch(character, {
    deathSaveSuccesses: 0,
    deathSaveFailures: 0,
    conditions: [],
  });
}
