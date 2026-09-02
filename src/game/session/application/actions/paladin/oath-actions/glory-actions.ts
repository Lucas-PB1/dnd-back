import { BadRequestException } from '@nestjs/common';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { assertCharacterLevel } from '@game/session/application/core/table-action-guards';
import type { PaladinTableActionResult } from '../paladin-action-deps';
import {
  CHANNEL_DIVINITY_SLUG,
  type PaladinActionDeps,
  type PlayerCharacter,
} from '../paladin-action-deps';

const GLORIOUS_DEFENSE_RESOURCE = 'glorious-defense';

/** Atleta Inigualável (Glória L3): 2º canal — Vantagem em Atletismo/Acrobacia. */
export async function resolvePeerlessAthlete(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 3, 'Paladin', 'Atleta Inigualável');
  if (character.subclassSlug !== 'glory') {
    throw new BadRequestException(
      'Atleta Inigualável requires Oath of Glory',
    );
  }
  const state = (
    await deps.state.useClassResource(character, CHANNEL_DIVINITY_SLUG, 1)
  ).state;
  return {
    state,
    actionName: 'Atleta Inigualável',
    resourceSpent: true,
    note: 'Atleta Inigualável: por 1 h, Vantagem em Força (Atletismo) e Destreza (Acrobacia); Saltos Longos e em Altura +3 m (custa movimento). (1 uso de Canalizar Divindade).',
  };
}

/** Defesa Gloriosa (Glória L15): reação — +CA (Carisma) e possível contra-ataque. */
export async function resolveGloriousDefense(
  deps: PaladinActionDeps,
  character: PlayerCharacter,
): Promise<PaladinTableActionResult> {
  assertCharacterLevel(character, 15, 'Paladin', 'Defesa Gloriosa');
  if (character.subclassSlug !== 'glory') {
    throw new BadRequestException(
      'Defesa Gloriosa requires Oath of Glory',
    );
  }
  const chaBonus = Math.max(1, abilityModifier(character.abilityScores.carisma));
  const state = (
    await deps.state.useClassResource(character, GLORIOUS_DEFENSE_RESOURCE, 1)
  ).state;
  return {
    state,
    actionName: 'Defesa Gloriosa',
    resourceSpent: true,
    note:
      `Defesa Gloriosa (−1 uso): conceda +${chaBonus} CA ao alvo contra este ataque ` +
      `(mod. de Carisma, mín. +1). Se o ataque errar e o atacante estiver no alcance da sua arma, ` +
      'você pode atacar com uma arma como parte desta Reação (mesa).',
  };
}
