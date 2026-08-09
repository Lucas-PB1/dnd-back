import {
  BEGUILING_DEFENSES_RESOURCE,
  CLAIRVOYANT_COMBATANT_RESOURCE,
  FEY_STEPS_RESOURCE,
  HURL_THROUGH_HELL_RESOURCE,
  SEARING_VENGEANCE_RESOURCE,
} from '@game/combat/domain/warlock';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type { WarlockTableActionResult } from './warlock-action-deps';
import type { PlayerCharacter, WarlockActionDeps } from './warlock-action-deps';

export async function resolveFeyStepEffect(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'archfey', 'Patrono Arquifada');
  assertCharacterLevel(character, 3, 'Bruxo', 'Passos Feéricos');

  const { state } = await deps.state.useClassResource(
    character,
    FEY_STEPS_RESOURCE,
    1,
  );

  const level = character.level;
  const effectsL3 = 'Provocante ou Revigorante';
  const effectsL6 = 'Provocante, Revigorante, Desvanecedor ou Terrível';

  return {
    state,
    actionName: 'Passos Feéricos',
    resourceSpent: true,
    note:
      `Passos Feéricos (−1 uso): conjure Passo Nebuloso sem gastar espaço. ` +
      `Escolha o efeito na mesa: ${level >= 6 ? effectsL6 : effectsL3}.`,
  };
}

export async function resolveAwakenedMind(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'great-old-one', 'Patrono Grande Antigo');
  assertCharacterLevel(character, 3, 'Bruxo', 'Mente Desperta');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Mente Desperta',
    resourceSpent: false,
    note:
      'Mente Desperta: telepatia a 9 m. Magias Psíquicas: dano de Bruxo pode ser Psíquico; Encantamento/Ilusão sem V/S.',
  };
}

export async function resolveFiendishResilience(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'fiend', 'Patrono Ínfero');
  assertCharacterLevel(character, 10, 'Bruxo', 'Resistência Ínfera');

  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Resistência Ínfera',
    resourceSpent: false,
    note:
      'Resistência Ínfera: após Descanso Curto ou Longo, escolha um tipo de dano (exceto Energético) para Resistência até escolher outro.',
  };
}

export async function resolveHurlThroughHell(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'fiend', 'Patrono Ínfero');
  assertCharacterLevel(character, 14, 'Bruxo', 'Lançar no Inferno');

  const result = rollDamageParts('8d10', 0);
  const { state } = await deps.state.useClassResource(
    character,
    HURL_THROUGH_HELL_RESOURCE,
    1,
  );

  return {
    state,
    actionName: 'Lançar no Inferno',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note:
      `Lançar no Inferno: ao acertar uma criatura, ela faz salvaguarda de Carisma. ` +
      `Em falha, some ${result.total} de dano Psíquico (${result.expression}) e fica Incapacitada até o fim do seu próximo turno. ` +
      'Pode recuperar o uso gastando um Slot de Pacto.',
  };
}

export async function resolveSearingVengeance(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'celestial', 'Patrono Celestial');
  assertCharacterLevel(character, 14, 'Bruxo', 'Vingança Calcinante');

  const cha = abilityModifier(character.abilityScores.carisma);
  const result = rollDamageParts('2d8', cha);
  const { state } = await deps.state.useClassResource(
    character,
    SEARING_VENGEANCE_RESOURCE,
    1,
  );

  return {
    state,
    actionName: 'Vingança Calcinante',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note:
      `Vingança Calcinante (−1 uso): quando você ou um aliado a 18 m estiver prestes a fazer salvaguarda contra morte, ` +
      `a criatura restaura metade dos PV máximos e pode encerrar Caído; inimigos à sua escolha sofrem ${result.total} Radiante (${result.expression}) e ficam Cegos até o fim do seu próximo turno.`,
  };
}

export async function resolveBeguilingDefenses(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'archfey', 'Patrono Arquifada');
  assertCharacterLevel(character, 10, 'Bruxo', 'Defesas Sedutoras');

  const { state } = await deps.state.useClassResource(
    character,
    BEGUILING_DEFENSES_RESOURCE,
    1,
  );

  return {
    state,
    actionName: 'Defesas Sedutoras',
    resourceSpent: true,
    note:
      'Defesas Sedutoras (−1 uso): você é imune a Enfeitiçado. Reação imediatamente após ser acertado: reduza o dano pela metade ' +
      'e force o atacante a salvaguarda de Sabedoria; em falha, ele sofre dano Psíquico igual ao dano que você sofreu. ' +
      'Recarrega em Descanso Longo ou ao gastar um Slot de Pacto (sem ação).',
  };
}

export async function resolveClairvoyantCombatant(
  deps: WarlockActionDeps,
  character: PlayerCharacter,
): Promise<WarlockTableActionResult> {
  assertCharacterSubclass(character, 'great-old-one', 'Patrono Grande Antigo');
  assertCharacterLevel(character, 6, 'Bruxo', 'Combatente Clarividente');

  const { state } = await deps.state.useClassResource(
    character,
    CLAIRVOYANT_COMBATANT_RESOURCE,
    1,
  );

  return {
    state,
    actionName: 'Combatente Clarividente',
    resourceSpent: true,
    note:
      'Combatente Clarividente (−1 uso): ao formar ligação telepática com Mente Desperta, o alvo faz salvaguarda de Sabedoria. ' +
      'Em falha, tem Desvantagem em ataques contra você e você tem Vantagem em ataques contra ele. ' +
      'Recarrega em Descanso Curto ou Longo, ou ao gastar um Slot de Pacto.',
  };
}
