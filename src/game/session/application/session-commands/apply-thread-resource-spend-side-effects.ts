import type { DataSource } from 'typeorm';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { CharacterStateResponseDto } from '@game/session/dto/core/character-state-response.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';
import {
  applyDoomDelayedSheet,
  applyExtremeLoyaltySheet,
  applyLastActOfFateSheet,
  applyTenacitySheet,
  applyUndyingLoyaltySheet,
} from './apply-thread-sheet-spend';

export const DOOM_DELAYED_RESOURCE = 'doom-delayed';
export const LAST_ACT_OF_FATE_RESOURCE = 'last-act-of-fate';
export const GLORIOUS_END_RESOURCE = 'glorious-end';
export const TENACITY_RESOURCE = 'tenacity';
export const EXTREME_LOYALTY_RESOURCE = 'extreme-loyalty';
export const UNDYING_LOYALTY_RESOURCE = 'undying-loyalty';

const SHEET_SPEND_RESOURCES = new Set([
  DOOM_DELAYED_RESOURCE,
  LAST_ACT_OF_FATE_RESOURCE,
  GLORIOUS_END_RESOURCE,
  TENACITY_RESOURCE,
  EXTREME_LOYALTY_RESOURCE,
  UNDYING_LOYALTY_RESOURCE,
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

  if (!SHEET_SPEND_RESOURCES.has(resourceSlug)) {
    return { state: currentState, note: null };
  }

  const note = await loadThreadSpendSideEffectNote(dataSource, resourceSlug);

  if (resourceSlug === DOOM_DELAYED_RESOURCE) {
    return { state: await applyDoomDelayedSheet(state, character), note };
  }
  if (resourceSlug === LAST_ACT_OF_FATE_RESOURCE) {
    return { state: await applyLastActOfFateSheet(state, character), note };
  }
  if (resourceSlug === TENACITY_RESOURCE) {
    return {
      state: await applyTenacitySheet(state, character, currentState),
      note,
    };
  }
  if (resourceSlug === EXTREME_LOYALTY_RESOURCE) {
    return {
      state: await applyExtremeLoyaltySheet(state, character, currentState),
      note,
    };
  }
  if (resourceSlug === UNDYING_LOYALTY_RESOURCE) {
    return { state: await applyUndyingLoyaltySheet(state, character), note };
  }

  return { state: currentState, note };
}
