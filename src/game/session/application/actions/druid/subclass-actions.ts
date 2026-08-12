import { BadRequestException } from '@nestjs/common';
import {
  moonWildShapeTempHp,
  starryFormDice,
  wrathOfTheSeaRadiusMeters,
} from '@game/combat/domain/druid';
import {
  type StellarConstellation,
  stellarConstellationLabel,
} from '@game/combat/domain/druid/starry-form-state';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import { applyTemporaryHitPoints } from '@game/session/application/core/apply-temporary-hit-points';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  DruidActionDeps,
  DruidTableActionResult,
  PlayerCharacter,
} from './druid-action-deps';
import { spendNamedResource, spendWildShape } from './druid-action-deps';

const STELLAR_GUIDANCE_SLUG = 'stellar-guidance';
const COSMIC_OMEN_SLUG = 'cosmic-omen';
const WALL_WARP_SLUG = 'wall-warp';

async function resolveStarryFormActivation(
  deps: DruidActionDeps,
  character: PlayerCharacter,
  constellation: StellarConstellation,
): Promise<{
  state: DruidTableActionResult['state'];
  spentWildShape: boolean;
  swappedConstellation: boolean;
}> {
  const before = await deps.state.buildResponse(character);
  const alreadyActive = before.starryFormActive === true;
  const sameConstellation = before.stellarConstellation === constellation;

  if (alreadyActive && sameConstellation) {
    return {
      state: before,
      spentWildShape: false,
      swappedConstellation: false,
    };
  }

  if (
    alreadyActive &&
    !sameConstellation &&
    character.level < 10
  ) {
    throw new BadRequestException(
      'Troque a constelação da Forma Estrelada somente a partir do nível 10',
    );
  }

  const state = await spendWildShape(deps, character);
  const patched = await deps.state.setStarryForm(character, {
    active: true,
    constellation,
  });

  return {
    state: patched,
    spentWildShape: true,
    swappedConstellation: alreadyActive && !sameConstellation,
  };
}

async function resolveStarryForm(
  deps: DruidActionDeps,
  character: PlayerCharacter,
  constellation: StellarConstellation,
  input: {
    featureLabel: string;
    rollDamage?: boolean;
    passiveNote?: string;
  },
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
  assertCharacterLevel(
    character,
    3,
    'Druida',
    `Forma Estelar (${stellarConstellationLabel(constellation)})`,
  );

  const activation = await resolveStarryFormActivation(
    deps,
    character,
    constellation,
  );
  const label = stellarConstellationLabel(constellation);
  const swapNote = activation.swappedConstellation
    ? ` Constelação trocada para ${label}.`
    : '';
  const enterNote = activation.spentWildShape
    ? ` Forma dura 10 min.${swapNote}`
    : ` Forma Estrelada (${label}) ainda ativa.`;

  if (input.rollDamage) {
    const wisdom = abilityModifier(character.abilityScores.sabedoria);
    const dice = starryFormDice(character.level);
    const result = rollDamageParts(dice, wisdom);
    return {
      state: activation.state,
      actionName: `Forma Estelar: ${label}`,
      expression: result.expression,
      total: result.total,
      resourceSpent: activation.spentWildShape,
      note: `Forma Estelar (${label}): ${input.featureLabel} — ${result.total} (${result.expression}).${enterNote}`,
    };
  }

  const flightNote =
    constellation === 'dragon' && character.level >= 10
      ? ' L10+: Deslocamento de Voo 6 m e pairar.'
      : '';

  return {
    state: activation.state,
    actionName: `Forma Estelar: ${label}`,
    resourceSpent: activation.spentWildShape,
    note: `Forma Estelar (${label}): ${input.passiveNote ?? input.featureLabel}.${flightNote}${enterNote}`,
  };
}

export async function resolveStarryFormEnd(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'stars', 'Círculo das Estrelas');
  const state = await deps.state.setStarryForm(character, {
    active: false,
    constellation: null,
  });

  return {
    state,
    actionName: 'Encerrar Forma Estelada',
    resourceSpent: false,
    note: 'Forma Estrelada encerrada na ficha.',
  };
}

export async function resolveStarryFormArcher(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  return resolveStarryForm(deps, character, 'archer', {
    featureLabel: 'ataque mágico à distância 18 m causando dano radiante',
    rollDamage: true,
  });
}

export async function resolveStarryFormChalice(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  return resolveStarryForm(deps, character, 'chalice', {
    featureLabel:
      'ao conjurar magia de cura com espaço, você ou criatura a 9 m recupera PV extras',
    rollDamage: true,
  });
}

export async function resolveStarryFormDragon(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  return resolveStarryForm(deps, character, 'dragon', {
    featureLabel:
      'em testes de Inteligência/Sabedoria ou salvaguarda de Concentração, d20 menor que 10 torna-se 10',
    passiveNote:
      'em testes de Inteligência/Sabedoria ou salvaguarda de Concentração, d20 menor que 10 torna-se 10',
  });
}

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

export async function resolveWrathOfTheSea(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'sea', 'Círculo do Mar');
  assertCharacterLevel(character, 3, 'Druida', 'Ira do Mar');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const diceCount = Math.max(1, wisdom);
  const radius = wrathOfTheSeaRadiusMeters(character.level);
  const result = rollDamageParts(`${diceCount}d6`, 0);
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Ira do Mar',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Ira do Mar: Ação Bônus — Emanação ${radius} m por 10 min. Alvo na área: CD CON ou ${result.total} de dano Gélido (${result.expression}) e empurrão 4,5 m (Grande ou menor).`,
  };
}

export async function resolveOceanManifestation(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'sea', 'Círculo do Mar');
  assertCharacterLevel(character, 14, 'Druida', 'Manifestação Oceânica');
  const wisdom = abilityModifier(character.abilityScores.sabedoria);
  const diceCount = Math.max(1, wisdom);
  const result = rollDamageParts(`${diceCount}d6`, 0);
  const state = await spendWildShape(deps, character, 2);

  return {
    state,
    actionName: 'Manifestação Oceânica',
    expression: result.expression,
    total: result.total,
    resourceSpent: true,
    note: `Manifestação Oceânica: gaste 2 usos de Forma Selvagem — variante aprimorada da Ira do Mar (mesa). Rolagem de referência: ${result.total} Gélido (${result.expression}).`,
  };
}

export async function resolveMoonCombatWildShape(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(character, 'moon', 'Círculo da Lua');
  assertCharacterLevel(character, 3, 'Druida', 'Forma Selvagem de Combate');
  const tempHp = moonWildShapeTempHp(character.level);
  const crMax = Math.floor(character.level / 3);
  await spendWildShape(deps, character);
  const state = await applyTemporaryHitPoints(deps.state, character, tempHp);

  return {
    state,
    actionName: 'Forma Selvagem de Combate',
    resourceSpent: true,
    total: tempHp,
    note: `Forma Selvagem de Combate: ${tempHp} PV temp. (ficha), CA 13+SAB se maior, ND máx. ${crMax}. Ficha de besta = futuro.`,
  };
}

export async function resolveCityShape(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(
    character,
    'circle-of-the-city',
    'Círculo da Cidade',
  );
  assertCharacterLevel(character, 3, 'Druida', 'Forma da Cidade');
  const state = await spendWildShape(deps, character);

  return {
    state,
    actionName: 'Forma da Cidade',
    resourceSpent: true,
    note: 'Forma da Cidade: gaste 1 Forma Selvagem — conjure Fundir-se na Pedra, Passagem ou Moldar Rocha sem espaço (mesa).',
  };
}

export async function resolveWallWarp(
  deps: DruidActionDeps,
  character: PlayerCharacter,
): Promise<DruidTableActionResult> {
  assertCharacterSubclass(
    character,
    'circle-of-the-city',
    'Círculo da Cidade',
  );
  assertCharacterLevel(character, 10, 'Druida', 'Distorção de Muro');
  const state = await spendNamedResource(deps, character, WALL_WARP_SLUG);

  return {
    state,
    actionName: 'Distorção de Muro',
    resourceSpent: true,
    note: 'Distorção de Muro: Reação — painel 3×3 m de Muralha de Pedra (CA 15, 30 PV) até o fim do seu próximo turno.',
  };
}