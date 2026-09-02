import { rollDamageParts } from '@game/dice/domain/dice';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  DruidActionDeps,
  DruidTableActionResult,
  PlayerCharacter,
} from '../druid-action-deps';
import { spendNamedResource } from '../druid-action-deps';

const STELLAR_GUIDANCE_SLUG = 'stellar-guidance';
const COSMIC_OMEN_SLUG = 'cosmic-omen';

export async function resolveStellarGuidance(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
  assertCharacterLevel(character, 3, 'Druida', 'Mapa Estelar');
  const state = await spendNamedResource(
    deps,
    character,
    STELLAR_GUIDANCE_SLUG,
  );

  return {
    state,
    actionName: 'Mapa Estelar (Raio Guia)',
    resourceSpent: true,
    note: 'Mapa Estelar: gaste 1 uso — conjure Raio Guia sem espaço de magia (ataque mágico; mesa).',
  };
}

export async function resolveCosmicOmen(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
  assertCharacterLevel(character, 6, 'Druida', 'Presságio Cósmico');
  const result = rollDamageParts('1d6', 0);
  const state = await spendNamedResource(deps, character, COSMIC_OMEN_SLUG);

  return {
    state,
    actionName: 'Presságio Cósmico',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Presságio Cósmico: Reação — ${result.total} (${result.expression}). Some (Prosperidade/par) ou subtraia (Infortúnio/ímpar) ao Teste de D20 de uma criatura a 9 m, conforme o presságio do Descanso Longo.`,
  };
}
