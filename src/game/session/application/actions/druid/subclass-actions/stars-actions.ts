import { BadRequestException } from '@nestjs/common';
import { starryFormDice } from '@game/combat/domain/druid';
import {
  type StellarConstellation,
  stellarConstellationLabel,
} from '@game/combat/domain/druid/starry-form-state';
import { rollDamageParts } from '@game/dice/domain/dice';
import { abilityModifier } from '@game/sheet/domain/stats/ability-modifier';
import {
  assertCharacterLevel,
  assertCharacterSubclass,
} from '@game/session/application/core/table-action-guards';
import type {
  DruidActionDeps,
  DruidTableActionResult,
  PlayerCharacter,
} from '../druid-action-deps';
import { spendWildShape } from '../druid-action-deps';

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

  if (alreadyActive && !sameConstellation && character.level < 10) {
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
