import {
  rageDamageBonus,
  zealotHealingDiceCount,
} from '@game/combat/domain/barbarian';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import { BadRequestException } from '@nestjs/common';
import type {
  BarbarianActionDeps,
  BarbarianTableActionResult,
  PlayerCharacter,
} from './barbarian-action-deps';
import {
  DIVINE_FURY_DICE,
  INTIMIDATING_PRESENCE,
  RAGE_OF_THE_GODS,
  RAGE_RESOURCE,
  ZEALOUS_PRESENCE,
} from './barbarian-action-deps';

async function strengthSaveDc(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<number> {
  const proficiency = await deps.domain.getProficiencyBonus(character.level);
  return 8 + proficiency + abilityModifier(character.abilityScores.forca);
}

export async function resolveFrenzy(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'berserker', 'Berserker');
  assertCharacterLevel(character, 3, 'Bárbaro', 'Frenesi');
  const dice = rageDamageBonus(character.level);
  const result = rollDamageParts(`${dice}d6`, 0);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Frenesi',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Frenesi: com Fúria + Imprudente, +${result.total} (${result.expression}) no 1º acerto FOR deste turno (mesmo tipo da arma).`,
  };
}

export async function resolveWildHeartEagle(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'wild-heart', 'Coração Selvagem');
  assertCharacterLevel(character, 3, 'Bárbaro', 'Águia');
  const state = await deps.state.buildResponse(character);
  if (!state.rageActive) {
    throw new BadRequestException('Águia requer Fúria ativa');
  }
  return {
    state,
    actionName: 'Fúria dos Selvagens — Águia',
    resourceSpent: false,
    note: 'Águia: Ação Bônus — Correr e Desengajar (também ao ativar a Fúria como parte dessa AB).',
  };
}

export async function resolveFanaticalFocus(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 6, 'Bárbaro', 'Concentração Fanática');
  const bonus = rageDamageBonus(character.level);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Concentração Fanática',
    total: bonus,
    resourceSpent: false,
    note: `Concentração Fanática (1×/Fúria): ao falhar salvaguarda, rerrole com +${bonus} (bônus de Fúria) e use o novo resultado.`,
  };
}

export async function resolveCantripMageHand(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(
    character,
    'path-of-the-muscle-wizard',
    'Mago Musculoso',
  );
  assertCharacterLevel(character, 3, 'Bárbaro', 'Mãos Mágicas');
  const state = await deps.state.buildResponse(character);
  const meters = state.rageActive ? 3 : 1.5;
  return {
    state,
    actionName: '“Truque” — Mãos Mágicas',
    resourceSpent: false,
    note: `Mãos Mágicas: no acerto FOR, empurre o alvo (Grande ou menor) ${meters} m${state.rageActive ? ' (Fúria)' : ''}.`,
  };
}

export async function resolveCantripShockingGrasp(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(
    character,
    'path-of-the-muscle-wizard',
    'Mago Musculoso',
  );
  assertCharacterLevel(character, 3, 'Bárbaro', 'Toque Chocante');
  const state = await deps.state.buildResponse(character);
  return {
    state,
    actionName: '“Truque” — Toque Chocante',
    resourceSpent: false,
    note: state.rageActive
      ? 'Toque Chocante (Fúria): o alvo não pode fazer OA até o início do seu próximo turno.'
      : 'Toque Chocante: o alvo não pode fazer OA até o fim do turno atual.',
  };
}

export async function resolveRetaliation(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'berserker', 'Berserker');
  assertCharacterLevel(character, 10, 'Bárbaro', 'Retaliação');
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Retaliação',
    resourceSpent: false,
    note: 'Retaliação: Reação ao sofrer dano de criatura a 1,5 m — faça um ataque corpo a corpo (arma ou Desarmado).',
  };
}

export async function resolveIntimidatingPresence(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'berserker', 'Berserker');
  assertCharacterLevel(character, 14, 'Bárbaro', 'Presença Intimidante');
  const saveDc = await strengthSaveDc(deps, character);
  const state = (
    await deps.state.useClassResource(character, INTIMIDATING_PRESENCE, 1)
  ).state;
  return {
    state,
    actionName: 'Presença Intimidante',
    saveDc,
    resourceSpent: true,
    note: `Presença Intimidante: Ação Bônus — criaturas escolhidas em Emanação 9 m, CD ${saveDc} de SAB ou Amedrontadas 1 min. Restaure o uso gastando 1 Fúria (mesa: Usar Restaurar).`,
  };
}

export async function resolveRestoreIntimidatingPresence(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'berserker', 'Berserker');
  assertCharacterLevel(character, 14, 'Bárbaro', 'Presença Intimidante');
  await deps.state.useClassResource(character, RAGE_RESOURCE, 1);
  const state = await deps.state.recoverClassResource(
    character,
    INTIMIDATING_PRESENCE,
    1,
  );
  return {
    state,
    actionName: 'Restaurar Presença Intimidante',
    resourceSpent: true,
    note: 'Restaurou Presença Intimidante gastando 1 uso de Fúria.',
  };
}

export async function resolveChampionOfTheGods(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
  diceCount?: number,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 3, 'Bárbaro', 'Campeão dos Deuses');
  const maxDice = zealotHealingDiceCount(character.level);
  const spent = diceCount ?? 1;
  if (!Number.isInteger(spent) || spent < 1 || spent > maxDice) {
    throw new BadRequestException(
      `Campeão dos Deuses: escolha de 1 a ${maxDice} d12(s)`,
    );
  }
  const result = rollDamageParts(`${spent}d12`, 0);
  const state = (
    await deps.state.useClassResource(character, DIVINE_FURY_DICE, spent)
  ).state;
  return {
    state,
    actionName: 'Campeão dos Deuses',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Campeão dos Deuses: Ação Bônus — recupere ${result.total} PV (${result.expression}). Aplique na ficha.`,
  };
}

export async function resolveZealousPresence(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 10, 'Bárbaro', 'Presença Zelosa');
  const state = (
    await deps.state.useClassResource(character, ZEALOUS_PRESENCE, 1)
  ).state;
  return {
    state,
    actionName: 'Presença Zelosa',
    resourceSpent: true,
    note: 'Presença Zelosa: Ação Bônus — até 10 aliados a 18 m têm Vantagem em ataques e salvaguardas até o início do seu próximo turno. Restaure gastando 1 Fúria.',
  };
}

export async function resolveRestoreZealousPresence(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 10, 'Bárbaro', 'Presença Zelosa');
  await deps.state.useClassResource(character, RAGE_RESOURCE, 1);
  const state = await deps.state.recoverClassResource(
    character,
    ZEALOUS_PRESENCE,
    1,
  );
  return {
    state,
    actionName: 'Restaurar Presença Zelosa',
    resourceSpent: true,
    note: 'Restaurou Presença Zelosa gastando 1 uso de Fúria.',
  };
}

export async function resolveRageOfTheGods(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'zealot', 'Fanático');
  assertCharacterLevel(character, 14, 'Bárbaro', 'Fúria dos Deuses');
  const state = (
    await deps.state.useClassResource(character, RAGE_OF_THE_GODS, 1)
  ).state;
  return {
    state,
    actionName: 'Fúria dos Deuses',
    resourceSpent: true,
    note: `Fúria dos Deuses: ao ativar Fúria, forma divina 1 min — Resistência Necrótico/Psíquico/Radiante; Voo; Reação gasta Fúria para manter aliado a 9 m com ${character.level} PV.`,
  };
}

export async function resolveRevitalizingStrength(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'world-tree', 'Árvore do Mundo');
  assertCharacterLevel(character, 3, 'Bárbaro', 'Força Revigorante');
  const dice = rageDamageBonus(character.level);
  const result = rollDamageParts(`${dice}d6`, 0);
  const state = await applyTemporaryHitPoints(
    deps.state,
    character,
    result.total,
  );
  return {
    state,
    actionName: 'Força Revigorante',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Força Revigorante: no início do turno (Fúria ativa), conceda ${result.total} PV temp. (${result.expression}) a outro a 3 m. Total aplicado na ficha — ajuste se for aliado.`,
  };
}

export async function resolveBranchesOfTheTree(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'world-tree', 'Árvore do Mundo');
  assertCharacterLevel(character, 6, 'Bárbaro', 'Ramos da Árvore');
  const saveDc = await strengthSaveDc(deps, character);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Ramos da Árvore',
    saveDc,
    resourceSpent: false,
    note: `Ramos da Árvore: Reação (Fúria) — criatura a 9 m, CD ${saveDc} de FOR ou teleporta a 1,5 m de você; Deslocamento 0 até o fim do turno dela.`,
  };
}

export async function resolveTraverseTheTree(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(character, 'world-tree', 'Árvore do Mundo');
  assertCharacterLevel(character, 14, 'Bárbaro', 'Percorrer a Árvore');
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Percorrer a Árvore',
    resourceSpent: false,
    note: 'Percorrer a Árvore: teleporte até 18 m (ao entrar em Fúria ou AB enquanto ativa). 1×/Fúria: até 45 m e leve até 6 aliados a 3 m.',
  };
}

export async function resolveUndeniableMagicRage(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(
    character,
    'path-of-the-muscle-wizard',
    'Mago Musculoso',
  );
  assertCharacterLevel(character, 3, 'Bárbaro', 'Magia indiscutível');
  const state = await deps.state.martial.toggleRage(character, true, false);
  return {
    state,
    actionName: 'Magia indiscutível (Fúria)',
    resourceSpent: false,
    note: 'Magia indiscutível: Reação — entre em Fúria até o fim do seu próximo turno sem gastar uso (não estende).',
  };
}

export async function resolveCantripSureStrike(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(
    character,
    'path-of-the-muscle-wizard',
    'Mago Musculoso',
  );
  assertCharacterLevel(character, 3, 'Bárbaro', 'Ataque Certeiro');
  const before = await deps.state.buildResponse(character);
  const halfLevel = Math.floor(character.level / 2);
  const bonus = before.rageActive ? halfLevel : 0;
  const result = rollDamageParts('1d6', bonus);
  return {
    state: before,
    actionName: '“Truque” — Ataque Certeiro',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Ataque Certeiro: +${result.total} (${result.expression}) no acerto FOR${before.rageActive ? ' (Fúria: +metade do nível)' : ''}.`,
  };
}

export async function resolveBurningHandsSlap(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(
    character,
    'path-of-the-muscle-wizard',
    'Mago Musculoso',
  );
  assertCharacterLevel(character, 6, 'Bárbaro', 'Mãos Flamejantes');
  const str = abilityModifier(character.abilityScores.forca);
  const result = rollDamageParts('1d8', str);
  return {
    state: await deps.state.buildResponse(character),
    actionName: '“Magia” — Mãos Flamejantes',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Mãos Flamejantes (1×/DL enquanto Fúria): ação — Ataque Desarmado em cada criatura no alcance; no acerto ${result.total} Contundente (${result.expression}) e Desvantagem no próximo ataque dela. Marque o uso na mesa.`,
  };
}

export async function resolveMagicMissileThrows(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(
    character,
    'path-of-the-muscle-wizard',
    'Mago Musculoso',
  );
  assertCharacterLevel(character, 6, 'Bárbaro', 'Mísseis Mágicos');
  return {
    state: await deps.state.buildResponse(character),
    actionName: '“Magia” — Mísseis Mágicos',
    resourceSpent: false,
    note: 'Mísseis Mágicos (1×/DL enquanto Fúria): ação — 3 ataques à distância com arma de arremesso FOR; Vantagem (nunca erra). Marque o uso.',
  };
}

export async function resolveShieldBlock(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(
    character,
    'path-of-the-muscle-wizard',
    'Mago Musculoso',
  );
  assertCharacterLevel(character, 6, 'Bárbaro', 'Escudo');
  return {
    state: await deps.state.buildResponse(character),
    actionName: '“Magia” — Escudo',
    resourceSpent: false,
    note: `Escudo (1×/DL enquanto Fúria): Reação ao ser atingido — +CA do Escudo; se ainda acertar, reduza o dano em ${character.level}. Marque o uso.`,
  };
}

export async function resolveICastFist(
  deps: BarbarianActionDeps,
  character: PlayerCharacter,
): Promise<BarbarianTableActionResult> {
  assertCharacterSubclass(
    character,
    'path-of-the-muscle-wizard',
    'Mago Musculoso',
  );
  assertCharacterLevel(character, 14, 'Bárbaro', 'Eu lancei o punho');
  const str = abilityModifier(character.abilityScores.forca);
  const result = rollDamageParts('6d6', str);
  return {
    state: await deps.state.buildResponse(character),
    actionName: 'Eu lancei o punho',
    expression: result.expression,
    total: result.total,
    resourceSpent: false,
    note: `Eu lancei o punho (1×/Fúria): substitua um ataque — Desarmado com Vantagem; no acerto ${result.total} Contundente (${result.expression}) e Caído (Enorme ou menor).`,
  };
}
