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
} from '../../primitives/table-action-guards';
import type { PlayerCharacter } from '@game/shared/infrastructure/player-character.entity';
import type { TableActionResponseDto } from '@game/session/dto/fighter/fighter-session.dto';
import type { CharacterStateRepository } from '@game/session/infrastructure/character-state.repository';

const CONSTELLATION_BY_SLUG: Record<string, StellarConstellation> = {
  'starry-form-archer': 'archer',
  'starry-form-chalice': 'chalice',
  'starry-form-dragon': 'dragon',
};

async function spendWildShape(
  state: CharacterStateRepository,
  character: PlayerCharacter,
  amount = 1,
) {
  return (
    await state.useClassResource(character, 'wildShape', amount)
  ).state;
}

async function resolveStarryFormActivation(
  state: CharacterStateRepository,
  character: PlayerCharacter,
  constellation: StellarConstellation,
) {
  const before = await state.buildResponse(character);
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
      'Troque a constelação da Forma Estelada somente a partir do nível 10',
    );
  }

  await spendWildShape(state, character);
  const patched = await state.setStarryForm(character, {
    active: true,
    constellation,
  });

  return {
    state: patched,
    spentWildShape: true,
    swappedConstellation: alreadyActive && !sameConstellation,
  };
}

export async function applySetStarryFormTableAction(input: {
  state: CharacterStateRepository;
  character: PlayerCharacter;
  actionSlug: string;
}): Promise<TableActionResponseDto> {
  assertCharacterSubclass(input.character, 'stars', 'Círculo das Estrelas');

  if (input.actionSlug === 'starry-form-end') {
    const state = await input.state.setStarryForm(input.character, {
      active: false,
      constellation: null,
    });
    return {
      state,
      actionName: 'Encerrar Forma Estelada',
      resourceSpent: false,
      note: 'Forma Estelada encerrada na ficha.',
    };
  }

  const constellation = CONSTELLATION_BY_SLUG[input.actionSlug];
  if (!constellation) {
    throw new BadRequestException(
      `Forma Estelar desconhecida: ${input.actionSlug}`,
    );
  }

  assertCharacterLevel(
    input.character,
    3,
    'Druida',
    `Forma Estelar (${stellarConstellationLabel(constellation)})`,
  );

  const activation = await resolveStarryFormActivation(
    input.state,
    input.character,
    constellation,
  );
  const label = stellarConstellationLabel(constellation);
  const swapNote = activation.swappedConstellation
    ? ` Constelação trocada para ${label}.`
    : '';
  const enterNote = activation.spentWildShape
    ? ` Forma dura 10 min.${swapNote}`
    : ` Forma Estelada (${label}) ainda ativa.`;

  if (constellation === 'archer' || constellation === 'chalice') {
    const wisdom = abilityModifier(input.character.abilityScores.sabedoria);
    const dice = starryFormDice(input.character.level);
    const result = rollDamageParts(dice, wisdom);
    const featureLabel =
      constellation === 'archer'
        ? 'ataque mágico à distância 18 m causando dano radiante'
        : 'ao conjurar magia de cura com espaço, você ou criatura a 9 m recupera PV extras';
    return {
      state: activation.state,
      actionName: `Forma Estelar: ${label}`,
      expression: result.expression,
      total: result.total,
      resourceSpent: activation.spentWildShape,
      note: `Forma Estelar (${label}): ${featureLabel} — ${result.total} (${result.expression}).${enterNote}`,
    };
  }

  const flightNote =
    input.character.level >= 10
      ? ' L10+: Deslocamento de Voo 6 m e pairar.'
      : '';

  return {
    state: activation.state,
    actionName: `Forma Estelar: ${label}`,
    resourceSpent: activation.spentWildShape,
    note: `Forma Estelar (${label}): em testes de Inteligência/Sabedoria ou salvaguarda de Concentração, d20 menor que 10 torna-se 10.${flightNote}${enterNote}`,
  };
}
