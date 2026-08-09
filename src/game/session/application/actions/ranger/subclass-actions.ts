import { BadRequestException } from '@nestjs/common';
import {
  bestialAspectBenefits,
  clampBestialAspectLevel,
} from '@game/combat/domain/beastborne';
import { rollDie } from '@game/dice/domain/dice';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  PlayerCharacter,
  RangerActionDeps,
  RangerTableActionResult,
} from './ranger-action-deps';
import {
  FEY_REINFORCEMENTS_SLUG,
  MISTY_WANDERER_SLUG,
} from './ranger-action-deps';

export async function resolveSetBestialAspect(
  deps: RangerActionDeps,
  character: PlayerCharacter,
  level: number | undefined,
): Promise<RangerTableActionResult> {
  assertCharacterSubclass(character, 'beastborne', 'Beastborne');
  assertCharacterLevel(character, 3, 'Ranger', 'Aspecto Bestial');
  if (level === undefined) {
    throw new BadRequestException('Bestial aspect level is required');
  }
  const clamped = clampBestialAspectLevel(level);
  const state = await deps.state.martial.setBestialAspectLevel(
    character,
    clamped,
  );
  const catalog = await deps.mechanicalCatalog.load();
  const benefits = bestialAspectBenefits(
    catalog.beastborneAspectBenefits,
    clamped,
  );
  const benefitNote =
    benefits.length > 0
      ? ` Benefícios: ${benefits.map((b) => b.split(':')[0]).join(', ')}.`
      : '';

  return {
    state,
    actionName: 'Aspecto Bestial',
    resourceSpent: false,
    note: `Aspecto Bestial definido em ${clamped}.${benefitNote}`,
  };
}

export async function resolveFeralHowl(
  deps: RangerActionDeps,
  character: PlayerCharacter,
): Promise<RangerTableActionResult> {
  assertCharacterSubclass(character, 'beastborne', 'Beastborne');
  assertCharacterLevel(character, 7, 'Ranger', 'Uivo Feral');
  const roll = rollDie(4);
  const state = await deps.state.martial.setBestialAspectLevel(
    character,
    roll,
  );

  return {
    state,
    actionName: 'Uivo Feral',
    expression: '1d4',
    roll,
    total: roll,
    resourceSpent: false,
    note: `Uivo Feral: 1d4 = ${roll}. Aspecto Bestial definido em ${roll}.`,
  };
}

export async function resolveFeyReinforcements(
  deps: RangerActionDeps,
  character: PlayerCharacter,
): Promise<RangerTableActionResult> {
  assertCharacterSubclass(character, 'fey-wanderer', 'Andarilho Feérico');
  assertCharacterLevel(character, 11, 'Ranger', 'Reforços Feéricos');
  const state = (
    await deps.state.useClassResource(character, FEY_REINFORCEMENTS_SLUG, 1)
  ).state;
  return {
    state,
    actionName: 'Reforços Feéricos',
    resourceSpent: true,
    note: 'Reforços Feéricos: Convocar Feérico sem espaço e sem Concentração (duração 1 minuto nesta conjuração).',
  };
}

export async function resolveMistyWanderer(
  deps: RangerActionDeps,
  character: PlayerCharacter,
): Promise<RangerTableActionResult> {
  assertCharacterSubclass(character, 'fey-wanderer', 'Andarilho Feérico');
  assertCharacterLevel(character, 15, 'Ranger', 'Andarilho Nebuloso');
  const state = (
    await deps.state.useClassResource(character, MISTY_WANDERER_SLUG, 1)
  ).state;
  return {
    state,
    actionName: 'Andarilho Nebuloso',
    resourceSpent: true,
    note: 'Andarilho Nebuloso: Passo Nebuloso sem espaço; pode levar uma criatura voluntária a 1,5 m.',
  };
}

export async function resolvePrimalCompanion(
  deps: RangerActionDeps,
  character: PlayerCharacter,
): Promise<RangerTableActionResult> {
  assertCharacterSubclass(character, 'beast-master', 'Senhor das Feras');
  assertCharacterLevel(character, 3, 'Ranger', 'Companheiro Primal');
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Companheiro Primal',
    resourceSpent: false,
    note: 'Companheiro Primal: Ação Bônus para comandar a fera; na ação Atacar você pode sacrificar um ataque para o Golpe da Fera.',
  };
}
